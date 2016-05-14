package net.javabugs.web.example.model.dto;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.beans.factory.annotation.Value;

@Configurable(preConstruction=true, dependencyCheck=true)
public class Paging {
	
	public Paging(int currPageNo,int totRowCnt){
		this.currPageNo = currPageNo == 0 ? 1:currPageNo;
		this.totRowCnt = totRowCnt;
	}
	
	//표시할 페이지의 갯수 
	@Value("#{javabugsProp['paging.page.size']}") //얘는 스프링이 관리하는 애가 아니니깐 어노테이션 하려면 @Configurable써야한다!
	private int pageCnt;
	//페이지당 표시할 행의 갯수
	@Value("#{javabugsProp['paging.item.size']}") //얘는 스프링이 관리하는 애가 아니니깐 어노테이션 하려면 @Configurable써야한다!
	private int pageRows;
	
	//현재 페이지의 번호
	private int currPageNo;
	
	
	//전체 로우의 갯수
	private int totRowCnt;
	//전체 페이지의 갯수

	public int getEndPageNo() {
		int r = currPageNo * pageCnt;
		int pgSet = pageCnt * pageRows;
		return ((r/pgSet) + (r% pgSet >0 ? 1 : 0)) * pageCnt;
	}

	/*public int getStartPageNo() {
		return getEndPageNo() - pageCnt + 1;
	}*/

	public int getCurrPageNo() {
		return currPageNo;
	}
	
	
	
	public int getPageCnt() {
		return pageCnt;
	}
	


	public int getPageRows() {
		return pageRows;
	}
	


	//첫 페이지의 번호
	//private int firstPageNo;
	public int getFirstPageNo() {
		return 1;  //무조건 1을 리턴하겠다!
	}

	//페이지에서의 시작 로우의 번호
	//private int fromRowNum;
	public int getFromRowNum() {
		//예를들어 현재 페이지가 5페이지라면?
		//41~ 50을 얻어야 쿼리를 수행할 수 있다!
		//그러므로 fromRowNum = 51 을 만들어야한다!  
		return (currPageNo -1) * pageRows + 1;
	}
	
	//페이지에서의 끝 로우의 번호
	//private int toRowNum;
	public int getToRowNum() {
		return currPageNo * pageRows ;
	}

	//마지막 페이지의 번호
	//private int lastPageNo;
	public int getLastPageNo() {
		//전체 행의 갯수가 733개라면?
		// 733/ 페이지당 행의 수 + (나머지가 있으면 : 1) -> 74페이지가 된다
		return totRowCnt / pageRows + (totRowCnt % pageRows > 0 ? 1 : 0 );
	}
	
	//이전 페이지의 번호
	//private int prevPageNo;
	public int getPrevPageNo() {
		//현재 페이지가 23페이지라면
		//이전 페이지는 11을 가르키고 있으면 된다.
		//하지만 현재 페이지가 3페이지라면
		//이전 페이지는 1페이지를 가르켜야 한다.
//		return (currPageNo - pageCnt) / pageCnt * pageCnt +1;
		int tmpNo = ((currPageNo/pageCnt) + (currPageNo % pageCnt > 0 ? 1 : 0) -1) *pageCnt +1;
		return tmpNo - pageCnt > 0 ? tmpNo - pageCnt : 1 ; 
	}
	
	//다음 페이지의 번호
	//private int nextPageNo;
	public int getNextPageNo() {
		//현재 페이지가 33페이지이고, 마지막 페이지가 74페이지라면
		//다음 페이지는 41페이지를 가르키면 된다.
		//하지만 현재 페이지가 71페이지라면
		//다음 페이지는74페이지를 가르켜야 한다.
		//그럼 마지막페이지를 알아야하고 우리가 구해놨죠? 현재페이지는 사용자가 입력한값이니깐
		if(((getLastPageNo() - currPageNo) / pageCnt) > 0 ){
//			return (currPageNo + pageCnt) / pageCnt * pageCnt + 1 ;
			return((currPageNo/pageCnt) + (currPageNo % pageCnt > 0 ? 1 : 0) -1) * pageCnt +1 + pageCnt;
		}else {
			return getLastPageNo();
		}
	}
}
