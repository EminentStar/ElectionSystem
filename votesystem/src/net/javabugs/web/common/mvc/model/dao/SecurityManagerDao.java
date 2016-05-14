package net.javabugs.web.common.mvc.model.dao;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface SecurityManagerDao extends UserDetailsService {
	
	public int changePassword(String users_name, String oldPasswd, String newPasswd);
}