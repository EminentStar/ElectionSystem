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
		<c:choose>
			<c:when test="${crtCnt==0}">
			
				alert(validation.getMessage('msg.alert.error.general',['label.insert']));
				$("#cand_id").val("${candiParam.cand_id}");
				$("#user_name").val("${candiParam.user_name}");
				$("user_id").val("${candiParam.user_id}");
				$("#profile").html("${candiParam.profile}");
			</c:when>
			<c:when test="${crtCnt==1}">
				alert(validation.getMessage('msg.alert.complete.general',['label.insert']));
				window.location.href = "<spring:url value="/candi/candilist" />";
			</c:when>
			<c:otherwise>
				<c:if test="${err != null}">
					$("#cand_id").val("${candiParam.cand_id}");
					$("#user_name").val("${candiParam.user_name}");
					$("#user_id").val("${candiParam.user_id}");
					$("#profile").html("${candiParam.profile}");
					var err = ${err};
					validation.showMessage(err.data.error,'td#label_');
				</c:if>
			</c:otherwise>
		</c:choose>
		
		$("#candiConfirm").validate({
			rules :{
				cand_id:{
					required : true
				},
				user_name:{
					required :true,
					maxlength:10
				},
				user_id:{
					required: true,
					maxlength:8
				},
				profile:{
					required:true,
					maxlength:100
				}
				
			},
			message : {
				cand_id:{
					required : validation.getMessage("NotEmpty_general",["label_candi_id"])
				
				},
				user_name:{
					required: validation.getMessage("NotEmpty_general", ["label_name"]),
					maxlength: validation.getMessage("Length_max_general",["lable_name", 10])
				},
				user_id:{
					required: validation.getMessage("NotEmpty_general", ["label_num"]),
					maxlength: validation.getMessage("Length_max_general",["label_num",8])
				},
				profile:{
					required: validation.getMessage("NotEmpty_general", ["label_candi_profile"]),
					maxlength: validation.getMessage("Length_max_general", ["label_candi_profile", 100])
				}
				
				
			}
		});
		
		$("input[name=list]").bind('click',function(){
			window.location.href = "<spring:url value="/candi/candilist" />"
			});
		
		$("#update").bind('click',function(){
			$.get('<spring:url value="/candi/checkValidation"/>',
					{"user_id":$("#user_id").val()},
					function(result){
						if(result.data.user_id){
							alert("<spring:message code="label.error.cand_id"/>");
						}else{
			
			if($("#candiConfirm").valid()){
				//수정 ajax 수정은 PUT으로 날린다 url은 똑같이! 등록도 똑같이 할꺼다?뭔소리고?
				//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				$.ajax({
					url : '<spring:url value ="/candi/candidetail/" />', // 이라인 지울것임 놔둬도되는데
					//왜지우냐? 
					data : $("#candiConfirm").serialize(),
					type : 'PUT',
					success : function(data,textStatus,jqXHR){
						//삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
						var code = "msg_alert_complete_general";
						//삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
						if(data.updCnt == 0){
							code = "msg_alert_error_general";
						}
						alert(validation.getMessage(code,['label_update']));
						window.location.href = "<spring:url value="/candi/candilist" />";
					},
					error : function(jqXHR,textStatus, errorThrown){
						alert(validation.getMessage('msg_alert_error_general'));										
						} 
					});	
				//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
				}
						}
					});
			});
		//등록
		$("#insert").bind('click',function(){
			$.get('<spring:url value="/candi/checkValidation"/>',
					{"user_id":$("#user_id").val()},
					function(result){
						if(result.data.user_id){
							alert("<spring:message code="label.error.cand_id"/>");
						}else{
							if($("#candiConfirm").valid()){
								$("#candiConfirm").submit();	
							} 
						}
					});
			 
		});	
	});
</script>

</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
<form name="candiConfirm" id="candiConfirm"
 method="post"
 enctype="multipart/form-data"
 action="<spring:url value="/candi/candidetail"/>">
 
 <table align="center" width="700" style="margin-top: 20px">
							<tr align="left" class="titlefont">
								<td colspan="5" class="line"><spring:message
										code="label.candi.confirm" />
									<!-- 후보자등록 --></td>
							</tr>
						</table>
 
  <table width="700" style="margin-top: 20px" border="1" cellspacing="0" cellpadding="3">
    <tr>
      <td width="140" bgcolor="#999999" align="center">후보자 기호</td>

     
      <td width="70" align="left"><input name="cand_id" type="text" id="cand_id" value="<c:out value="${candi.cand_id}"/>"size="4"/></td>
      <td width="111" bgcolor="#999999" align="center">이름</td>
      <td width="90" align="left"><input name="user_name" type="text" id="user_name" value="<c:out value="${candi.user_name}"/>" size="12" /></td>
      
      <td width="111" bgcolor="#999999" align="center">학번</td>
	  <td width="88" align="left"><input name="user_id" type="text" id="user_id" value="<c:out value="${candi.user_id}"/>" size="12"/></td>  

    </tr>
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>
    <tr>
      <td bgcolor="#999999" align="center">약력</td>
      <td colspan="4"></td>
      <td></td>
    <tr>
      <td height="200" colspan="6"><textarea name="profile" cols="89" rows="15" id="profile"><c:out value="${candi.profile}"/></textarea></td>
    </tr>
    <tr>
		<td colspan="2" bgcolor="#999999" align="center" ><spring:message code="label.candi.image"/></td>
		<td td colspan="4" align="left">
		<c:choose>
			<c:when test="${candi != null}"><a href="<spring:url value="/file/download/${candi.cand_id}/1" />"><c:out value="${candi.filename}" /></a></c:when>
			<c:otherwise><input type = "file" name ="attachment" id="attachment" /></c:otherwise>
		</c:choose>
		</td>
		</tr>
	<tr>
		<td colspan="2" bgcolor="#999999" align="center" ><spring:message code="label.candi.poster"/></td>
		<td td colspan="4" align="left">
		<c:choose>
			<c:when test="${candi != null}"><a href="<spring:url value="/file/download/${candi.cand_id}/2" />"><c:out value="${candi.pfilename}" /></a></c:when>
			<c:otherwise><input type = "file" name ="pattachment" id="attachment" /></c:otherwise>
		</c:choose>
		</td>
	</tr>
		<%-- <a href="<spring:url value="/file/download/${post.fid}" />" ><c:out value = "${post.filename}" /></a></td> --%> 
		<!-- 가야할 주소는 file의 download메소드를호출하자 경로를 넘겨주어서?   -->
	
    
    <tr align="right">
      <td colspan="6"><input name="list" id="list" type="button" value="<spring:message code="label.list"/>" />
         <c:choose>
        	<c:when test = "${candi !=null}">
        		<input name="update" id="update" type="button" value="<spring:message code="label.update"/>" />
        	</c:when>
        	<c:otherwise>
        		<input name="insert" id="insert" type="button" value="<spring:message code="label.insert"/>" />        	
        	</c:otherwise>
        </c:choose> </td>
    </tr>
  </table>
  </form>
</center>

</body>
</html>