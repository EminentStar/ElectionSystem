package net.javabugs.web.example.model.dto;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

public class Join {
	
	private String user_id;	
	private String passwd;	
	private String users_name;	
	private String cell_Phone;	
	private String dept_code;	
	private String dept_name;	
	private String student_check;//재학생? 휴학생?
	private String crt_dttm;
	private String upd_id;
	private String upd_dttm;
	private String email;
	private String authorities_code;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getUsers_name() {
		return users_name;
	}
	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}
	public String getCell_Phone() {
		return cell_Phone;
	}
	public void setCell_Phone(String cell_Phone) {
		this.cell_Phone = cell_Phone;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getStudent_check() {
		return student_check;
	}
	public void setStudent_check(String student_check) {
		this.student_check = student_check;
	}
	public String getCrt_dttm() {
		return crt_dttm;
	}
	public void setCrt_dttm(String crt_dttm) {
		this.crt_dttm = crt_dttm;
	}
	public String getUpd_id() {
		return upd_id;
	}
	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}
	public String getUpd_dttm() {
		return upd_dttm;
	}
	public void setUpd_dttm(String upd_dttm) {
		this.upd_dttm = upd_dttm;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthorities_code() {
		return authorities_code;
	}
	public void setAuthorities_code(String authorities_code) {
		this.authorities_code = authorities_code;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
	
}
