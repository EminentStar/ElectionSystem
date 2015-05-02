package net.javabugs.web.common.extend.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.vo.ResultVO;

public class VSLogoutSuccessHandler implements LogoutSuccessHandler {

	@Value("#{javabugsProp['app.user.agent']}")
	private String userAgent;
	
	@Value("#{javabugsProp['url.anonymous.home']}")
	private String anonymousHome;
	
	@Override
	public void onLogoutSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication auth) throws IOException,
			ServletException {
		String userAgent = request.getHeader("User-Agent");
		
		if (userAgent.equals(this.userAgent)) {
			ResultVO rvo = new ResultVO(VSConstants.RESULT_SUCCESS);
			response.setContentType("application/json; charset=" + request.getCharacterEncoding());
			response.getWriter().print(rvo.toString());
			
		} else {
			response.sendRedirect(request.getContextPath() + "/" + anonymousHome);
		}
	}

}
