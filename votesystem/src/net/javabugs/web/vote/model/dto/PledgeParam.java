package net.javabugs.web.example.model.dto;

import net.javabugs.web.common.mvc.model.vo.ParameterVO;

public class PledgeParam extends ParameterVO{

	private String cand_id;
	private String user_id;
	private String user_name;
	private String dept_code;
	private String profile;
	private String crt_id;
	private String crt_dttm;
	private String fid;
	
	private String pledge_id;
	private String pledge_contents;
	private String pledge_title;

	
	
	
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getDept_code() {
		return dept_code;
	}
	public void setDept_code(String dept_code) {
		this.dept_code = dept_code;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getCrt_id() {
		return crt_id;
	}
	public void setCrt_id(String crt_id) {
		this.crt_id = crt_id;
	}
	public String getCrt_dttm() {
		return crt_dttm;
	}
	public void setCrt_dttm(String crt_dttm) {
		this.crt_dttm = crt_dttm;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public String getPledge_title() {
		return pledge_title;
	}
	public void setPledge_title(String pledge_title) {
		this.pledge_title = pledge_title;
	}
	public String getCand_id() {
		return cand_id;
	}
	public void setCand_id(String cand_id) {
		this.cand_id = cand_id;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getPledge_id() {
		return pledge_id;
	}
	public void setPledge_id(String pledge_id) {
		this.pledge_id = pledge_id;
	}
	public String getPledge_contents() {
		return pledge_contents;
	}
	public void setPledge_contents(String pledge_contents) {
		this.pledge_contents = pledge_contents;
	}
	
	

}
