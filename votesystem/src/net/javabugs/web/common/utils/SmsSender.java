package net.javabugs.web.common.utils;

import net.javabugs.web.common.constant.VSConstants;

public class SmsSender {
	private String msg;
	
	private String phoneNo;
	
	public String sendSms() {
		return VSConstants.RESULT_MAIL_SEND_SUCCESS;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
}
