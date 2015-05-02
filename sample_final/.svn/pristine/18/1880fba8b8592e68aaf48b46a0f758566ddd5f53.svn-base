package net.javabugs.web.common.mvc.model.vo;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;

@Configurable(preConstruction=true, dependencyCheck=true)
public class ExtJsPagingParameterVO {
	
	@Value("#{T(org.springframework.security.core.context.SecurityContextHolder).getContext().getAuthentication().getName()}")
	private String loginUserId;
	
	private int page;
	
	private int start;
	
	private String authorityGroup;
	
	@Value("#{javabugsProp['paging.item.size']}")
	private int limit;

	public String getLoginUserId() {
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getAuthorityGroup() {
		return authorityGroup;
	}

	public void setAuthorityGroup(String authorityGroup) {
		this.authorityGroup = authorityGroup;
	}
}
