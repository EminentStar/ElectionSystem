package net.javabugs.web.example.model.dto;

public class Vote {
	private String total; 		//총인원
	private String total_vote;	//총투표인원수
	private String rate;		//총투표율
	private String cand_id;
	private String user_name;
	private String rates; //후보자별 득표율
	private String votedeptcode;	//학과별 투표수
	private String votedeptname;	//학과이름
	private String votecollegename;	//단대이름
	private String collegevoterate;	//단대별 투표율
	private String collegevotepeople;//단대별 투표수
	private String result;		
	private String fid;
	private String dept_name;
	private String profile;
	
	
	
	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getFid() {
		return fid;
	}
	public void setFid(String fid) {
		this.fid = fid;
	}
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getCollegevotepeople() {
		return collegevotepeople;
	}
	public void setCollegevotepeople(String collegevotepeople) {
		this.collegevotepeople = collegevotepeople;
	}
	public String getVotedeptcode() {
		return votedeptcode;
	}
	public void setVotedeptcode(String votedeptcode) {
		this.votedeptcode = votedeptcode;
	}
	public String getVotedeptname() {
		return votedeptname;
	}
	public void setVotedeptname(String votedeptname) {
		this.votedeptname = votedeptname;
	}
	public String getVotecollegename() {
		return votecollegename;
	}
	public void setVotecollegename(String votecollegename) {
		this.votecollegename = votecollegename;
	}
	public String getCollegevoterate() {
		return collegevoterate;
	}
	public void setCollegevoterate(String collegevoterate) {
		this.collegevoterate = collegevoterate;
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
	public String getRates() {
		return rates;
	}
	public void setRates(String rates) {
		this.rates = rates;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getTotal_vote() {
		return total_vote;
	}
	public void setTotal_vote(String total_vote) {
		this.total_vote = total_vote;
	}
	public String getRate() {
		return rate;
	}
	public void setRate(String rate) {
		this.rate = rate;
	}

}
