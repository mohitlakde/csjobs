<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="superhero/bootstrap.min.css" />
<title>CS Jobs - Reviewer</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
<form action="<c:url value='/logout' />" method="post">
<div style="margin-left: 75%; border: medium;">
<p>You are logged in as <em>${authenticatedUser.firstName} ${authenticatedUser.lastName}</em>.
 <input name="_csrf" type="hidden" value="${_csrf.token}" />
 <input name="submit" type="submit" value="Logout" class="btn btn-default"/></p></div></form>

	<div class="container">
		<div class="container" style="float: left; width: 50%;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Job to Review</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-hover">
						<c:forEach items="${reviewerJobs}" var="i">
							<tr>
								<td>${i.title}</td>
							
								<td><a href="<c:url value='/reviewApplication.html?id=${i.id}' />">Applications</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>

		<div class="container" style="float: right; width: 50%;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Job Available</h3>
				</div>
				<div class="panel-body">
					<table class="table table-striped table-hover">
						<c:forEach items="${availableJobs}" var="i">
							<tr>
								<td><a href="<c:url value='/job/view.html?id=${i.id}' />">${i.title}</a></td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
