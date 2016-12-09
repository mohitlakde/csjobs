<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<title>CS Jobs</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div style="margin-left: 62%; border: medium;">
		<c:if test="${empty authenticatedUser}">
			<p>
				<a href="<c:url value='/register.html' />">Register</a> | <a
					href="<c:url value='/login.html' />">Login</a>
			</p>
		</c:if>
	</div>
	<c:if test="${not empty authenticatedUser}">
	<form action="<c:url value='/logout' />" method="post" style="float: right;">
		<p>You are logged in as <em>${authenticatedUser.firstName} ${authenticatedUser.lastName}</em>.
 	<input name="_csrf" type="hidden" value="${_csrf.token}" />
 	<input name="submit" type="submit" value="Logout" class="btn btn-default"/></p>
	</form>		
	</c:if>
	<div class="container">
		<div class="container" style="width: 50%; float: centre;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Open Job Postions</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-hover">
						<c:forEach items="${openJobs}" var="job">
							<tr>
								<td><a href="<c:url value='/job/view.html?id=${job.id}' />">${job.title}</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
