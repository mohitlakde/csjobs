package csjobs.web.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;

import csjobs.model.Application;
import csjobs.model.Job;
import csjobs.model.User;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;
import csjobs.web.validator.UserValidator;

@Controller
public class UserController {

	@Autowired
	private UserDao userDao;

	@Autowired
	private JobDao jobDao;

	@Autowired
	private UserValidator userValidator;

	private static final Logger logger = LoggerFactory
			.getLogger(UserController.class);

	@RequestMapping(value = "/register.html", method = RequestMethod.GET)
	public String register(ModelMap models) {
		models.put("user", new User());
		return "register";
	}

	@RequestMapping(value = "/register.html", method = RequestMethod.POST)
	public String register(@ModelAttribute User user,
			BindingResult bindingResult, SessionStatus sessionStatus,
			ModelMap models) {
		userValidator.validate(user, bindingResult);
		if (bindingResult.hasErrors())
			return "register";

		List<User> userList = userDao.getUser();
		int counter = 0;
		String ErrorMessage = "";
		for (User u : userList) {
			if (user.getEmail().equalsIgnoreCase(u.getEmail())) {
				ErrorMessage = "Please Enter another Email Id";
				models.put("ErrorMessage", ErrorMessage);
				counter++;
			}
		}
		if ((counter == 0) && (user.getPassword().equals(user.getPassword2()))) {
			user = userDao.saveUser(user);
			sessionStatus.setComplete();
			return "redirect:/";
		} else
			ErrorMessage = "Please Check Password";
		models.put("ErrorMessage", ErrorMessage);
		return "register";

	}

	@RequestMapping(value = "/login.html", method = RequestMethod.GET)
	public String login() {
		//System.out.println("I am here");
		return "login";
	}

	@RequestMapping(value = "/login.html", method = RequestMethod.POST)
	public String login(@RequestParam String email,
			@RequestParam String password, HttpSession session, ModelMap models) {

		User user = userDao.getUser(email);
		if (user == null || !user.getPassword().equals(password))
			return "redirect:/login.html";
		logger.info(user.getEmail() + " logged in.");

		session.setAttribute("authenticatedUser", user);
		if (user.isAdmin()) {
			return "redirect:/admin.html";
		} else if (user.isReviewer()) {
			return "redirect:/reviewer.html";
		} else
			return "redirect:/applicant.html";
	}

/*	@RequestMapping("/logout.html")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}*/
	
/*	@RequestMapping("/logout.html")
	public String logout(HttpSession session) {		
		session.invalidate();
		return "redirect:/";
	}
*/
	@RequestMapping("/admin.html")
	public String admin(ModelMap models,HttpSession session) {
		models.put("jobs", jobDao.getJobs());
		return "admin";
	}

	@RequestMapping("/reviewer.html")
	public String reviewer(HttpSession session, ModelMap models) {
		User reviewer = (User) session.getAttribute("authenticatedUser");
		List<Job> jobs = jobDao.getJobs();
		List<Job> reviewerJobs = new ArrayList<Job>();
		List<Job> availableJobs = jobDao.getOpenJobs();	
		for (Job j : jobs) {
			List<User> reviewerList = j.getCommitteeMembers();
			for (User u : reviewerList) {
				if (u.getEmail().equals(reviewer.getEmail())) {
					// System.out.println("job name-"+j.getTitle()+"and User Name-"+u.getEmail());
					reviewerJobs.add(j);			
				}
			}
		}
		models.put("availableJobs", availableJobs);
		models.put("reviewerJobs", reviewerJobs);
		
		return "reviewer";
	}

	@RequestMapping("/applicant.html")
	public String applicant(HttpSession session, ModelMap models) {
		User authenticatedUser = (User) session
				.getAttribute("authenticatedUser");

		// The authenticatedUser in the session is a "detached" object, which
		// means it may not be update-to-date, and it cannot be used to load
		// other objects. So here we just use the id to retrieve another copy of
		// the user from the database.
		User user = userDao.getUser(authenticatedUser.getId());

		Set<Job> appliedJobs = new HashSet<Job>();
		for (Application application : user.getApplications())
			appliedJobs.add(application.getJob());

		List<Job> availableJobs = jobDao.getOpenJobs();
		Iterator<Job> iterator = availableJobs.iterator();
		while (iterator.hasNext())
			if (appliedJobs.contains(iterator.next()))
				iterator.remove();

		models.put("user", user);
		models.put("availableJobs", availableJobs);
		return "applicant";
	}
	


}
