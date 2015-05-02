package net.javabugs.web.example.model.dto;

public class Pledge {
	
	private String cand_id;
	
	private String pledge_title;
	
	private String pledge_id;
	
	private String pledge_contents;
	
	private String user_name;
	
	private String crt_dttm;
	
	private String upd_id;
	
	private String upd_dttm;
	
	
	public String getCrt_dttm() {
		return crt_dttm;
	}
	public void setCrt_dttm(String crt_dttm) {
		this.crt_dttm = crt_dttm;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getCand_id() {
		return cand_id;
	}
	public void setCand_id(String cand_id) {
		this.cand_id = cand_id;
	}
	
	public String getPledge_title() {
		return pledge_title;
	}
	public void setPledge_title(String pledge_title) {
		this.pledge_title = pledge_title;
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
}
