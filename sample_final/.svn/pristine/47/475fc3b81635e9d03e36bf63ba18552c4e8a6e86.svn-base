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
<title>elected pledge modify</title>
<script type="text/javascript">
$(function(){
	/*  $("#cand_id").val("${pledgeParam.cand_id}");
	$("#pledge_id").val("${pledgeParam.pledge_id}");
	$("#pledge_contents").val("${pledgeParam.pledge_contents}");
	$("#pledge_title").html("${pledgeParam.pledge_title}"); */
	console.log("${pledge.performance_check}");
	var performance_check = ${pledge.performance_check};
	console.log(performance_check);
	if(performance_check == "0"){
		$("input:radio[name='performance_check']:input[value='0']").attr("checked", true);
	}else{
		$("input:radio[name='performance_check']:input[value='1']").attr("checked", true);
	}
	$("#update").bind('click',function(){
				$.ajax({
					url : '<spring:url value ="/pledge/pledgechecklist/" />', // 이라인 지울것임 놔둬도되는데
					//왜지우냐? 
					data : $("#pledgeConfirm").serialize(),
					type : 'POST',
					success : function(data,textStatus,jqXHR){
						//삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
						var code = "msg_alert_complete_general";
						//삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
						if(data.updCnt == 0){
							code = "msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_update']));
						window.location.href = "<spring:url value="/pledge/pledgecheck" />";
					},
					error : function(jqXHR,textStatus, errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));										
						} 
					});	
				//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
			});
	$("#list").bind('click',function(){
		window.location.href = "<spring:url value="/pledge/pledgecheck" />";
	});	
});
</script>
</head>
<body>
<center>
<form name= "pledgeConfirm" id="pledgeConfirm" >
<table width="700" border="0">
  <tr>
    <td bgcolor="#999999" align="right">공약 기호</td>
    <td align="left"><input name="pledge_id" type="text" id="pledge_id" readonly="readonly" value="<c:out value="${pledge.pledge_id}"/>" size="40" /></td>
    <td align="left">
    	미실천<input name="performance_check" type="radio" id="performance_check" value="0" />
    	실천<input name="performance_check" type="radio" id="performance_check" value="1" />
    </td>
    
  </tr>
  <tr>
    <td bgcolor="#999999" align="right">공약 제목</td>
    <td align="left"><input name="pledge_title" type="text" id="pledge_title" readonly="readonly"  value="<c:out value="${pledge.pledge_title}"/>" size="40" /></td>
    
  </tr>
  
  <tr>
    <td align="right" width="111" bgcolor="#999999">공약 내용</td>
    
    <td height="80" colspan="2"><textarea name="pledge_contents" cols="30" rows="15" id="pledge_contents" readonly="readonly"><c:out value="${pledge.pledge_contents}"/></textarea></td>
  </tr>
  <tr>
  	<td align="right" width="111" bgcolor="#999999">공약 실천내용</td>
    <td height="200" colspan="2"><textarea name="performance_contents" cols="96" rows="15" id="performance_contents"><c:out value="${pledge.performance_contents}"/></textarea></td>
  </tr>
  
  <tr>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#FFFFFF" align="right">
    	<input name="list" id="list" type="button" value="목록" />
   		<input name="update" id="update" type="button" value="수정" />
    </td>
   </tr> 
</table>
</form>
</center>
</body>
</html>