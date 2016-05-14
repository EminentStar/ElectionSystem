<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
$(function() {//document.ready랑 같다?씨발?
	$("input[name=searchText]").attr('disabled',true);
	$("input[name=searchButton]").bind('click', function() {
		search();
	});
	$("input[name=searchText]").bind('keypress', function(e) {
		if (e.keyCode == 13) {
			e.preventDefault();
			search();
		}
	});

	$(":checkbox").bind('click',function(e){
		$("input[name=searchText]").attr('disabled',$(":checked").length == 0);
			//$("input[name=searchText]").attr('disabled',true);
		if($(":checked").length == 0){
			$("input[name=searchText]").val("");
		}
	});
	search(); // 처음에 무조건 호출해(jQuery로 변경시 해주는 작업)
	
	$("#newPost").bind('click', function(){
		window.location.href = "<spring:url value ="/bbs/form/new/1" />"; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	});
	console.log(vs.session.user.role+" 권한");
	if(vs.session.user.role=="ROLE_USER"){
		$("#newPost").css("visibility", "hidden");
	}
});

function search(){
	if($("input[name=searchText]").val().length == 0//searchText에 입력된 값이 0이고
			&& $(":checked").length == 1 				//checked된 체크박스가 1개이고
			&& $($(":checked")[0]).val() == "users_name" ){//체크된 체크박스의 값이 'users_name'즉 작성자 일때
			
			alert("<spring:message code="bbs.notice.writerName.required" />");//작성자를 입력하라는 창이 뜬다 
			return;
		}
	pagingSearch();
}


function pagingSearch() {//리스트 검색 메서드 
	
	$.post("<spring:url value="/bbs/search/1" />", $("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
			, function(result) {
		//결과처리
		//기존 화면 제거
		$("#bbsList").html("");
		//새로운 리스트 추가
			$(result.postList).each(function(index, post) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
				$tr.append($("<td>").append(post.num_bid));
	//			console.log(post);
				if(post.first_word == "1"){
					$tr.append($("<td>").append("학생회 활동"));
				}
				else if(post.first_word == "2"){
					$tr.append($("<td>").append("시스템"));
				}
				else{
					$tr.append($("<td>").append("기타"));
				}
				
				$tr.append($("<td align='left' style='padding-left:10px'>").append(post.title));
				$tr.append($("<td>").append(post.users_name));
				$tr.append($("<td>").append(post.create_dttm));
				$("#bbsList").append($tr);
				
	
				$tr.bind('click',function(){
					//alert(post.num_bid);.
					window.location.href = "<spring:url value="/bbs/detail/" />"+post.num_bid;  //url 이동하는 문장
				});
				$tr.bind('mouseover',function(){
					$tr.css("background","#ffffff");
				});
				$tr.bind('mouseleave',function(){
					$tr.css("background","#f0e68c");
				});
			});
		
		var $p = result.paging;
//		console.log(result.paging);
//		console.log("$p.currPageNo : "+$p.currPageNo );
//		console.log("$p.nextPageNo : "+$p.nextPageNo );
//		console.log("$p.pageCnt : "+$p.pageCnt );
		
		var r = $p.currPageNo * $p.pageCnt;
//		console.log("var r = : "+ r );
//		console.log("$p.pageCnt : "+$p.pageCnt );
//		console.log("$p.pageRows : "+$p.pageRows );
		
		var pgSet = $p.pageCnt * $p.pageRows; 
//		console.log("pgSet : "+pgSet );
//		console.log("parseInt(r/pgSet) : "+parseInt(r / pgSet) );
//		console.log("(r % pgSet > 0 ? 1 : 0) : "+(r % pgSet > 0 ? 1 : 0) );
//		console.log("(parseInt(r / pgSet) + (r % pgSet > 0 ? 1 : 0)) : "+(parseInt(r / pgSet) + (r % pgSet > 0 ? 1 : 0)) );
//		console.log("$p.pageCnt : "+$p.pageCnt);
		
		var endPageNo = (parseInt(r / pgSet) + (r % pgSet > 0 ? 1 : 0)) * $p.pageCnt;
//		console.log("endPageNo : "+endPageNo);
		
		var startPageNo = endPageNo - $p.pageCnt + 1;
//		console.log("startPageNo : "+startPageNo);
//		console.log("$p.lastPageNo : "+$p.lastPageNo);
		
//		console.log("endPageNo : " +endPageNo);
		if (endPageNo > $p.lastPageNo) {
			endPageNo = $p.lastPageNo;
//			console.log("endPageNo : " +endPageNo);
//			console.log("$p.lastPageNo : " + $p.lastPageNo);
			
			startPageNo = endPageNo - (endPageNo % $p.pageCnt) + 1;
			
//			console.log("endPageNo : " +endPageNo);
//			console.log("startPageNo : " + startPageNo);
//			console.log("-----------------------------------");
		}
		
		var $pagingArea = $("#pagingArea");
		
		$pagingArea.html(""); //이렇게 지울수있다?
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.firstPageNo +")'>first</a>");
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.prevPageNo +")'>prev</a>");
		
		for(var i=startPageNo; i<=endPageNo ; i++){
			if($p.currPageNo == i ){
				$pagingArea.append($("<td>")).append(i);
			}else{
				$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+ i +")'>"+ i +"</a>");
			}
		}
		
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.nextPageNo +")'>next</a>");
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.lastPageNo +")'>last</a>");
	});
	
}

	function goPage(currPageNo){
		//alert(currPageNo);
		$("#currPageNo").val(currPageNo);
		$("input[name='searchCondition']").attr("checked",false);
		pagingSearch();
	}
</script>
<title><spring:message code="bbs.notice.detail"/></title>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />

<!-- 공지사항 게시판이라는 것을 알려준다 -->

<table align="center" width="900" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line"><spring:message code="bbs.notice.detail"/><!-- Q&A  -->
			</td>
		</tr>
   </table>

<br>
<!-- 게시판의 무슨 컬럼들이 있는지 나타내준다 -->
<table align="center" class="tabletitle" width="900">
		<tr>
			<td width="100"><b><spring:message code="bbs.notice.noticeSeq"/></b></td><!-- 글번호 -->
			<td width="100"><b><spring:message code="label.bbs.firstword"/></b></td><!-- 말머리 -->
			<td width="400"><b><spring:message code="bbs.notice.title"/></b></td><!--제목  -->
			<td width="100"><b><spring:message code="label.author"/></b></td> <!-- 작성자 -->
			<td width="200"><b><spring:message code="sys.notice.writeDttm"/></b></td><!-- 작성일시 -->
		</tr>   
<!-- DB정보 불러오기 -->		
		<tbody id="bbsList" class="font">
		</tbody>
		
</table>
	<tfoot>
	<br>
		<td colspan="5">
			<form id="searchForm" style="text-align: center;">
			<input type="hidden" name="currPageNo" id = "currPageNo" value="1" />
			<input type="hidden" name="bbs_type" id = "bbs_type" value="1" /> <!-- 게시판을 구별하기위해 -->
			<!--얘가 폼밖에있으면 폼.serialize()가 안되서 전송이안된다? 그래서 안으로 넣어야한다! -->
				<input type="checkbox" name="searchCondition" value="title" /><spring:message code="bbs.notice.title"/>&nbsp;<!-- 제목 -->
				<input type="checkbox" name="searchCondition" value="content" /><spring:message code="label.content"/>&nbsp; <!-- 내용 -->
				<input type="checkbox" name="searchCondition" value="users_name" /><spring:message code="label.author"/>&nbsp;<!-- 작성자 -->
				<input type="text" name="searchText" maxlength="20" />&nbsp; <input
					type="button" name="searchButton" class="button" value="<spring:message code="label.search"/>" /><!-- 검색  -->
		        <input type="button" name="newPost" id="newPost" class="button" value="<spring:message code="label.insert" />" />	
			</form>
		</td>
	</tfoot>
	<br>
	<table style = "width:500px;" align="center" > <!--result라고 넣어놨었죠? 페이징을 꺼내서 쓰면 된다  -->
		<tr id="pagingArea">
			
		</tr>	
	</table>
	



</body>
</html>