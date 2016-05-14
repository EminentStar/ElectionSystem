package net.javabugs.web.common.extend.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.vo.ResultVO;

public class VSAuthenticationFailureHandler implements
		AuthenticationFailureHandler {

	@Value("#{javabugsProp['app.user.agent']}")
	private String userAgent;
	
	@Value("#{javabugsProp['url.login']}")
	private String login;
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException authException)
			throws IOException, ServletException {

		String userAgent = request.getHeader("User-Agent");

		if (userAgent.equals(this.userAgent)) {
			ResultVO rvo = new ResultVO(VSConstants.RESULT_INVALID_ACCOUNT);
			response.setContentType("application/json; charset=" + request.getCharacterEncoding());
			response.getWriter().print(rvo.toString());
			
		} else {
			request.getSession().setAttribute("error", VSConstants.RESULT_INVALID_ACCOUNT);
			request.getSession().setAttribute("j_username", request.getParameter("j_username"));
			response.sendRedirect(request.getContextPath() + "/" + login);
		}
		
	}
}
