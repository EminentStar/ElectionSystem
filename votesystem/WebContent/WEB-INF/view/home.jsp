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
<link rel="stylesheet" href="<spring:url value="/css/blueberry/blueberry.css"/> " />
<link href="<spring:url value="/css/view/mainStyle.css"/>" rel="stylesheet" type="text/css" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<script src="<spring:url value="/js/blueberry/jquery.blueberry.js"/>" ></script>
<script type="text/javascript">
	
	
	/* $(window).load(function() {
		$('.blueberry').blueberry();z
	}); 
	 */
	$(function(){
		console.log(vs.session.user);
		console.log(vs.session.user.role);
		if(vs.session.user.id==""){
			console.log("vs.session.user.id is \"\" .");
		}else{
			console.log("vs.session.user.id is "+vs.session.user.id+".");
		}
		if(vs.session.user.role=="ROLE_USER"){
			console.log("vs.session.user.role is "+vs.session.user.role);
		}
		$.get("<spring:url value="/home/homesearch"/>"
				
				,function(result) {
			
			$(result.homeList).each(function(index, home) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				var $li = $("<li>"); //손가락 표시
				$li.append("<img src=\"../file/download/"+home.fid+"\" />");
				$("#homeList").append($li);
							
			});
			$('.blueberry').blueberry();
			
		});
		//- img is loaded from homemodify.jsp.
		
		//- Quick notice list is is loaded from BBS table(bbs_type : 1)
		$.get("<spring:url value="/home/searchlist/1"/>"
				,function(result){
			$("#noticeList").html("");
			//새로운 리스트 추가
			$(result.postList).each(function(index, post) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
				$tr.append($("<td align='left' style='padding-left:10px;'>").append(post.title));
				var time = post.create_dttm.substr(0,10);
				$tr.append($("<td>").append(time));
				$("#noticeList").append($tr);
				

				$tr.bind('click',function(){
					//alert(post.num_bid);
					window.location.href = "<spring:url value="/bbs/detail/" />"+post.num_bid;  //url 이동하는 문장
				});
		})
		});
		
		//- Quick studentunion list is loaded from BBS table(bbs_type : 3)
		$.get("<spring:url value="/home/searchlist/2"/>"
				,function(result){
			$("#qnaList").html("");
			//새로운 리스트 추가
			$(result.postList).each(function(index, post) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
				$tr.append($("<td align='left' style='padding-left:10px;'>").append(post.title));
				var time = post.create_dttm.substr(0,10);
				$tr.append($("<td>").append(time));
				$("#qnaList").append($tr);
				

				$tr.bind('click',function(){
					//alert(post.num_bid);.
					window.location.href = "<spring:url value="/bbs/detail/" />"+post.num_bid;  //url 이동하는 문장
				});
		});
		
	});
});

	
</script>
<title>Insert title here</title>

</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />

<div class="wrap">
<!-- <script>
$(window).load(function() {
	$('.blueberry').blueberry();
});
</script> -->
  <div  class="blueberry">
  	
	<ul class="slides" id="homeList" name="homeList">
     <!--  <li><a href="#"><img src="세종대학교.png" /></a></li> -->
    <!-- <li><img src="http://localhost:8080/sample/file/download/39" /></li> -->
      <!-- <li><img src="http://marktyrrell.com/labs/blueberry/img/slide3.jpg" /></li>
      <li><img src="http://marktyrrell.com/labs/blueberry/img/slide4.jpg" /></li> -->
    </ul>
  </div>
  <div class="left">
    <table width="340" border="0">
    <thead>
      <tr class="tabletitle">
        <td width="244" height="35" align="left"><spring:message code="bbs.notice.detail"/></td>
        <td width="80" align="right"><a href="<spring:url value="/bbs/list/1" />">MORE+</a></td>
      </tr>
    </thead>
      <tbody id="noticeList">
	    
	   </tbody>
	   <tfoot>
	   </tfoot>
    </table>
  </div>
  <div class="right">
    <table width="340" border="0">
      <thead>
	      <tr class="tabletitle">
	        <td width="244" height="35" align="left"><spring:message code="bbs.qna.title"/></td>
	        <td width="80" align="right"><a href="<spring:url value="/bbs/list/2" />">MORE+</a></td>
	      </tr>
	  </thead>
      <tbody id="qnaList">
	    
	   </tbody>
	   <tfoot>
	   </tfoot>
    </table>
  </div>
</div>
</body>
</html>