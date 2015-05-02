package net.javabugs.web.common.mvc.model.dto;

public class GroupMember {
	// cid
	private String username;

	private int groupId;
	
	public int getGroupId() {
		return groupId;
	}

	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
