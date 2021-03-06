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
	$("#register").bind('click', function(){
		window.location.href = "<spring:url value ="/candi/candiconfirm/new" />"; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	});
	
	search(); // 처음에 무조건 호출해(jQuery로 변경시 해주는 작업)
	$("#electedreset").bind('click',function(){
		alert("당선자가 초기화 되었습니다.^^;");
		window.location.href = "<spring:url value="/candi/electedreset"/>";
	});
});

  
function search(){
	/* if($("input[name=searchText]").val().length == 0
			&& $(":checked").length == 1 
			&& $($(":checked")[0]).val() == "user_name" ){
			alert("<spring:message code="bbs.notice.writerName.required" />");
			return;
		}  */
		$.post("<spring:url value="/candi/candisearch"/>"
				,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
				,function(result) {
			//결과처리
			//기존 화면 제거
			$("#candiList").html("");
			//새로운 리스트 추가
			$("#electedPerson").html("");
			$(result.candiList).each(function(index, candi) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				if(candi.elected_check == 1){
					$("#electedPerson").append(candi.user_name);
				}
				var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
				if(candi.elected_check != 1){
					$tr.append($("<td>").append("X"));
				}else{//candi.elected_check == 1
					$tr.append($("<td>").append("O"));
				}
				$tr.append($("<td>").append(candi.cand_id));
				$tr.append($("<td>").append(candi.user_id));				
				$tr.append($("<td>").append(candi.user_name));
				$tr.append($("<td>").append(candi.profile));				
				$("#candiList").append($tr);

				$tr.bind('click',function(){
					//alert(post.num_bid);.
					window.location.href = "<spring:url value="/candi/candidetail/" />"+candi.cand_id;  //url 이동하는 문장
				});
				$tr.bind('mouseover',function(){
					$tr.css("background","#3CC8C8");
				});
				$tr.bind('mouseleave',function(){
					$tr.css("background","#D8BFD8");
				});
			});
		});
		
}



</script>
<title>후보자 정보</title>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<div class="middle">
<center>
<table align="center" width="780" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line"><spring:message code="label.candi.candilist"/>
			</td>
		</tr>
   </table>

<table width="780" height="50" border="1" cellspacing="0" cellpadding="3" style="margin-top: 20px">
	<thead>
  		<tr align="center" bgcolor="#999999">
    		<td width="50">당선유무</td>
    		<td width="111">후보자 기호</td>
    		<td width="111">학번</td>
    		<td width="111">이름</td>
    		<td width="244">약력</td>
    	</tr>
    </thead>
    <tbody id="candiList">
    </tbody>
</table>
<br>
		   <!--  <select name="searchCondition">
			  <option value="cand_id" >후보자 기호</option>
			  <option value="user_id">학번</option>
			  <option value="user_name">이름</option>
		    </select>
			<input name="searchText" type="text" />
			<input name="searchButton" type="button" value="검색" /> -->
			<input name="register" id="register" type="button" value="후보자등록" />

			<input name="electedreset" id="electedreset" type="button" value="당선자 초기화" />
 		</td>
 	</tfoot>
</table>
 

</center>
</div>
<div>당선자 : <span  id="electedPerson"></span></div>
</body>
</html>