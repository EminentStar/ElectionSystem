package net.javabugs.web.example.model.dto;

import net.javabugs.web.common.mvc.model.vo.ParameterVO;

/*USER_ID
DEPT_CODE
CAND_ID
VOTE_TIME*/

public class VoteParam extends ParameterVO{
	
	private String user_id;
	
	private String dept_code;
	
	private String cand_id;
	
	private String vote_time;
	
	private String votes;
	
	private String rates;
	
	public String getRates() {
		return rates;
	}
	public void setRates(String rates) {
		this.rates = rates;
	}
	
	
	
	
	public String getRate() {
		return rates;
	}
	public void setRate(String rates) {
		this.rates = rates;
	}
	public String getVotes() {
		return votes;
	}
	public void setVotes(String votes) {
		this.votes = votes;
	}
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
	public String getCand_id() {
		return cand_id;
	}
	public void setCand_id(String cand_id) {
		this.cand_id = cand_id;
	}
	public String getVote_time() {
		return vote_time;
	}
	public void setVote_time(String vote_time) {
		this.vote_time = vote_time;
	}
	

}
