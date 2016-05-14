/**
 * 
 */
package net.javabugs.web.common.mvc.model.dto;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

/**
 * Extends User with addition spring security User info.
 * 
 */
public class JavabugsUser extends User {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String users_name;

	private String cell_phone;
	
	private String dept_code;
	
	private String email;
	
	private String student_check;
	
	private String[] role;
	
	public JavabugsUser(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, List<GrantedAuthority> authorities, 
			String users_name, String cell_phone, String dept_code, String email, String student_check) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		
		this.users_name = users_name;
		this.cell_phone = cell_phone;
		this.dept_code = dept_code;
		this.email = email;
		this.student_check=student_check;
		this.role = new String[authorities.size()];
		
		for(int i=0; i<authorities.size(); i++) {
			GrantedAuthority grantedAuthority = authorities.get(i);
			role[i] = grantedAuthority.getAuthority();
		}
	}
	
	
	

	public String getStudent_check() {
		return student_check;
	}




	public void setStudent_check(String student_check) {
		this.student_check = student_check;
	}




	public String getEmail() {
		return email;
	}




	public void setEmail(String email) {
		this.email = email;
	}




	public String getUsers_name() {
		return users_name;
	}




	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}




	



	public String getCell_phone() {
		return cell_phone;
	}




	public void setCell_phone(String cell_phone) {
		this.cell_phone = cell_phone;
	}




	public String getDept_code() {
		return dept_code;
	}




	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}




	public String[] getRole() {
		return role;
	}

	public void setRole(String[] role) {
		this.role = role;
	}

	


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
