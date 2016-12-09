<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="superhero/bootstrap.min.css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>CS Jobs - Registration</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	 <form:form modelAttribute="user">
		<div class="container">
			<div class="container" style="width: 50%; float: centre;">
				<div class="panel panel-primary">
					<div class="panel-heading">
						<h3 class="panel-title">Login</h3>
					</div>
					<div class="panel-body">
						<form action="login.html" method="post">
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
							<table class="table table-striped table-hover">
								<tr>
									<th>Email:</th>
									<td><form:input path="email" /> <b><form:errors
												path="email" /></b>${ErrorMessage}</td>
								</tr>
								<tr>
									<th>Password:</th>
									 <td><form:password path="password" /> <b><form:errors
												path="password" /></b></td>
								</tr>

								<tr>
									<th>Password again:</th>
									<td><form:password path="password2" /> <b><form:errors
												path="password2" /></b></td>
								</tr>
								<tr>
									<th>Last Name:</th>
									<td><form:input path="lastName" /> <b><form:errors
												path="lastName" /></b></td>
								</tr>
								<tr>
									<th>First Name:</th>
									<td><form:input path="firstName" /> <b><form:errors
												path="firstName" /></b></td>
								</tr>
								<tr>
									<th>Phone:</th>
									<td><form:input path="phone" /> <b><form:errors
												path="phone" /></b></td>
								</tr>
								<tr>
									<th>Address:</th>
									<td><form:input path="address" /> <b><form:errors
												path="address" /></b></td>
								</tr>
								<tr>
									<td><br /></td>
									<td>
								<input type="submit" name="save" value="Register" class="btn btn-default" /> 
								<a href="<c:url value="/" />" class="btn btn-default" data-container="body"
									data-toggle="popover" data-placement="left">Cancel</a></td>								
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>

	</form:form>
</body>
</html>
