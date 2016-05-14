package net.javabugs.web.example.model.dto;

public class CheckParam {
	
	public String term;
	public int status;
	
	public String activecheck;
	
	public String getActivecheck() {
		return activecheck;
	}
	public void setActivecheck(String activecheck) {
		this.activecheck = activecheck;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}


}
