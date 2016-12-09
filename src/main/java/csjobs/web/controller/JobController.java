package csjobs.web.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import csjobs.model.Application;
import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.ApplicationDao;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;

@Controller
public class JobController {

	@Autowired
	private JobDao jobDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ApplicationDao applicationDao;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				new SimpleDateFormat("M/d/yyyy"), true));
	}
	@RequestMapping({ "/index.html", "/job/list.html" })
	public String list(ModelMap models) {
		models.put("openJobs", jobDao.getOpenJobs());
		return "job/list";
	}
	@RequestMapping("/job/view.html")
	public String view(@RequestParam Long id, ModelMap models,
			HttpSession session) {
		models.put("jobchair", jobDao.getJob(id).getCommitteeChair());
		List<User> jobrev = (List<User>) jobDao.getJob(id)
				.getCommitteeMembers();
		models.put("jobrev", jobrev);
		models.put("job", jobDao.getJob(id));
		return "job/view";
	}
	@RequestMapping(value = "/job/editJobs.html", method = RequestMethod.GET)
	public String editJobs(@RequestParam(required=false) Long id, ModelMap models) {

		Job j = jobDao.getJob(id);
		models.put("jobs", j);

		List<User> userReviewer = j.getCommitteeMembers();
		User chair = jobDao.getJob(id).getCommitteeChair();

		models.put("chair", chair);
		models.put("userReviewer", userReviewer);

		List<User> Allreviewers = new ArrayList<User>();

		for (User u : userDao.getUser()) {
			if (u.isReviewer()) {
				Allreviewers.add(u);
			}
		}
		models.put("Allreviewers", Allreviewers);
		return "job/editJobs";
	}

	@RequestMapping(value = "/job/editJobs.html", method = RequestMethod.POST)
	public String editJobs(ModelMap models, @RequestParam Long id,
			@RequestParam String title, @RequestParam String description,
			@RequestParam(required = false) Date publishDate,
			@RequestParam(required = false) Date closeDate,
			@RequestParam(required = false) Long committeeChair,
			@RequestParam(required = false) List<Long> reviewerList) {

		Job job = jobDao.getJob(id);
		User chair = userDao.getUser(committeeChair);
		List<User> reviewers = new ArrayList<User>();
		
			if (committeeChair != null) {
				if (reviewerList != null) {
					for (Long u : reviewerList) {
						reviewers.add(userDao.getUser(u));
					}
					if (!reviewerList.contains(committeeChair)) {
						reviewerList.add(committeeChair);
						reviewers.add(chair);
					}
				} else if (reviewerList == null) {
					chair = userDao.getUser(committeeChair);
					reviewers.add(chair);
				}
			}

			if (committeeChair == null) {
				if (reviewerList != null) {
					for (Long u : reviewerList) {
						reviewers.add(userDao.getUser(u));
					}
				}
			}
			job.setTitle(title);
			job.setDescription(description);
			job.setPublishDate(publishDate);
			job.setCloseDate(closeDate);
			job.setCommitteeChair(chair);
			job.setCommitteeMembers(reviewers);
			job = jobDao.saveJob(job);

			return "redirect:/admin.html";
		
		
	}

	@RequestMapping(value = "/add.html", method = RequestMethod.GET)
	public String add(ModelMap models) {
		models.put("job", new Job());
		List<User> userReviewer = userDao.getUser();
		List<User> reviewer = new ArrayList<User>();
		for (User r : userReviewer) {
			if (r.isReviewer()) {
				reviewer.add(r);
			}
		}
		models.put("reviewer", reviewer);
		return "add";
	}

	@RequestMapping(value = "/add.html", method = RequestMethod.POST)
	public String add(ModelMap models, HttpSession session,
			@RequestParam String title,
			@RequestParam(required = false) String description,
			@RequestParam(required = false) Date publishDate,
			@RequestParam(required = false) Date closeDate,
			@RequestParam(required = false) Long committeeChair,
			@RequestParam(required = false) List<Long> reviewerList)
			throws IllegalStateException, IOException {
		String Error = "";
		if (title != "") {
			Job job = new Job();
			User chair = userDao.getUser(committeeChair);
			List<User> reviewers = new ArrayList<User>();

			if (committeeChair != null) {
				if (reviewerList != null) {
					for (Long u : reviewerList) {
						reviewers.add(userDao.getUser(u));
					}
					if (!reviewerList.contains(committeeChair)) {
						reviewerList.add(committeeChair);
						reviewers.add(chair);
					}
				} else if (reviewerList == null) {
					chair = userDao.getUser(committeeChair);
					reviewers.add(chair);
				}
			}

			if (committeeChair == null) {
				if (reviewerList != null) {
					for (Long u : reviewerList) {
						reviewers.add(userDao.getUser(u));
					}
				}
			}
			job.setTitle(title);
			job.setDescription(description);
			job.setPublishDate(publishDate);
			job.setCloseDate(closeDate);
			job.setCommitteeChair(chair);
			job.setCommitteeMembers(reviewers);
			job = jobDao.saveJob(job);
			return "redirect:/admin.html";
		} else
			Error = "Insert Title of Job !";
		models.put("Error", Error);
		return "redirect:add.html";
	}
	
	@RequestMapping(value = "/reviewApplication.html", method = RequestMethod.GET)
	public String reviewApplication(@RequestParam Long id,ModelMap models) {
		List<User> applicants=new ArrayList<User>();
		List<Application> applications= applicationDao.getApplicationByJob(jobDao.getJob(id));
		for(Application app:applications){
			applicants.add(app.getApplicant());		
		}
		models.put("allApplications", applications);
		models.put("job", jobDao.getJob(id));
		models.put("applicants", applicants);
		return "reviewApplication";
	}
}
