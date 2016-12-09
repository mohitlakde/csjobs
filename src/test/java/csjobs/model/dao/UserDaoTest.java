package csjobs.model.dao;

import org.testng.annotations.Test;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.testng.AbstractTransactionalTestNGSpringContextTests;

@Test(groups = "UserDaoTest")
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class UserDaoTest extends AbstractTransactionalTestNGSpringContextTests {

	@Autowired
	UserDao userDao;
	@Autowired
	JobDao jobDao;

	@Test
	public void getApplicant1Job() {
/*		System.out
				.println("TestCase for Applicant1 applied for Tenure-Track Faculty Position Start Fall 2015 job");
		List<Job> job = new ArrayList<Job>();
		job = userDao.getJobByApplicantName("applicant1").getJob();
		for (Job j : job) {
			assert j.getTitle().equalsIgnoreCase(
					"Tenure-Track Faculty Position (Start Fall 2015)");
		}
*/	}

	@Test
	public void getReviewer() {/*
		System.out.println("TestCase for Reviewer3 in two Committee");
		assert userDao.getCommitteeByReviewerName("reviewer3").getCommittee()
				.size() == 2;*/
	}
}