<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><c:out value="${candi.user_name}"/></title>
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
	$(function(){
		$("input[name=list]").bind('click',function(){
			window.location.href="<spring:url value="/candi/candilist"/>"
			
		});
		$("input[name=upload]").bind('click',function(){
			window.location.href="<spring:url value="/file/upload/${candi.cand_id}/1"/>"
		});
		
		$("#remove").bind('click',function(){
			if(confirm(validation.getMessage('msg_confirm_remove_general',['label_candi']))){
				$.ajax({
					url: '<spring:url value="/candi/candidetail/"/>${candi.cand_id}',
					type:'DELETE',
					success : function(data,textStatus,jqxHR){
						var code="msg_alert_complete_general";
						if(data.delCnt==0){
							code="msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_remove']));
						window.location.href="<spring:url value="/candi/candilist"/>";
					},
					error:function(jqXHR, textStatus,errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));
					}
				});
				
			}
		});
		$("#modify").bind('click',function(){
			window.location.href="<spring:url value="/candi/candiconfirm/"/>${candi.cand_id}";
		});
		$("#elected").bind('click',function(){
			//window.location.href="<spring:url value="/candi/elected/"/>${candi.cand_id}";
			$.post("<spring:url value="/candi/elected/"/>${candi.cand_id}"
					,{user_id : "${userInfo.username}"}
					,function(result){
				if(result.updCnt== 1){
					alert("<spring:message code="label.elected.insert.success"/>");//당선자가 등록되었습니다.
					window.location.href ="<spring:url value="/candi/candilist"/>";
				}else{
					alert("<spring:message code="label.elected.insert.fail"/>");//당선자 등록이 실패하였습니다.
					window.location.href ="<spring:url value="/candi/candilist"/>";
				}
			});
		});
		
	});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
<form name="candiForm" id="candiForm"
	method="post"  
	enctype="multipart/form-data" 
	action = "<spring:url value ="/bbs/detail"/>" >
	
	<table align="center" width="700" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line"><spring:message code="label.candi.candilist"/>
			</td>
		</tr>
   </table>
  <table width="700" border="1" cellspacing="0" cellpadding="3" style="margin-top: 20px">
    <tr>
      <td width="140" bgcolor="#999999" align="center"><spring:message code="label.candi.id"/></td>
      <td width="70" align="center"><c:out value="${candi.cand_id}"/></td>
      <td width="111" bgcolor="#999999" align="center"><spring:message code="label.name"/></td>
      <td width="90" align="center"><c:out value="${candi.user_name}"/></td>
      <td width="111" bgcolor="#999999" align="center"><spring:message code="label.num"/></td>
      <td width="88" align="center"><c:out value="${candi.user_id}"/></td>
    </tr>
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>
  <tr>
    <td bgcolor="#999999" align="center"><spring:message code="label.candi.profile"/></td>
    <td colspan="3"></td>
    <td colspan="2" align="right"><c:out value="${candi.crt_dttm}"/></td>
    </tr>
  <tr>
    <td height="200" colspan="6"><c:out value="${candi.profile}"/></td>
  </tr>
  <tr>
    <td bgcolor="#999999" align="center"><spring:message code="label.candi.image"/></td>
 
    	
    	
    		<td colspan="5" ><a href="<spring:url value="/file/candidownload/${candi.fid}/1"/>"><c:out value="${candi.filename}"/></a></td>
    	 
  
  </tr>
  <tr>
    <td bgcolor="#999999" align="center"><spring:message code="label.candi.image"/></td>
 
    	
    		<td colspan="5" ><a href="<spring:url value="/file/candidownload/${candi.fid}/2"/>"><c:out value="${candi.pfilename}"/></a></td> 
    	
  </tr>
  <tr align="right">
    <td colspan="6">
    <input name="elected" id= "elected" type="button" value="<spring:message code="label.elected.insert"/>"/>
    <input name="modify" id= "modify" type="button" value="<spring:message code="label.update"/>"/>
      <input name="remove" id="remove" type="button" value="<spring:message code="label.remove"/>"/> <!-- 삭제 -->
      <input name="list" id= "list" type="button" value="<spring:message code="bbs.notice.viewlist"/>"/></td>
  </tr>
</table>
</form>
</center>

</body>
</html>