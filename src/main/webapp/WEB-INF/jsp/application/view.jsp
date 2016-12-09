<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CS Jobs - Application</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<form action="<c:url value='/logout' />" method="post">
	<div>
		<a href="<c:url value='/applicant.html' />" class="btn btn-default" data-container="body"
			data-toggle="popover" data-placement="left">Home</a>
		<label style="float: right;">You are logged in as <em>${authenticatedUser.firstName}
				${authenticatedUser.lastName}</em>. 
		 <input name="_csrf" type="hidden" value="${_csrf.token}" />
		<input name="submit" type="submit" value="Logout" class="btn btn-default"/></label>
	</div>
	</form>
	<div class="container">
		<div class="container" style="width: 50%; float: centre;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Job Application</h3>
				</div>
				<div class="panel-body">
					<form action="login.html" method="post">
						<table class="table table-striped table-hover">
							<tr>
								<th>Job:</th>
								<td>${application.job.title}</td>
							</tr>
							<tr>
								<th>Applicant:</th>
								<td>${application.applicant.firstName}
									${application.applicant.lastName}</td>
							</tr>
							<tr>
								<th>Submitted:</th>
								<td><fmt:formatDate value="${application.submitDate}"
										pattern="M/d/yyyy" /></td>
							</tr>
							<tr>
								<th>Current Position</th>
								<td>${application.currentJobTitle}at
									${application.currentJobInstitution} since
									${application.currentJobYear}</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>

<div class="container" style="float: left; width: 50%;">
<div class="panel panel-primary" >
  <div class="panel-heading" >
    <h3 class="panel-title">Applied Degrees</h3>
  </div>
  
<div class="panel-body" >
<table class="table table-striped table-hover">
<tr><th>Degree</th><th>School</th><th>Year</th></tr>
		<c:forEach items="${application.degrees}" var="degree">
			<tr>
				<td>${degree.name}</td>
				<td>${degree.school}</td>
				<td>${degree.year}</td>
			</tr>
		</c:forEach>
</table>
</div>
</div>
</div>
<div class="container" style="float: left; width: 50%;">
<div class="panel panel-primary" >
  <div class="panel-heading" >
    <h3 class="panel-title">Applied Documents</h3>
  </div> 
<div class="panel-body" >
<table class="table table-striped table-hover">
<tr><th>Curriculum Vitae</th><th>Research Statement</th><th>Teaching Statement</th></tr>
		<tr>
			<td><a href="download.html?ApplicantionId=${application.id}&FileId=${application.cv.id}&FileName=${application.cv.name}">${application.cv.name}</a></td>
			<td><a
				href="download.html?ApplicantionId=${application.id}&FileId=${application.researchStatement.id}&FileName=${application.researchStatement.name}">${application.researchStatement.name}</a></td>
			<td><a
				href="download.html?ApplicantionId=${application.id}&FileId=${application.teachingStatement.id}&FileName=${application.teachingStatement.name}">${application.teachingStatement.name}</a></td>
		</tr>
</table>

</div>
</div>
</div>

</body>
</html>
