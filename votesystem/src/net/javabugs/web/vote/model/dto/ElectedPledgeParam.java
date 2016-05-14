package net.javabugs.web.example.model.dto;

public class ElectedPledgeParam {
/*  
	pledge_id
	pledge_title
	pledge_contents
	performance_contents
	performance_check
	fid
*/
	private String pledge_id;
	
	private String pledge_title;
	
	private String pledge_contents;
	
	private String performance_contents;
	
	private String performance_check;
	
	private String fid;

	public String getPledge_id() {
		return pledge_id;
	}

	public void setPledge_id(String pledge_id) {
		this.pledge_id = pledge_id;
	}

	public String getPledge_title() {
		return pledge_title;
	}

	public void setPledge_title(String pledge_title) {
		this.pledge_title = pledge_title;
	}

	public String getPledge_contents() {
		return pledge_contents;
	}

	public void setPledge_contents(String pledge_contents) {
		this.pledge_contents = pledge_contents;
	}

	public String getPerformance_contents() {
		return performance_contents;
	}

	public void setPerformance_contents(String performance_contents) {
		this.performance_contents = performance_contents;
	}

	public String getPerformance_check() {
		return performance_check;
	}

	public void setPerformance_check(String performance_check) {
		this.performance_check = performance_check;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}
	
}

