<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CSJobs - Job</title>
</head>
<body>

	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div>
		<c:if test="${authenticatedUser.isAdmin()==true}">
			<a href="<c:url value='/admin.html' />" class="btn btn-default"
				data-container="body" data-toggle="popover" data-placement="left">Home</a>
		</c:if>
		<c:if test="${authenticatedUser.isReviewer()==true}">
			<a href="<c:url value='/reviewer.html' />" class="btn btn-default"
				data-container="body" data-toggle="popover" data-placement="left">Home</a>
		</c:if>
		<c:if test="${empty authenticatedUser.firstName}">
			<a href="<c:url value='/job/list.html' />" class="btn btn-default"
				data-container="body" data-toggle="popover" data-placement="left">Home</a>
		</c:if>
		<c:if test="${authenticatedUser.isReviewer()==false && authenticatedUser.isAdmin()==false}">
			<a href="<c:url value='/applicant.html' />" class="btn btn-default"
				data-container="body" data-toggle="popover" data-placement="left">Home</a>
		</c:if>
	
	<div style="float: right;">
		<form action="<c:url value='/logout' />" method="post">
		<c:if test="${not empty authenticatedUser.firstName }">
			You are logged in as <em>${authenticatedUser.firstName}
					${authenticatedUser.lastName}</em>.
				 <input name="_csrf" type="hidden" value="${_csrf.token}" />	 
				<input name="submit" type="submit" value="Logout" class="btn btn-default"/>
		</c:if>
		</form>
	</div>
</div>
	<div class="container" style="width: 50%;">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">Job Details</h3>
			</div>

			<div class="panel-body">
				<table class="table table-striped table-hover">
					<tr>
						<th>Job Title:</th>
						<td>${job.title}</td>
					</tr>
					<tr>
						<th>Posted on:</th>
						<td><fmt:formatDate value="${job.publishDate}"
								pattern="M/d/yyyy" /></td>
					</tr>
					<tr>
						<th>Close on:</th>
						<td><fmt:formatDate value="${job.closeDate}"
								pattern="M/d/yyyy" /></td>
					</tr>
					<tr>
						<th>Job Description:</th>
						<td>${job.description}</td>
					</tr>
					<c:if test="${authenticatedUser.isAdmin()==true}">
					<tr>
						<th>Committee Chair:</th>
						<td>${jobchair.firstName}</td>
					</tr>
					<tr>
						<th>Committee Reviewers:</th>
						<td><c:forEach items="${jobrev}" var="i">
									${i.firstName}<br />
							</c:forEach></td>
					</tr>
					</c:if>
				</table>
				<security:authorize access="hasRole('ROLE_ADMIN')">
				<table class="table table-striped table-hover">
					<tr>
						<th>Application ID</th>
						<td>Applicant</td>
						<td>View Application</td>
					</tr>
					<c:forEach items="${job.applications}" var="a">
					<tr>
						<th>${a.id }</th>
						<td>${a.applicant.firstName}</td>
						<td><a href="<c:url value='/application/view.html?id=${a.id}' />">View</a></td>
					</tr>
					</c:forEach>
				</table>
				</security:authorize>
			</div>
		</div>
	</div>

</body>
</html>
