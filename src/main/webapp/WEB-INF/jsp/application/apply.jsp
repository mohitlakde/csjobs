<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CS Jobs - Apply</title>
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
					<h3 class="panel-title">Login</h3>
				</div>
				<div class="panel-body">
					<form:form modelAttribute="application">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<table class="table table-striped table-hover">
							<tr>
								<th>Applicant:</th>
								<td>${application.applicant.firstName} ${application.applicant.lastName}</td>
							</tr>
							<tr>
								<th>Job Position:</th>
								<td>${application.job.title}</td>
							</tr>
								<tr>
								<th>Title:</th>
								<td><form:input path="currentJobTitle" /></td>
							</tr>
								<tr>
								<th>Institution or Company:</th>
								<td><form:input path="currentJobInstitution" /></td>
							</tr>
								<tr>
								<th>Starting Year:</th>
								<td><form:input path="currentJobYear" /></td>
							</tr>
							<tr>
								<th><br /></th>
								<td><input type="submit" name="next" value="next" class="btn btn-default"/></td>
							</tr>
						</table>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
