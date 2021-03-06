<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<spring:url value ="/css/view/comment.css" />" rel="stylesheet" type="text/css"/>
<link href="<spring:url value ="/css/view/bbsStyle.css" />" rel="stylesheet" type="text/css" />
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<title><c:out value = "${post.title}" /></title>
<script type="text/javascript">
	$(function() {
		$("input[name=list]").bind('click',function(){
				window.location.href = "<spring:url value="/bbs/list/"/>${post.bbs_type}";});
		$("#remove").bind('click',function(){//하기전에 storage에 message_property를 지워야함?
			if(confirm(validation.getMessage('msg_confirm_remove_general',['label_post']))){
				$.ajax({
					url : '<spring:url value ="/bbs/detail/" />${post.num_bid}',
					type : 'DELETE',
					success : function(data,textStatus,jqXHR){
						//삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
						var code = "msg_alert_complete_general";
						//삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
						if(data.delCnt ==0){
							code = "msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_remove']));
						window.location.href = "<spring:url value="/bbs/list/" />${post.bbs_type}";
					},
					error : function(jqXHR,textStatus, errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));										
					} 
				});
				}		
			});
		
		$("#modify").bind('click',function(){
			window.location.href = "<spring:url value="/bbs/form/" />${post.num_bid}/${post.bbs_type}"; 			
		});
		
		$("#commentForm").validate({ 
			rules : {
				comments : {
					required : true,
					rangelength : [1,200]
				}
			},
			messages : {
				comments : {
					required : validation.getMessage('NotEmpty.general',['label.comment']),
					rangelength :validation.getMessage('Length.general',['label.comment',1,200])
				}
			}
		});
		

		$("#regComment").css('cursor','pointer');
		//코멘트 등록
		$("#regComment").bind('click',function(){
			if($("#commentForm").valid()){
				//다됬으면 등록하자!
				$.post(
					'<spring:url value="/cmt/comment" />',
					$("#commentForm").serialize(),
					function(result){
						if(result.error != undefined){
							//실패 에러가 undefined가 아니니깐 있다는거지!
							validation.showMessage(result.error, validation.getMessage('label.comment')); //그리고 showMessage할떄 필드명을 알아야했죠? 필드명을 주면 해당되는밸류값을 가져왔던가요?
									
						}else{
							//성공
							$("#comment").val("").focus();
							loadComments("${post.num_bid}");
						}
					}
				);
			}
		});
		
		loadComments("${post.num_bid}");
	});
	
	var mBtnSrc = "<spring:url value="/img/icons/modify.png"/>";
	var dBtnSrc = "<spring:url value="/img/icons/delete.png"/>";
	
	function loadComments(num_bid){
		$.get(
			'<spring:url value="/cmt/comment" />/'+ num_bid,
			function(result){
				$("#commentList").html("");		
				$(result.data.commentList).each(function(index,comment){
					var ul = $("<ul>").addClass("comment-ul").attr("id",comment.cmt_num);
					var span = $("<span>").html("[ " + comment.crt_id + " ]   ");
					var li = $("<li>").append(span).addClass("comment-li");
					ul.append(li);
					
					span = $("<span>").html(comment.comments);
					li = $("<li>").append(span).addClass("comment-li");
					ul.append(li);
					
					span = $("<span>").html("   [ " + comment.crt_dttm + " ]");
					li = $("<li>").append(span).addClass("comment-li");
					ul.append(li);
					
					
					//여기서 내가 작성한 코멘트이면 버튼을 달아주면 될듯
					if("${userInfo.username}" ==comment.crt_id){ //attr을 사용하면 그 태그에대한 모든속성을 불러올수있다?
						var modifyBtn = $("<image>").addClass("button-small").attr("src",mBtnSrc);
						//객체로 만들어놨기에 바로 바인딩하면 핸들러를 추가하는게 된다
						var deleteBtn = $("<image>").addClass("button-small").attr("src",dBtnSrc);
						
						span = $("<span>")	
							.append(modifyBtn)
							.append(deleteBtn);
						li = $("<li>").append(span).addClass("comment-li");
						ul.append(li);
						//수정
						modifyBtn.bind('click',function(){
							modifyComment(comment.cmt_num);
						});
						//삭제
						deleteBtn.bind('click',function(){
							deleteComment(comment.cmt_num);
						});
					}
					$("#commentList").append(ul);
			});
		});
	}
	function modifyComment(cmt_num){//댓글 수정 메서드
		$("#commentList ul").each(function(idx,rowUl){ //댓글 목록들을 반복문돌린다
			if($(rowUl).attr("id") != cmt_num){ //각 댓글의 id가 파라미터로 들어온 cmt_num과 같지 않으면
				var contentSpan = $("span", ($("li",rowUl)[1]));
				var txtArea = $("textarea", contentSpan);
				if(txtArea.length > 0){
					contentSpan.html(txtArea.html());
					
					var mbtn = $("<image>").addClass("button-small").attr("src",mBtnSrc);
					var dbtn = $("<image>").addClass("button-small").attr("src",dBtnSrc);
				
					$("span>img", ($("li",rowUl)[3])).remove(); //이 객체 바로밑의 span의 img찾아라?도 가능하다?
					$("span",($("li",rowUl)[3])).append(mbtn).append(dbtn);
					
					mbtn.bind('click',function(){
						modifyComment($(rowUl).attr("id"), $("span",($("li",rowUl)[3])));
					});
					dbtn.bind('click', function(){
						deleteComment($(rowUl).attr("id"));
					});
				}
			}
			else{
				var contentSpan = $("span", ($("li",rowUl)[1]));
				contentSpan.html("<textarea>" + contentSpan.html() + "</textarea>");
				
				var newBtn = $("<image>").addClass("button-small")
							.attr("src","<spring:url value="/img/icons/button04.png"/>");
				$("span>img", ($("li",rowUl)[3])).remove(); //이 객체 바로밑의 span의 img찾아라?도 가능하다?
				$("span",($("li",rowUl)[3])).append(newBtn);
				newBtn.bind('click',function(){
						//길이제한 각자 추가하세요
					$.ajax({
						url : "<spring:url value="/cmt/comment" />",
						type : "PUT",
						data:{"num_bid" : "${post.num_bid}", "cmt_num":cmt_num,"comment":$("textarea",contentSpan).val()},
						success : function(result){
							console.log(result.data.updCnt);
							if(result.data.updCnt == 1){//update success
								alert("수정 성공");
								loadComments("${post.num_bid}");
							}else{//result.data.updCnt != 1  ;;update failed
								alert("수정 실패");
							}
						}
					});
				});
			}
		});
	}
	//삭제하기위한 메서드를 여기 만들면된다
	function deleteComment(cmt_num){
		$.ajax({
			url : "<spring:url value="/cmt/comment/"/>"+cmt_num,
			type : "DELETE",
			success : function(result){
				//정상적으로 삭제가 된다? 그럼 commentList를 뿌려주면될꺼고..#$#$#@$@#$
				if(result.data.delCnt ==1){
					alert(validation.getMessage("msg.alert.complete.general",["label.comment"]));
					$("#"+cmt_num).remove();
					//loadComments("${post.num_bid}");
				}
			}
		});
	}
//bbs.notice.title=제목
//bbs.notice.writerName
//csc.qna.content=내용
//label.list=목록
//label.remove=삭제
//label.update=수정
</script>
</head> 
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
		<%-- <div  right; text-align:right; height:30px; width:50%;" >
		<c:if test="${userInfo.username ==post.user_id}">
			<input type="button" id = "modify" name="modify" value="<spring:message code = "label.update"/>" />
			<input type="button" id = "remove" name="remove" value="<spring:message code = "label.remove"/>" />
		</c:if> 
		</div> --%>
	<body>
	<div style=" right;text-align:right;height:30px;width:50%;" >
	<c:if test="${userInfo.users_name ==post.user_id}">
		<input type="button" id = "modify" name="modify" value="<spring:message code = "label.update"/>" />
		<input type="button" id = "remove" name="remove" value="<spring:message code = "label.remove"/>" />
	</c:if> 
	</div>

	<table width="700" border="1">
		  <tr class="titlefont">
		   	 <td colspan="6" align="left" class="line">상세페이지</td>
		   </tr>
    
  <tr align="center">
      <!-- <td width="100" class="font">말머리</td> -->
    <td width="78" class="tabletitle"><spring:message code="bbs.notice.title"/></td>
    <td width="300" align="left" class="font" bordercolor="black"><c:out value = "${post.title}" /></td>
	<td width="70" align="left" class="tabletitle" bordercolor="black"><spring:message code="bbs.notice.writerName"/></td>
    <td align="left"><c:out value = "${post.users_name}" /></td>		
   </tr>
	
  <tr class="font">
    <%-- <td height="280" colspan="2" align="left" class="font" style="border:1px solid gray;"><spring:message code="csc.qna.content"/></td> --%>
	<td height="280" colspan="6" align="left" class="font" style="border:1px solid gray;"><c:out value = "${post.content}" escapeXml="false"/></td>
    </tr>
  <tr>
    <td height="29" class="tabletitle"><spring:message code="bbs.notice.attach"/></td>
    <td height="29" colspan="2" align="left" class="font"><a href="<spring:url value="/file/download/${post.fid}" />" ><c:out value = "${post.filename}" /></td>
    </tr>
    
    
	<td colspan="6" height="29" align="right">
	<c:if test="${userInfo.username ==post.user_id}">
	<input name="remove" type="button" class="button" id="remove" value="<spring:message code = "label.remove"/>" />
    <input name="modify" type="button" class="button" id="modify" value="<spring:message code = "label.update"/>" />
	</c:if>
	<input type = "button" class="button"name = "list" value = '<spring:message code="label.list" />'/> 
	
	</td>
	
	
    </tr>
</table>
<div class="comment" style="width:50%; margin-top:10px">
	<form id="commentForm" name="commentForm">
		<input type="hidden" name = "num_bid" value="${post.num_bid}" />	
	<div id="commentList"></div>
<%-- <% SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss");%> --%>
		<div id="inputComment">
			<ul class="comment-ul">
				<li class="comment-li"><span>${userInfo.users_name}</span></li>
				<li class="comment-li"><span class="wide"><textarea id="comment" name ="comment"></textarea></span></li>
				<li class="comment-li"><span><img id="regComment" alt="comment" src="<spring:url value="/img/icons/comment.png"/>" class="button" /></span></li>
				<%-- <li><span></span><%=sdf.format(new java.util.Date()) %></li> <!--시간 포맷이 별로 안예쁘다? simpleDateFormat써서 해보세요  날자는 일단 뺴고 버튼넣자 버튼 이미지로 해보죠!--> --%>
			</ul>
		</div>
</form>
</div>
</body>
</html>