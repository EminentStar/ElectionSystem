package net.javabugs.web.common.extend.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class VSAccessDeniedHandler implements AccessDeniedHandler {

	@Value("#{javabugsProp['app.user.agent']}")
	private String userAgent;
	
	@Value("#{javabugsProp['request.header.ajax']}")
	private String ajaxObject;

	@Value("#{javabugsProp['request.header.accept']}")
	private String accept;
	
	@Value("#{javabugsProp['url.login']}")
	private String login;
	
	@Autowired
	private MessageSource messageSource;
	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException accessDeniedException) throws IOException, ServletException {
		
		accessDeniedException.printStackTrace();

		if((request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equals(ajaxObject))
        		|| (request.getHeader("accept") != null && request.getHeader("accept").equals(accept))
        		|| (request.getHeader("user-agent") != null && request.getHeader("user-agent").equals(userAgent))){
			
			String errMsg = messageSource.getMessage("msg.fail.access.denied", null, request.getLocale());
            ((HttpServletResponse)response).sendError(602, errMsg);
        }else{
			response.sendRedirect(request.getContextPath() + login);
		}

	}

}
