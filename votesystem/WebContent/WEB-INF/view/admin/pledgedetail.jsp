<%@page import="java.text.SimpleDateFormat"%>
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
		
		$("input[name=list]").bind('click',function(){
			window.location.href="<spring:url value='/pledge/pledgelist'/>";
			
		});
		
		$("#remove").bind('click',function(){
			if(confirm(validation.getMessage('msg_confirm_remove_general',['label.pledge']))){
				$.ajax({
					url: '<spring:url value="/pledge/pledgedetail/"/>${pledge.pledge_id}/${pledge.cand_id}',
					type:'DELETE',
					success : function(data,textStatus,jqxHR){
						var code="msg_alert_complete_general";
						if(data.delCnt==0){
							code="msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_remove']));
						window.location.href="<spring:url value="/pledge/pledgelist"/>";
					},
					error:function(jqXHR, textStatus,errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));
					}
				});
				
			}
		});
		$("#modify").bind('click',function(){
			window.location.href="<spring:url value="/pledge/pledgeconfirm/"/>${pledge.pledge_id}/${pledge.cand_id}";
		});
		
	});
</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
<table align="center" width="700" style="margin-top: 20px">
							<tr align="left" class="titlefont">
								<td colspan="5" class="line"><spring:message
										code="label.pledge.pledgelist" />
									<!-- 공약정보 --></td>
							</tr>
						</table>
						
<table width="700" style="margin-top: 20px" border="1" cellspacing="0" cellpadding="3">
  <tr>
    <td bgcolor="#999999" align="right">후보자 기호</td>
    <td colspan="2"><c:out value="${pledge.cand_id}"/></td>
  </tr>
  <tr>
    <td bgcolor="#999999" align="right">공약 번호</td>
    <td colspan="2"><c:out value="${pledge.pledge_id}"/></td>
  </tr>
    <tr>
    <td colspan="3" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td width="111" bgcolor="#999999" align="center">공약 사항</td>
    <td width="347"><c:out value="${pledge.pledge_title}"/></td>
    <td width="170" align="right"><c:out value="${pledge.crt_dttm}"/></td>
 
  </tr>
  <tr>
    <td height="200" colspan="3"><c:out value="${pledge.pledge_contents}"/></td>
  </tr>
  <tr>

    <td bgcolor="#FFFFFF" align="right" colspan="3"><input id= "modify" name="modify" type="button" value="수정" />
      <input name="remove" id="remove" type="button" value="삭제" />      
      <input name="list" id= "list" type="button" value="목록" /></td>
    </tr>
</table>
</center>
</body>
</html>
