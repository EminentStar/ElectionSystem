package net.javabugs.web.common.extend.security;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.LoginUrlAuthenticationEntryPoint;

@SuppressWarnings("deprecation")
public class VSLoginAuthenticationEntryPoint extends LoginUrlAuthenticationEntryPoint  {
	
	@Value("#{javabugsProp['app.user.agent']}")
	private String userAgent;
	
	@Value("#{javabugsProp['request.header.ajax']}")
	private String ajaxObject;

	@Value("#{javabugsProp['request.header.accept']}")
	private String accept;
	
	@Autowired
	private MessageSource messageSource;
	
	@Override
    public void commence(HttpServletRequest request, HttpServletResponse response, AuthenticationException authException) throws IOException, ServletException {
//		Enumeration<String> e= request.getHeaderNames();
//		while(e.hasMoreElements()) {
//			String key = e.nextElement();
//			System.out.print(key);
//			System.out.print(":");
//			System.out.println(request.getHeader(key));
//		}
        if((request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equals(ajaxObject))
        		|| (request.getHeader("accept") != null && request.getHeader("accept").equals(accept))
        		|| (request.getHeader("user-agent") != null && request.getHeader("user-agent").equals(userAgent))){
        	
        	String errMsg = messageSource.getMessage("msg.fail.session.timeout", null, request.getLocale());
            ((HttpServletResponse)response).sendError(601, errMsg);
        }else{
            super.commence(request, response, authException);
        }
    }


}
