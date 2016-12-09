package csjobs.web.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import csjobs.model.Application;
import csjobs.model.Degree;
import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.ApplicationDao;
import csjobs.model.dao.FileDao;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;

@Controller
@SessionAttributes("application")
public class ApplicationControllerS {

	@Autowired
	private JobDao jobDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private UserDao userDao;

	@Autowired
	private ApplicationDao applicationDao;

	@RequestMapping(value = "/application/apply.html", method = RequestMethod.GET)
	public String apply(@RequestParam(required=false) Long jobId, HttpSession session,
			ModelMap models) {
		Job job = jobDao.getJob(jobId);
		session.setAttribute("job", job);
		User applicant = (User) session.getAttribute("authenticatedUser");
		Application application = applicationDao.getApplication(job, applicant);

		if (application != null && application.isSubmitted()) {
			models.put("errorCode", "error.application.submitted");
			return "error";
		}
		if (application == null)
			application = new Application(job, applicant);
		models.put("application", application);
		return "application/apply";
	}

	@RequestMapping(value = "/application/apply.html", method = RequestMethod.POST)
	public String apply(@ModelAttribute Application application,
			SessionStatus sessionStatus, HttpSession session, ModelMap models) {
		application = applicationDao.saveApplication(application);
		// sessionStatus.setComplete();

		session.setAttribute("applicationId", application.getId());
		return "redirect:uploadCV.html";
	}

	@RequestMapping(value = "/application/addDegree.html", method = RequestMethod.GET)
	public String addDegree(HttpSession session, ModelMap models) {
		Long applicationId = (Long) session.getAttribute("applicationId");
		models.put("application", applicationDao.getApplication(applicationId));
		models.put("degree", new Degree());
		return "application/addDegree";
	}

	@RequestMapping(value = "/application/addDegree.html", method = RequestMethod.POST)
	public String addDegree(@ModelAttribute Application application,
			@ModelAttribute Degree degree, SessionStatus sessionStatus) {
		application.getDegrees().add(degree);
		application.setSubmitDate(new Date());
		application = applicationDao.saveApplication(application);

		// sessionStatus.setComplete();
		return "redirect:addDegree.html?applicationId=" + application.getId();
	}

	@RequestMapping(value = "/application.html", method = RequestMethod.GET)
	public String application(SessionStatus sessionStatus, ModelMap models,
			@RequestParam(required=false) Long applicantId, @RequestParam(required=false) Long jobId) {
		models.put("jobId", jobId);
		Application application =applicationDao.getApplication(jobDao.getJob(jobId), userDao.getUser(applicantId));
		Job job=jobDao.getJob(jobId);
		User applicant=userDao.getUser(applicantId);
		List<Degree> degree=application.getDegrees();
		
		models.put("application", application);
		models.put("job", job);
		models.put("applicant", applicant);
		models.put("degree", degree);
		return "application";
	}
}
