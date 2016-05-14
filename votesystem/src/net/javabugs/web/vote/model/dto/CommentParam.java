package net.javabugs.web.example.model.dto;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import net.javabugs.web.common.mvc.model.vo.ParameterVO;

public class CommentParam extends ParameterVO {
	//
	private String cmt_num;
	@NotEmpty
	private String num_bid;
	@NotEmpty
	@Length(max=200, min=1)
	private String comment;

	public String getCmt_num() {
		return cmt_num;
	}

	public void setCmt_num(String cmt_num) {
		this.cmt_num = cmt_num;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getNum_bid() {
		return num_bid;
	}

	public void setNum_bid(String num_bid) {
		this.num_bid = num_bid;
	}
	
	
}
