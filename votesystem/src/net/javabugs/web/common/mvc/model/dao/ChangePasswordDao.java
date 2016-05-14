package net.javabugs.web.common.mvc.model.dao;

import org.springframework.security.core.userdetails.UserDetailsService;

/**
 * Describes a class that allows changing of a user's password.
 * 
 */
public interface ChangePasswordDao extends UserDetailsService {

	/**
	 * Changes the user's password. Note that a secure implementation would require
	 * the user to supply their existing password prior to changing it.
	 * 
	 * @param username the username
	 * @param password the new password
	 */
	void changePassword(String username, String password);

}