<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CS Jobs - Add Degree</title>
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
		<div class="container" style="width: 55%; float: centre;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Add Degree</h3>
				</div>
				<div class="panel-body">
					<form:form modelAttribute="degree">
						<table class="table table-striped table-hover">
							<tr>
								<th>Applicant:</th>
								<td>${application.applicant.firstName}
									${application.applicant.lastName}</td>
								<td><br /></td>
							</tr>
							<tr>
								<th>Job Position:</th>
								<td>${job.title}</td>
								<td><br /></td>
							</tr>
							<tr>
								<th>Degree</th>
								<th>School</th>
								<th>Year</th>
							</tr>
							<c:forEach items="${application.degrees}" var="degree">
								<tr>
									<td>${degree.name}</td>
									<td>${degree.school}</td>
									<td>${degree.year}</td>
								</tr>
							</c:forEach>
							<tr>
								<td><form:input path="name" /></td>
								<td><form:input path="school" /></td>
								<td><form:input path="year" /></td>
							</tr>
							<tr>
								<td><br /></td>
								<td><input type="submit" name="add" value="Add"
									class="btn btn-default" /></td>
								<td><a href="../applicant.html" class="btn btn-default">Finish</a></td>
							</tr>
						</table>
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
