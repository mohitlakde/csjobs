package csjobs.web.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import csjobs.model.*;
import csjobs.model.dao.ApplicationDao;
import csjobs.model.dao.FileDao;
import csjobs.model.dao.JobDao;
import csjobs.model.dao.UserDao;

@Controller
public class FileController {
	@Autowired
	private JobDao jobDao;
	@Autowired
	private FileDao fileDao;
	@Autowired
	private UserDao userDao;
	@Autowired
	private ApplicationDao applicationDao;
	@Autowired
	ServletContext context;

	private File getFileDirectory() {
		String path = context.getRealPath("/WEB-INF/files");
		return new File(path);
	}

	@RequestMapping(value = "/application/uploadCV.html", method = RequestMethod.GET)
	public String uploadCV(ModelMap models,
			HttpSession session) {
		Long applicationId=(Long) session.getAttribute("applicationId");
		models.put("application", applicationDao.getApplication(applicationId));
		return "application/uploadCV";
	}

	@RequestMapping(value = "/application/uploadCV.html", method = RequestMethod.POST)
	public String uploadCV(ModelMap models,
			@ModelAttribute Application application,
			@RequestParam MultipartFile file,
			HttpSession session) throws IllegalStateException, IOException{
		if(!file.isEmpty()){
		User applicant = (User) session.getAttribute("authenticatedUser");
		Job job = (Job) session.getAttribute("job");
		
		csjobs.model.File f = new csjobs.model.File();
		f.setName(file.getOriginalFilename());
		f.setSize(file.getSize());
		f.setDate(new Date());
		f.setType(file.getContentType());
		f.setOwner(applicant);
		csjobs.model.File savedFile = fileDao.saveFiles(f);
		
		Application app = applicationDao.getApplication(job, applicant);
		app.setCv(savedFile);
		Application savedApplication= applicationDao.saveApplication(app);

		file.transferTo(new File(getFileDirectory(), savedApplication.getId()
				.toString()
				+ savedFile.getId().toString()
				+ file.getOriginalFilename()));
		return "redirect:uploadRS.html";
		}else
			return "redirect:uploadCV.html";
	}

	@RequestMapping(value = "/application/uploadRS.html", method = RequestMethod.GET)
	public String uploadRS(ModelMap models) {
		return "application/uploadRS";
	}

	@RequestMapping(value = "/application/uploadRS.html", method = RequestMethod.POST)
	public String uploadRS(ModelMap models,
			@RequestParam MultipartFile file,
			HttpSession session) throws IllegalStateException, IOException {
		if(!file.isEmpty()){
		User applicant = (User) session.getAttribute("authenticatedUser");
		Job job = (Job) session.getAttribute("job");
		
		csjobs.model.File f = new csjobs.model.File();
		f.setName(file.getOriginalFilename());
		f.setSize(file.getSize());
		f.setType(file.getContentType());
		f.setOwner(applicant);
		f.setDate(new Date());
		csjobs.model.File savedFile = fileDao.saveFiles(f);//Saving File

		Application application = applicationDao.getApplication(job, applicant);
		application.setResearchStatement(savedFile);
		Application savedApplication =applicationDao.saveApplication(application);//Saving Application
		file.transferTo(new File(getFileDirectory(), savedApplication.getId()
				.toString()
				+ savedFile.getId().toString()
				+ file.getOriginalFilename()));
		
		return "redirect:uploadTS.html";
		}else 
			return "redirect:uploadRS.html";
	}

	@RequestMapping(value = "/application/uploadTS.html", method = RequestMethod.GET)
	public String uploadTS(ModelMap models) {
		return "application/uploadTS";
	}

	@RequestMapping(value = "/application/uploadTS.html", method = RequestMethod.POST)
	public String uploadTS(ModelMap models,
			@RequestParam MultipartFile file,
			HttpSession session) throws IllegalStateException, IOException{
		
		if(!file.isEmpty()){
		User applicant = (User) session.getAttribute("authenticatedUser");
		Job job = (Job) session.getAttribute("job");

		csjobs.model.File f = new csjobs.model.File();
		f.setName(file.getOriginalFilename());
		f.setSize(file.getSize());
		f.setType(file.getContentType());
		f.setOwner(applicant);
		f.setDate(new Date());
		csjobs.model.File savedFile = fileDao.saveFiles(f);

		Application application = applicationDao.getApplication(job, applicant);
		application.setTeachingStatement(savedFile);
		Application savedApplication=applicationDao.saveApplication(application);
		file.transferTo(new File(getFileDirectory(), savedApplication.getId()
				.toString()
				+ savedFile.getId().toString()
				+ file.getOriginalFilename()));
		return "redirect:addDegree.html";
		}else 
			return "redirect:uploadTS.html";
	}

	@RequestMapping(value = "/application/download.html")
	public String download(ModelMap models, HttpServletResponse response,
			@RequestParam Long ApplicantionId, @RequestParam Long FileId,@RequestParam String FileName,
			HttpSession session) throws IOException 
			 {	
		//String DownloadfileName=fileDao.getFile(id)
		//System.out.println(DownloadfileName);
		String fileName=ApplicantionId.toString() + FileId.toString() + FileName;
		//System.out.println(fileName);
		response.setContentType("application/pdf,application/msword" );
		response.setHeader("Content-Disposition", "download; fileName=" + FileName);
		
		FileInputStream in = new FileInputStream(new File(getFileDirectory(),fileName));
		OutputStream out = response.getOutputStream();

		byte buffer[] = new byte[2048];
		int bytesRead;
		while ((bytesRead = in.read(buffer)) > 0)
			out.write(buffer, 0, bytesRead);

		in.close();
		return null;
	}

}
