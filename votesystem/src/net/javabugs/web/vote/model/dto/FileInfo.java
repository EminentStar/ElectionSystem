package net.javabugs.web.example.model.dto;

public class FileInfo {
	
	private String  fid;
	
	private String sub_fid;
	

	private String  filename;
	
	private String  filepath;

	public String getFid() {
		return fid;
	}
 
	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getSub_fid() {
		return sub_fid;
	}
	
	public void setSub_fid(String sub_fid) {
		this.sub_fid = sub_fid;
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

	
	
	
}
