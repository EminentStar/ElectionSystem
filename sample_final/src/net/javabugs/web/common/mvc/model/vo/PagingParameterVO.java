package net.javabugs.web.common.mvc.model.vo;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;

@Configurable(preConstruction=true, dependencyCheck=true)
public class PagingParameterVO {
	@Value("#{T(org.springframework.security.core.context.SecurityContextHolder).getContext().getAuthentication().getName()}")
	private String loginUserId;

	private int requestedPageNo = 1;
	
	@Value("#{javabugsProp['paging.page.size']}")
	private int pageSize;

	@Value("#{javabugsProp['paging.item.size']}")
	private int itemSize;
	
	@Value("#{T(net.javabugs.web.common.constant.VSConstants).REQUEST_PAGING_KEY}")
	private String parameterName;
	
	private int totalItemCount;
	
	public String getLoginUserId() {
		return loginUserId;
	}

	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}

	public int getRequestedPageNo() {
		return requestedPageNo;
	}

	public void setRequestedPageNo(int requestedPageNo) {
		this.requestedPageNo = requestedPageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getItemSize() {
		return itemSize;
	}

	public void setItemSize(int itemSize) {
		this.itemSize = itemSize;
	}

	public int getTotalItemCount() {
		return totalItemCount;
	}

	public void setTotalItemCount(int totalItemCount) {
		this.totalItemCount = totalItemCount;
	}

	public String getParameterName() {
		return parameterName;
	}

	public void setParameterName(String parameterName) {
		this.parameterName = parameterName;
	}
	
	public int getStartItemNo() {
		return (this.requestedPageNo - 1) * this.itemSize;
	}

	public int getFirstPageNo() {
		return 1;
	}
	
	public int getPrevPageNo() {
		int prevPageNo = getStartPageNo() - 1;
		return prevPageNo < 1 ? getFirstPageNo() : prevPageNo;
	}
	
	public int getStartPageNo() {
		return ((this.requestedPageNo - 1) / this.pageSize) * this.pageSize + 1;
	}	
	
	public int getEndPageNo() {
		int endPageNo = getStartPageNo() + this.pageSize - 1;
		return endPageNo > getLastPageNo() ? getLastPageNo() : endPageNo;
	}
	
	public int getNextPageNo() {
		int nextPageNo = getEndPageNo() + 1;
		return nextPageNo > getLastPageNo() ? getLastPageNo() : nextPageNo;
	}
	
	public int getLastPageNo() {
		int lastPageNo = (int)Math.ceil(this.totalItemCount / (double)this.itemSize);
		return lastPageNo < 1 ? getFirstPageNo() : lastPageNo;
	}
}
