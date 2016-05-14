<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>jQuery UI Accordion - Collapse content</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />

	<script src="http://code.jquery.com/jquery-2.0.3.js"></script>
	<link rel="stylesheet" href="<spring:url value="/css/view/pledgecheck.css"/>"/>
	  <script type="text/javascript">
	$(function() {
	
		//var pledgeCnt = ${pledgeCnt};
		search();
		console.log("${userInfo.role}");
		if(vs.session.user.role!="ROLE_ADMIN"){
			$("#modify").css("visibility", "hidden");
		}
	});
/* <div class="pledge" id="pledge">  
  		<div class="pledgeTitle">
  	 	 	<p width="780px" style="word-break:break-all">공약1</p> 이미지도 넣어야됨 체크유무
    	</div>
   		<div class="pledgeContent">
    		<p  style="width:780px; word-break:break-all"><font style="font-weight: bold; font-size:large;">공약내용</font></p>
     		<p  style="width:780px; word-break:break-all">안녕</p>
    	</div>
  	</div>
  	*/
  	function modifyPledge(index){
  		alert("Go to modify at elected candidate's pledge_id "+index+".");
  		//1. I'm going to send Parameter 'index' and URL is "/pledge/electedpledgemodify" to PledgeController on ajax method is post. 
  		//2. Then, PledgeController's electedpledgemodify method call PledgeService's getElectedPledgeList method.
  		//3. Then, PledgeService's getElectedPledgeList method call PledgeDAO's getElectedPledgeList method.
  		//4. Then, PledgeDAOImpl's getElectedPledgeList method approch pledge.xml's getElectedPledgeList to surround select tag.
  		window.location.href = "<spring:url value ='/pledge/getelectedpledge?pledge_id="+index+"'/>";
  		
  	}
	function search(){
		$.get("<spring:url value="/pledge/pledgechecklist"/>"
			,function(result){
			
			$("#wrap").html("");
			$(result.electedPledgeList).each(function(index,electedPledge){

				console.log(electedPledge.performance_contents);
				var $divPledge = $("<div class='pledge' id='pledge'>");
				
				var $divPledgeTitle = $("<div class='pledgeTitle' id='pledgeTitle'>");
				 if(electedPledge.performance_check==0){
					 $divPledgeTitle.append("<p id='pledge_Title' style='word-break:break-all; width:780px;'>"+electedPledge.pledge_title+"<img width=30px src=\"<spring:url value='/img/not.png'/>\"/>");
				}else{ //When single quotation is located in double quotation, Don't attached back slash. 
					 $divPledgeTitle.append("<p id='pledge_Title' style='word-break:break-all; width:780px;'>"+electedPledge.pledge_title+"<img width=30px src=\"<spring:url value='/img/ok.png'/>\"/>");
				} 

				
				var $divContent = $("<div class='pledgeContent'>");
				$divContent = $("<div class='pledgeContent'>");
				$pTitle = $("<p id='pledge_Contents' style='width:780px; word-break:break-all '>");
				$pTitle.append("<font style='font-weight: bold; font-size:large;'>"+electedPledge.pledge_contents+"</font>");
				$pContent = $("<p id='performance_Contents' style='width:780px; word-break:break-all'>");
				$pContent.append("<font>"+ electedPledge.performance_contents  +"</font>")
				$divContent.append($pTitle);
				$divContent.append($pContent);
				$divPledge.append($divPledgeTitle);
				$divPledge.append($divContent);
				$("#wrap").append($divPledge);	
				/*  
					pledge_id(공약 번호, 수정못하게 제목 왼쪽편에 작게 표시되야함)
					pledge_title(공약 제목, 수정못하게 제목쪽에 div로 하던지 해야함)
					pledge_content(공약의 원래내용, 수정못하게 제목밑에 div로하던지 해야함)
					performance_contents(textarea로 수정할수있어야함)
					performance_check (체크박스로잇어야함)
					fid(공약실천증명할 사진?이건 글에서 올리도록해야함)
				*/
				$pledgeForm = $("<form id='pledgeForm'>");
				$pledgeForm.append("<input type='hidden' name='pledge_id' id='pledge_id' value='"+electedPledge.pledge_id +"' />");
				$pledgeForm.append("<input type='hidden' name='pledge_title' id='pledge_title' value='"+electedPledge.pledge_title+"' />");
				$pledgeForm.append("<input type='hidden' name='pledge_contents' id='pledge_contents' value='"+ electedPledge.pledge_contents +"' />");
				$pledgeForm.append("<input type='hidden' name='performance_contents' id='performance_contents' value='"+electedPledge.performance_contents+"' />");
				$pledgeForm.append("<input type='hidden' name='performance_check' id='performance_check' value='"+electedPledge.performance_check+"'/>");
				$pledgeForm.append("<input type='hidden' name='fid' id='fid' value='"+electedPledge.fid+"' />");
				$("#wrap").append($pledgeForm);
				console.log(vs.session.user);
				if(vs.session.user.role=="ROLE_ADMIN"){
					$divModify = $("<div align='right' style='float:left; width:100%'>");
					$divModify.append("<input type='button' name='modify' id='modify' value='<spring:message code='label.update'/>' onClick='modifyPledge("+(index+1)+");' />");
					$("#wrap").append($divModify);
				}
			});
		});
	}
	</script>
	<script type="text/ecmascript">
		$(document).ready(function(){
			$(".pledgeContent").hide();
			$(".pledge").toggle(openAccordion, closeAccordion);
		});
		
		function openAccordion()
		{
			$(".pledgeContent", this).show("slow");
		}
		
		function closeAccordion()
		{
			$(".pledgeContent", this).hide("slow");
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<br/>
<br/>
<br/>
<br/>
<br/>
<div class="wrap" id="wrap">
<!--공약제목과 공약내용 반복소스-->
<!--  
	var $divTitle = $("<div class='pledge'>");
	$divTitle.append("<p id='pledge_title' width='780px' style='word-break:break-all'>"+pledge_title+</p>);
	var $divContent = $("<div class='pledgeContent'>");
	$divContent = $("<div class='pledgeContent'>");
	$pTitle = $("<p id='pledge_contents' style='width:780px; word-break:break-all'>");
	$pTitle.append("<font style='font-weight: bold; font-size:large;'>"+pledge_contents+"</font>");
	$pContent = $("<p id='performance_contents' style="width:780px; word-break:break-all">");
	$pContent.append(performance_contents);
 -->
   <!--
   <div class="pledge" id="pledge">  
  	 <div class="pledgeTitle">
  	  <p width="780px" style="word-break:break-all">공약1</p> 이미지도 넣어야됨 체크유무
    </div>
    <div class="pledgeContent">
      <p  style="width:780px; word-break:break-all"><font style="font-weight: bold; font-size:large;">공약내용</font></p>
      <p  style="width:780px; word-break:break-all">안녕</p>
    </div>
  </div> -->
</div>

<%-- <div align="right" style="float:left; width:100%">
	<input type="submit" name="modify" id="modify" value="<spring:message code="label.update"/>" />
</div> --%>
</body>
</html>
