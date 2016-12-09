<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CS Jobs - Applicant</title>
<link rel="stylesheet" href="superhero/bootstrap.min.css" />
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
<div class="panel panel-primary" >
  <div class="panel-heading" >
    <h3 class="panel-title">Job Applied</h3>
  </div>
  
<div class="panel-body" >
<table class="table table-striped table-hover">
<tr><th>Job Applied</th><th>View Application</th></tr>
<c:if test="${user.applications.size() > 0}">
 <c:forEach items="${user.applications}" var="application">
<tr> <td><a href="<c:url value='/job/view.html?id=${application.job.id}' />">${application.job.title}</a></td>
 <td><a href="<c:url value='/application/view.html?id=${application.id}' />">Application</a></td></tr>
  </c:forEach>
</c:if>
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
<tr><th>Job Available</th><th>Apply</th></tr>
<c:if test="${availableJobs.size() > 0}">
  <c:forEach items="${availableJobs}" var="job">
  <tr><td><a href="<c:url value='/job/view.html?id=${job.id}' />">${job.title}</a></td>
   <td><a href="<c:url value='/application/apply.html?jobId=${job.id}' />">Apply</a></td></tr>
  </c:forEach>
</c:if>
</table>
</div>
</div>
</div>
</div>
</body>
</html>
