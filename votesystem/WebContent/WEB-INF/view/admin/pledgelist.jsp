<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>공약 정보</title>
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">	


$(function(){
	search();

});

function search(){
	$.get("<spring:url value="/pledge/pledgesearch"/>"
			,function(result){
				//console.log(result);
				//console.log(result.pledgeList);
				console.log(result.pledgeList);
				
				$("#ppledgeList").html("");

				
				var tmp = [];
				$(result.pledgeList).each(function(index,pledge){
					if (index == 0) {
						tmp[0] = JSON.parse(JSON.stringify(pledge));
						tmp[0].pledge_title = [pledge.pledge_title];
					} else {
						if (tmp[tmp.length - 1].cand_id == pledge.cand_id) {
							tmp[tmp.length - 1].pledge_title.push(pledge.pledge_title);
						} else {
							tmp[tmp.length] = JSON.parse(JSON.stringify(pledge));
							tmp[tmp.length - 1].pledge_title = [pledge.pledge_title];
						}
					}
				});
				/*
				$(tmp).each(function(index, pledge){
					var $tr = $("<tr style = 'cursor:pointer;'>");
					$tr.append($("<td>").html(pledge.cand_id));
					$tr.append($("<td>").html(pledge.user_name));
					$tr.append($("<td>").html(index + 1));
					
					var title = '';
					$(pledge.pledge_title).each(function(i, t) {
						title += t;
						if (i < pledge.pledge_title.length - 1) {
							title += "<br>";
						}
					});
					
					$tr.append($("<td>").html(title));
					$("#ppledgeList").append($tr);
					
					$tr.bind('click',function(){
						//alert(post.num_bid);.
						window.location.href = "<spring:url value="/pledge/pledgedetail/" />"+pledge.pledge_id +"/"+pledge.cand_id;  //url 이동하는 문장
					});
					$tr.bind('mouseover',function(){
						$tr.css("background","#3CC8C8");
					});
					$tr.bind('mouseleave',function(){
						$tr.css("background","#D8BFD8");
					});
				});
				*/
				
				var rowspan = 1;
				var cnt = 0; 
				$(result.pledgeList).each(function(index,pledge){
					var $tr = $("<tr>");
					//rowsapn의 갯수
					if (cnt == 0) {
						for(var i=0; i<tmp.length; i++) {
							if (tmp[i].cand_id == pledge.cand_id) {
								rowspan = tmp[i].pledge_title.length;
								if (rowspan > 1) {
									$tr.append($("<td rowspan='" + rowspan + "'>").append(pledge.cand_id)); //rowspan
									$tr.append($("<td rowspan='" + rowspan + "'>").append(pledge.user_name)); //rowspan	
								}
								break;
							}
						}	
					}
							
					if (rowspan > 1) {
						cnt ++;
					}
					
					if (cnt == rowspan) {
						cnt = 0;
					}
					
					if (rowspan == 1) {
						$tr.append($("<td style = 'cursor:pointer;'>").append(pledge.cand_id)); //rowspan
						$tr.append($("<td style = 'cursor:pointer;'>").append(pledge.user_name)); //rowspan	
					}
					
					$pledgeIdTd = $("<td style = 'cursor:pointer;'>").append(pledge.pledge_id);
					$tr.append($pledgeIdTd);
					$pledgeTitleTd = $("<td style = 'cursor:pointer;'>").append(pledge.pledge_title);
					$tr.append($pledgeTitleTd);
					$("#ppledgeList").append($tr);
					
					$pledgeIdTd.bind('click',function(){
						//alert(post.num_bid);.
						window.location.href = "<spring:url value="/pledge/pledgedetail/" />"+pledge.pledge_id +"/"+pledge.cand_id;  //url 이동하는 문장
					});
					$pledgeTitleTd.bind('click',function(){
						//alert(post.num_bid);.
						window.location.href = "<spring:url value="/pledge/pledgedetail/" />"+pledge.pledge_id +"/"+pledge.cand_id;  //url 이동하는 문장
					});
					
					/* $pledgeIdTd.bind('mouseover',function(){
						$pledgeIdTd.css("background","#3CC8C8");
					});
					$pledgeIdTd.bind('mouseleave',function(){
						$pledgeIdTd.css("background","#D8BFD8");
					});
					
					$pledgeTitleTd.bind('mouseover',function(){
						$pledgeTitleTd.css("background","#3CC8C8");
					});
					$pledgeTitleTd.bind('mouseleave',function(){
						$pledgeTitleTd.css("background","#D8BFD8");
					}); */
					
				});
			
			});
	
	//등록
	$("#register").bind('click', function(){
		window.location.href = "<spring:url value ="/pledge/pledgeconfirm/new/new" />"; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	});
}

</script>

<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<div class="middle">
<center>
<table align="center" width="780" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line"><spring:message code="label.pledge.pledgelist"/><!-- 공약정보  -->
			</td>
		</tr>
   </table>
   <br>
<table width="780" height="50" border="1" cellspacing="0" cellpadding="3">
	 <thead>
		  <tr align="center" bgcolor="#999999">
		    <td width="111">후보자 기호</td>
		    <td width="111">이름</td>
		    <td width="106">공약 번호</td>
		    <td width="264">공약</td>
		   </tr>
	  </thead>  
	 <tbody id = "ppledgeList">
	 </tbody>
	 <tfoot>
	 </tfoot>
</table>
<br>
<!-- <input name="conditionText" type="text" /> -->
<input name="register" id="register" type="button" value="공약등록" />
</center>
</div>
</body>
</html>
