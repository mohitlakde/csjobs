<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CS Jobs - Admin</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div>
		<a href="<c:url value='/add.html' />" class="btn btn-default"
			data-container="body" data-toggle="popover" data-placement="left">Create Job</a>	
		<form action="<c:url value='/logout' />" method="post" style="float: right;">
		 <input name="_csrf" type="hidden" value="${_csrf.token}" />
		You are logged in as <em>${authenticatedUser.firstName}
				${authenticatedUser.lastName}</em>.
			 <input name="submit" type="submit" value="Logout" class="btn btn-default"/></form>			
	</div>

	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	<div class="container" style="float: centre; width: 50%;">
		<div class="panel panel-primary">
			<div class="panel-heading">
				<h3 class="panel-title">All Jobs</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped table-hover">
					<tr>
						<th>Jobs</th>
						<th>Publish Date</th>
						<th>Close Date</th>
						<th>Operations</th>
					</tr>
					<c:forEach items="${jobs}" var="jobs">
						<tr>
							<td><a href="<c:url value='/job/view.html?id=${jobs.id}' />">${jobs.title}</a></td>
							 <td><fmt:formatDate value="${jobs.publishDate}"
									pattern="M/d/yyyy" /></td>
							<td><fmt:formatDate value="${jobs.closeDate}"
									pattern="M/d/yyyy" /></td>
							<td><a href="<c:url value='/job/editJobs.html?id=${jobs.id}' />">Edit</a>
							
							</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
	</div>


</body>
</html>
