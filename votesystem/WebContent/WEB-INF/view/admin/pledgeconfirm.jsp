<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
	
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<title>Insert title here</title>

<script type="text/javascript">
	$(function(){
		<c:choose>
		<c:when test="${crtCnt==0}">
		
			alert(validation.getMessage('msg.alert.error.general',['label.insert']));
			$("#cand_id").val("${pledgeParam.cand_id}");
			$("#pledge_id").val("${pledgeParam.pledge_id}");
			$("#pledge_contents").val("${pledgeParam.pledge_contents}");
			$("#pledge_title").html("${pledgeParam.pledge_title}");
		</c:when>
		<c:when test="${crtCnt==1}">
			alert(validation.getMessage('msg.alert.complete.general',['label.insert']));
			window.location.href = vs.config.contextRoot +"/pledge/pledgelist";
		</c:when>
		<c:otherwise>
			<c:if test="${err != null}">
				$("#cand_id").val("${pledgeParam.cand_id}");
				$("#pledge_id").val("${pledgeParam.pledge_id}");
				$("#pledge_contents").val("${pledgeParam.pledge_contents}");
				$("#pledge_title").html("${pledgeParam.pledge_title}");
				var err = ${err};
				validation.showMessage(err.data.error,'td#label_');
			</c:if>
		</c:otherwise>
	</c:choose>
		
$("#update").bind('click',function(){
			
			if($("#pledgeConfirm").valid()){
				//수정 ajax 수정은 PUT으로 날린다 url은 똑같이! 등록도 똑같이 할꺼다?뭔소리고?
				//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				$.ajax({
					url : '<spring:url value ="/pledge/pledgedetail/" />', // 이라인 지울것임 놔둬도되는데
					//왜지우냐? 
					data : $("#pledgeConfirm").serialize(),
					type : 'PUT',
					success : function(data,textStatus,jqXHR){
						//삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
						var code = "msg_alert_complete_general";
						//삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
						if(data.updCnt == 0){
							code = "msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_update']));
						window.location.href = "<spring:url value="/pledge/pledgelist" />";
					},
					error : function(jqXHR,textStatus, errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));										
						} 
					});	
				//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				}
			});
	$("#list").bind('click',function(){
		window.location.href = "<spring:url value="/pledge/pledgelist" />"
		
	});	
	//등록
	$("#insert").bind('click',function(){
		$.get('<spring:url value="/pledge/checkValidation"/>',
				{"cand_id":$("#cand_id").val()},
				function(result){
					if(result.data.cand_id){
						alert("<spring:message code="label.error.pledge"/>");
					}else{
						$("#pledgeConfirm").submit();	
					}
		
		});	
		
		
	});
});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
<form name= "pledgeConfirm" id="pledgeConfirm" enctype="multipart/form-data"
		method="post" action="<spring:url value="/pledge/pledgedetail"/>" >
	
<table align="center" width="700" style="margin-top: 20px">
							<tr align="left" class="titlefont">
								<td colspan="5" class="line"><spring:message
										code="label.pledge.confirm" />
									<!-- 공약등록 --></td>
							</tr>
						</table>
<table width="700" style="margin-top: 20px" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bgcolor="#999999" align="right">후보자 기호</td>
    <td align="left" colspan="2"><input name="cand_id" type="text" id="cand_id" value="<c:out value="${pledge.cand_id}"/>" size="40" /></td>
    
  </tr>
  <tr>
    <td bgcolor="#999999" align="right">공약 번호</td>
    <td align="left" colspan="2"><input name="pledge_id" type="text" id="pledge_id" value="<c:out value="${pledge.pledge_id}"/>" size="40" /></td>
    
  </tr>
  
  <tr>
    <td align="right" width="111" bgcolor="#999999">공약 사항</td>
    
    <td align="left" colspan="2"><input name="pledge_title" type="text" id="pledge_title" value="<c:out value="${pledge.pledge_title}"/>"size="40"/></td>
  </tr>
  <tr>
    <td height="200" colspan="3"><textarea name="pledge_contents" cols="100" rows="15" id="pledge_contents"><c:out value="${pledge.pledge_contents}"/></textarea></td>
  </tr>
  
  <tr>
    <td align="right" colspan="3">
    	<input name="list" id="list" type="button" value="목록" />
    	 <c:choose>
        	<c:when test = "${pledge !=null}">
        		<input name="update" id="update" type="button" value="수정" />
        	</c:when>
        	<c:otherwise>
        		<input name="insert" id="insert" type="button" value="등록" />
        	</c:otherwise>
        </c:choose>
    </td>
   </tr> 
  
</table>
</form>
</center>
</body>
</html>
