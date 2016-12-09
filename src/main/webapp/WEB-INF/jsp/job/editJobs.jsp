<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="<c:url value='/superhero/bootstrap.min.css' />" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit</title>
</head>
<body>
	<h2>CS Jobs</h2>
	<h5>Computer Department Job Site</h5>
	<div class="progress">
		<div class="progress-bar" style="width: 100%;"></div>
	</div>
	<div>
		<a href="<c:url value='/admin.html' />" class="btn btn-default"
			data-container="body" data-toggle="popover" data-placement="left">Home</a>
		<form action="<c:url value='/logout' />" method="post" style="float: right;">
		You are logged in as <em>${authenticatedUser.firstName}
				${authenticatedUser.lastName}</em>.
		<input name="_csrf" type="hidden" value="${_csrf.token}" />
 <input name="submit" type="submit" value="Logout" class="btn btn-default"/> </form>
	</div>

	<div class="container">
		<div class="container" style="width: 50%; float: centre;">
			<div class="panel panel-primary">
				<div class="panel-heading">
					<h3 class="panel-title">Edit Job</h3>
				</div>
				<div class="panel-body">
					<form method="post" action="editJobs.html">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
						<input type="hidden" name="id" value="${jobs.id}" />
						<table class="table table-striped table-hover">
							<tr>
								<th>Title:</th>
								<td><input type="text" name="title" value="${jobs.title}" /></td>
							</tr>
							<tr>
								<th>Description:</th>
								<td><textarea name="description"> ${jobs.description} </textarea></td>
							</tr>
							<tr>
								<th>PublishDate:</th>
								<td><input type="text" name="publishDate"
									value="<fmt:formatDate value="${jobs.publishDate}" pattern="M/d/yyyy" />" /></td>
							</tr>
							<tr>
								<th>CloseDate:</th>
								<td><input type="text" name="closeDate"
									value="<fmt:formatDate value="${jobs.closeDate}" pattern="M/d/yyyy" />" /></td>
							</tr>

							<tr>
								<th>Committee Members:</th>
								<td><c:forEach items="${Allreviewers}" var="r">
										<c:set var="flag" value="false" />

										<c:forEach items="${userReviewer}" var="r2">
											<c:if test="${r eq r2 }">
												<c:set var="flag" value="true" />
											</c:if>
										</c:forEach>
										<c:choose>
											<c:when test="${flag == true }">
								${r.firstName}<input type="checkbox" name="reviewerList"
													value="${r.id}" checked />
												<br />
											</c:when>
											<c:otherwise>
								${r.firstName}<input type="checkbox" name="reviewerList"
													value="${r.id}" />
												<br />
											</c:otherwise>
										</c:choose>

									</c:forEach></td>
							</tr>
							<tr>
								<th>CommitteeChair:</th>
								<td><select name="committeeChair">
										<c:forEach items="${Allreviewers}" var="i">
											<c:choose>
												<c:when test="${chair eq i }">
													<option selected value="<c:out value="${i.id}"/>">
														<c:out value="${i.firstName}" />
													</option>
												</c:when>
												<c:otherwise>
													<option value="<c:out value="${i.id}"/>">
														<c:out value="${i.firstName}" />
													</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
								</select></td>
							</tr>

							<tr>
								<td></td>
								<td><input type="submit" name="save" value="save"
									class="btn btn-default" /> <a
									href="<c:url value='/admin.html' />" class="btn btn-default"
									data-container="body" data-toggle="popover"
									data-placement="left">Cancel</a></td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>


</body>
</html>