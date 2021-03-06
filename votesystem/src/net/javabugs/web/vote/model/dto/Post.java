package net.javabugs.web.example.model.dto;

import org.json.simple.JSONObject;

public class Post {
	/*������ DB�� column�� ���� ���߼���!
	  b.num_bid,
	   b.title, 
	   b.content,
	   u.username, 
	   b.create_dttm,
	   b.fid,
	   f.filename,
	   f.filepath
	 */
	private String num_bid ;
	
	private String title;
	
	private String bbs_type;
	
	private String first_word; 
	
	private String  content;
	

	private String user_id;
	
	private String  users_name;
	
	private String create_dttm ;
	
	private String  fid;
	
	private String  filename;
	
	private String  filepath;
	
	//--------------------------------------------------------

	
	
	public String getTitle() {
		return title;
	}

	public String getBbs_type() {
		return bbs_type;
	}

	public void setBbs_type(String bbs_type) {
		this.bbs_type = bbs_type;
	}

	public String getFirst_word() {
		return first_word;
	}

	public void setFirst_word(String first_word) {
		this.first_word = first_word;
	}

	public String getNum_bid() {
		return num_bid;
	}

	public void setNum_bid(String num_bid) {
		this.num_bid = num_bid;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUsers_name() {
		return users_name;
	}

	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}


	public String getCreate_dttm() {
		return create_dttm;
	}

	public void setCreate_dttm(String create_dttm) {
		this.create_dttm = create_dttm;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	@Override
	public String toString(){
		JSONObject json = new JSONObject();
		json.put("num_bid",num_bid);
		json.put("title",title);
		json.put("content",content);
		json.put("users_name",users_name);
		json.put("create_dttm",create_dttm);
		json.put("fid",fid);
		json.put("filename",filename);
		json.put("filepath",filepath);
		
		return json.toJSONString();
	}
	
}
