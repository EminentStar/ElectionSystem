package net.javabugs.web.example.model.dto;

import net.javabugs.web.common.mvc.model.vo.ParameterVO;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.web.multipart.MultipartFile;

public class PostParam extends ParameterVO  { //그럼 스프링이 요이름을 찾아서 해당되는 값을 넣어줄것이다?
	
	private String[] searchCondition;
	
	private String searchText;
	
	private String bbs_type;
	
	private String num_bid;
	@NotEmpty
	private String title;
	@NotEmpty
	private String content;
	
	private MultipartFile attachment; //MultipartFile이라는 클래스로 attachment를 받겠다!

	private String fid;
	
	private String first_word;
	private String users_name;
	
	private String filename;
	private String filepath;
	
	
	
	
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

	public String getUsers_name() {
		return users_name;
	}

	public void setUsers_name(String users_name) {
		this.users_name = users_name;
	}

	public String getBbs_type() {
		return bbs_type;
	}

	public void setBbs_type(String bbs_type) {
		this.bbs_type = bbs_type;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public MultipartFile getAttachment() {
		return attachment;
	}

	public void setAttachment(MultipartFile attachment) {
		this.attachment = attachment;
	}

	public String getTitle() {
		return title;
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

	public String[] getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String[] searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getNum_bid() {
		return num_bid;
	}

	public void setNum_bid(String num_bid) {
		this.num_bid = num_bid;
	}

	public String getFirst_word() {
		return first_word;
	}

	public void setFirst_word(String first_word) {
		this.first_word = first_word;
	}

	
	
	
}
