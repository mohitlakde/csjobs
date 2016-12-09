<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CS Jobs - Review</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div>
		<a href="<c:url value='/reviewApplication.html?id=${job.id}' />"
			class="btn btn-default" data-container="body" data-toggle="popover"
			data-placement="left">Home</a> 
		<form action="<c:url value='/logout' />" method="post" style="float: right;">
			You are logged in as <em>${authenticatedUser.firstName}
				${authenticatedUser.lastName}</em>.
		<input name="_csrf" type="hidden" value="${_csrf.token}" />
 		<input name="submit" type="submit" value="Logout" class="btn btn-default"/>
		</form>		
	</div>
	<div class="container">
		<div class="container" style="float: left; width: 50%;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Job Title</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-hover">
						<tr>
							<th>Job Position :</th>
							<td>${job.title}</td>
						</tr>
						<tr>
							<th>Applicant :</th>
							<td>${applicant.email}</td>
						</tr>

						<tr>
							<th>Applied Date :</th>
							<td><fmt:formatDate value="${application.submitDate}"
									pattern="M/d/yyyy" /></td>
						</tr>
						<tr>
							<th>Current Job Title :</th>
							<td>${application.currentJobTitle}</td>
						</tr>
						<tr>
							<th>Current Job Institution :</th>
							<td>${application.currentJobInstitution}</td>
						</tr>
						<tr>
							<th>Current Job Year :</th>
							<td>${application.currentJobYear}</td>
						</tr>
						<tr>
							<th>CV :</th>
							<td><a
								href="download.html?ApplicantionId=${application.id}&FileId=${application.cv.id}&FileName=${application.cv.name}">${application.cv.name}</a></td>
						</tr>
						<tr>
							<th>RS :</th>
							<td><a
								href="download.html?ApplicantionId=${application.id}&FileId=${application.researchStatement.id}&FileName=${application.researchStatement.name}">${application.researchStatement.name}</a></td>
						</tr>
						<tr>
							<th>TS :</th>
							<td><a
								href="download.html?ApplicantionId=${application.id}&FileId=${application.teachingStatement.id}&FileName=${application.teachingStatement.name}">${application.teachingStatement.name}</a></td>
						</tr>
						<tr>
							<th>Degrees :</th>
							<td><c:forEach items="${degree}" var="d">
							 Name: ${d.name}  &nbsp&nbsp
							 School: ${d.school} &nbsp&nbsp
							 Year: ${d.year}<br />
								</c:forEach>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="container" style="float: right; width: 50%;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Comment</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-hover">
						<tr>
							<th>Rank :</th>
							<td><input type="text" name="rank"></td>
						</tr>	
						<tr>
							<th>Comment :</th>
							<td><textarea name="comment"></textarea></td>
							<td></td>
						</tr>						
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>