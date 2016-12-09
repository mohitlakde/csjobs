package csjobs.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Component;

import csjobs.model.User;

@Component
public class AuthenticationSuccessHandler extends
		SavedRequestAwareAuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws ServletException, IOException {
		User user = (User) authentication.getPrincipal();

		HttpSession session = request.getSession();
		session.setAttribute("authenticatedUser", user);

		/*
		 * logger.info( user.getEmail() + " signed in from " +
		 * request.getRemoteAddr() );
		 */

		RequestCache requestCache = new HttpSessionRequestCache();

		SavedRequest savedRequest = requestCache.getRequest(request, response);
		if (savedRequest != null) {
			super.onAuthenticationSuccess(request, response, authentication);
			return;
		}

		String url = "/";

		if (user.isAdmin()) {
			url = "/admin.html";
		} else if (user.isReviewer()) {
			url = "/reviewer.html";
		} else {
			url = "/applicant.html";
		}

		getRedirectStrategy().sendRedirect(request, response, url);
	}

}
