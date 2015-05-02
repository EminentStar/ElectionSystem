package net.javabugs.web.common.extend.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.vo.ResultVO;

public class VSAuthenticationSuccessHandler implements
		AuthenticationSuccessHandler {

	@Value("#{javabugsProp['app.user.agent']}")
	private String userAgent;
	
	@Value("#{javabugsProp['url.admin.home']}")
	private String adminHome;
	
//	@Value("#{javabugsProp['url.user.home']}")
//	private String userHome;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {

		String userAgent = request.getHeader("User-Agent");
		
		if (userAgent.equals(this.userAgent)) {
			ResultVO rvo = new ResultVO(VSConstants.RESULT_SUCCESS);
			rvo.put(VSConstants.KEY_DATA_DETAIL, SecurityContextHolder.getContext().getAuthentication().getPrincipal());
			rvo.put(VSConstants.KEY_JSESSIONID, request.getSession().getId());
			response.setContentType("application/json; charset=" + request.getCharacterEncoding());
			response.getWriter().print(rvo.toString());
			
		} else {
			response.sendRedirect(request.getContextPath() + "/" + adminHome);
		}
	}
}
