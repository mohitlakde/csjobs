<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>Upload Research Statement</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<form action="<c:url value='/logout' />" method="post">
	<div>
		<a href="<c:url value='/applicant.html' />" class="btn btn-default"
			data-container="body" data-toggle="popover" data-placement="left">Home</a>
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
					<h3 class="panel-title">Upload Research Statement</h3>
				</div>
				<div class="panel-body">
				
					<form action="uploadRS.html?${_csrf.parameterName}=${_csrf.token}" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<table class="table table-striped table-hover">
							<tr>
								<th>Applicant:</th>
								<td>${application.applicant.firstName}
									${application.applicant.lastName}</td>
							</tr>
							<tr>
								<th>Job Position:</th>
								<td>${job.title}</td>
							</tr>
							<tr>
								<td><input type="file" name="file" class="btn btn-default" /></td>
								<td><input type="submit" name="save" value="save"
									class="btn btn-default" /></td>
								<td><a href="uploadTS.html" class="btn btn-default">Skip</a></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>