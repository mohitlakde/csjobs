<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="superhero/bootstrap.min.css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>CS Jobs - Applications</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div>
		<a href="admin.html" class="btn btn-default" data-container="body"
			data-toggle="popover" data-placement="left">Home</a>
		<form action="<c:url value='/logout' />" method="post"
			style="float: right;">
			<input name="_csrf" type="hidden" value="${_csrf.token}" /> You are
			logged in as <em>${authenticatedUser.firstName}
				${authenticatedUser.lastName}</em>. <input name="submit" type="submit"
				value="Logout" class="btn btn-default" />
		</form>
	</div>



	<div class="container">
		<div class="container" style="float: left; width: 50%;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Application</h3>
				</div>
				<div class="panel-body">

					<table class="table table-striped table-hover">
						<tr>
							<th>Applicant Name</th>
							<th>View Application</th>
						</tr>
						<c:forEach items="${application}" var="i" varStatus="loop">
							<tr>
								<c:forEach items="${loop.current}" var="j" varStatus="loop1">
									<td>${j.}</td>
									<td></td>
								</c:forEach>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>





</body>
</html>