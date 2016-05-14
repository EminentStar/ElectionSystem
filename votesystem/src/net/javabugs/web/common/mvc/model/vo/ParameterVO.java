package net.javabugs.web.common.mvc.model.vo;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;

@Configurable(preConstruction=true, dependencyCheck=true)//이렇게 되어있으면 이게 클래스가 생성될때
//injection이 일어난다 @Value되있죠? 안에 값이 여기 셋팅된다!!
//@value가 없는건 세팅이 안된다!!
//updid crtid를 요기 T(클래스를 의미)시큐리티콘텍스트홀더의.getContext.뭐.뭐.id해서
//저기다 쏙 집어넣어줘요!
//DI가 일어남!
//생성자가 호출된때 집어넣어주는데 얘는 이미 생성이 되어있는애죠?org.springframework.security.core.context.SecurityContextHolder 
//얘가 바로 springSecurityContext이다!(이미생성되어있는!)
//쓰는 방법은 static method라서 getContext() 그리고 되게길어요
//.뭐.마지막에는 
public class ParameterVO {
	//일반 클래스다 그냥 자바빈이고 특이하죠?
	//일반 클래스인데 AOP를 사용하고 있다 
	@Value("#{T(org.springframework.security.core.context.SecurityContextHolder).getContext().getAuthentication().getName()}")
	private String loginUserId;

	@Value("#{T(org.springframework.security.core.context.SecurityContextHolder).getContext().getAuthentication().getName()}")
	private String crtId;
	
	private String crtDttm;
	
	@Value("#{T(org.springframework.security.core.context.SecurityContextHolder).getContext().getAuthentication().getName()}")
	private String updId;
	
	private String updDttm;
	
	private int fromRowNum; 

	private int toRowNum; 
	
	private int currPageNo;
	
	
	
	public int getCurrPageNo() {
		return currPageNo;
	}

	public void setCurrPageNo(int currPageNo) {
		this.currPageNo = currPageNo;
	}

	public int getFromRowNum() {
		return fromRowNum;
	}

	public void setFromRowNum(int fromRowNum) {
		this.fromRowNum = fromRowNum;
	}

	public int getToRowNum() {
		return toRowNum;
	}

	public void setToRowNum(int toRowNum) {
		this.toRowNum = toRowNum;
	}

	public String getLoginUserId() {
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	

	public String getCrtId() {
		return crtId;
	}

	public void setCrtId(String crtId) {
		this.crtId = crtId;
	}

	public String getCrtDttm() {
		return crtDttm;
	}

	public void setCrtDttm(String crtDttm) {
		this.crtDttm = crtDttm;
	}

	public String getUpdId() {
		return updId;
	}

	public void setUpdId(String updId) {
		this.updId = updId;
	}

	public String getUpdDttm() {
		return updDttm;
	}

	public void setUpdDttm(String updDttm) {
		this.updDttm = updDttm;
	}
}
