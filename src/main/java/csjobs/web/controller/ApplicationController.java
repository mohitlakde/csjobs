package csjobs.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import csjobs.model.dao.ApplicationDao;
import csjobs.model.dao.FileDao;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;

@Controller
public class ApplicationController {

    @Autowired
    private ApplicationDao applicationDao;
    @Autowired
	private JobDao jobDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private UserDao userDao;


    @RequestMapping("/application/view.html")
    public String view( @RequestParam Long id, ModelMap models )
    {
        models.put( "application", applicationDao.getApplication( id ) );
        return "application/view";
    }
    
    
/*	@RequestMapping("/allApplication.html")
	public String allApplication(@RequestParam(required=false) Long jobId,HttpSession session, ModelMap models) {
	
		
		models.put("jobId", jobId);
		Application application =applicationDao.getApplication(jobDao.getJob(jobId), userDao.getUser(applicantId));
		Job job=jobDao.getJob(jobId);
		User applicant=userDao.getRev(job);
		List<Degree> degree=application.getDegrees();
		
		models.put("application", application);
		models.put("job", job);
		models.put("applicant", applicant);
		models.put("degree", degree);
		
		
		return "allApplication";
	}*/

}
