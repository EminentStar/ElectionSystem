<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<link href="<spring:url value ="/css/view/bbsStyle.css" />" rel="stylesheet" type="text/css" />
<title><c:out value = "${post.title}"/></title>
<script src="<spring:url value="/js/ckeditor_4.3.1_standard/ckedito	r/ckeditor.js" />"></script>
<script type="text/javascript">
function replaceAll(str, searchStr, replaceStr){
	while (str.indexOf(searchStr) != -1) {
		str = str.replace(searchStr, replaceStr);
	}
	return str;
}
$(function() {
	console.log($("#postForm").serialize());
	
	$(function() {
		CKEDITOR.replace( 'content', {
	        filebrowserUploadUrl: '<spring:url value="/file/upload" />'
	    });

<c:choose>
	<c:when test="${crtCnt == 0}">
	//fail
	alert(validation.getMessage('msg.alert.error.general',['label.insert']));
	$("#title").val("${postParam.title}");
	$("#content").html("${postParam.content}");
	</c:when>
	<c:when test="${crtCnt == 1}">
	//success
	alert(validation.getMessage('msg.alert.complete.general',['label.insert']));
	
	window.location.href = /* "<spring:url value="/bbs/list/"/>${post1.bbs_type}"; */
			vs.config.contextRoot +"/bbs/list/${postParam.bbs_type}";
	
	</c:when>
	<c:otherwise>
	//server side validation 실패
		<c:if test="${err != null}">
			$("#title").val("${postParam.title}");
			$("#content").html("${postParam.content}");
			var err = ${err};
			validation.showMessage(err.data.error,'td#label_');  //우리가 error라고 넣어놨으니깐 error라고 올거같습니다. 근데 제이슨형태로해야한다?
		</c:if>
				//toString()이 껍데기를 만들어줘서 data란게 생김!
	</c:otherwise>			
</c:choose>
		//-----------------------------------------------------------------------------------------------------
		$("#postForm").validate({
			rules : {
				title : {
					required : true,
					maxlength : 50
				},
				content : {
					required : true,
					maxlength : 1000
				}
			},
			messages : {
				title : {
					required : validation.getMessage("NotEmpty_general",["label_title"]),
					maxlength : validation.getMessage("Length_max_general",["label_title" , 50])
				},
				content : {
					required : validation.getMessage("NotEmpty_general",["label_content"]),
					maxlength : validation.getMessage("Length_max_general",["label_content" , 1000])
				}
			}
		});
		
		
		//-------------------------------------------------------------------------------------------------
	 		$("#list").bind('click',function(){
				window.location.href = "<spring:url value="/bbs/list/"/>${postParam.bbs_type}";
				});

$("#update").bind('click',function(){	
	if($("#postForm").valid()){
		//수정 ajax 수정은 PUT으로 날린다 url은 똑같이! 등록도 똑같이 할꺼다?뭔소리고?
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		var title = $("#title").val();
		var content = CKEDITOR.instances.content.getData();
		var bbs_type='${post.bbs_type}';
		var num_bid='${post.num_bid}';
		var first_word=$("#first_word").val();
		var attachment=$("#attachment").val();
		console.log(content);
		content = replaceAll(content,"&nbsp;"," ");
		console.log(content);
		testContent = "content="+content+"&bbs_type=";
		console.log(testContent);
		testContent2 = "문자열붙이자".concat(content);
		console.log(testContent2);
		$.ajax({
			url : '<spring:url value ="/bbs/detail/" />', // 이라인 지울것임 놔둬도되는데
			//왜지우냐? 
			data : 'title='+title+'&content='+content+'&bbs_type='+bbs_type+'&num_bid='+num_bid+'&first_word='+first_word+'$attachment='+attachment,
			type : 'PUT',
			success : function(data,textStatus,jqXHR){
				//삭제된 결과가 1이면 정상적으로 삭제되었으므로 메세지를 출력하고 리스트로 보낸다.
				var code = "msg_alert_complete_general";
				//삭제된 결과가 0이면 이미 삭제된 글이므로 메세지를 출력하고 리스트로 보낸다.
				if(data.updCnt == 0){
					code = "msg_alert_error_general";
				}
				alert(validation.getMessage(code,['label_update']));
				window.location.href = "<spring:url value="/bbs/list/"/>${post.bbs_type}";
			},
			error : function(jqXHR,textStatus, errorThrown){
				alert(validation.getMessage('msg_alert_error_general'));										
			}
			
			});	
		//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		}
	});

		//풋바 업바 인바
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	$("#insert").bind('click',function(){
		 if($("#postForm").valid()){
			$("#postForm").submit();	
		} 
	});	
	//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
});

});
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

	<form name="postForm" id="postForm"
	method="post"  
	enctype="multipart/form-data" 
	action = "<spring:url value ="/bbs/detail"/>" ><!-- 파일 업로드가 있으니 멀티파트로 할꺼다? 응씨발? ㅎㅎ뭔소리  -->
	
		<c:choose>
			<c:when test="${post==null}">
				<input type="hidden" name="bbs_type" id="bbs_type" value="${post1.bbs_type}"/>
			</c:when>
			<c:otherwise>
				<input type="hidden" name ="num_bid" value="${post.num_bid}" />
				<input type="hidden" name="bbs_type" value="${post.bbs_type}" />
			</c:otherwise>
		</c:choose>
		<table align="center" border = "1" style="width:1000px">
		  <tr class="titlefont">
		   	 <td colspan="6" align="left" class="line">등록&수정페이지</td>
		   </tr>	
			<tr>
				
				<td width ="20%" id = "label_title" class="tabletitle"><spring:message code="bbs.notice.title"/></td>
				<td align="left">
				
				<select id="first_word" name="first_word"> <!-- 말머리 -->
			<option value="1"><spring:message code="bbs.studentunion.title"/></option><!-- 학생회 활동  -->
			<option value="2"><spring:message code="label.system"/></option><!-- 시스템  -->
			<option value="3"><spring:message code="label.etc"/></option><!-- 기타  -->
		</select> 
				<input type ="text" name ="title" id="title" size="40" value="<c:out value="${post.title}"/>"/></td>
				<td width = "20%" class="tabletitle"><spring:message code="bbs.notice.writerName"/></td>
				<td width = "20%">
				<c:choose>
					<c:when test="${post == null}"><c:out value = "${userInfo.users_name}" /></c:when>
					<c:otherwise><c:out value="${post.users_name}" /></c:otherwise>
				</c:choose></td>
			</tr>
			
			<tr height = "300px">
				<td id = "label_content"class="tabletitle" ><spring:message code="csc.qna.content"/></td>
				<td valign="top" colspan="3"><textarea style="width:100%; height:100%;" id="content" name="content" class="ckeditor" ><c:out value = "${post.content}" /></textarea></td>
			</tr>
			<tr>
				<td class="tabletitle"><spring:message code="bbs.notice.attach"/></td>
				<td colspan="3" align="left">
				<c:choose>
					<c:when test="${post != null}"><a href="<spring:url value="/file/download/${post.fid}" />"><c:out value="${post.filename}" /></a></c:when>
					<c:otherwise><input type = "file" name ="attachment" id="attachment" /></c:otherwise>
				</c:choose>
				</td>
		
				
			</tr>
			 
		
<tr align="right">
	<td colspan="5">
	<input type = "button" class="button" value = '<spring:message code="label.list" />' id="list" name = "list" />
	 <c:choose>
		<c:when test="${post != null}">
			<input type="button" id ="update" name="update" class="button" value="<spring:message code="label.update" />" />
		</c:when>
		<c:otherwise>
			<input type="button" id ="insert" name="insert" class="button" value="<spring:message code="label.insert" />" />
		</c:otherwise>
	</c:choose>
	</td>
</tr> 
</table>
		
		</form>
</body>
<!-- 
	<center>
<table width="700" border="0">
  <tr align="center">
    <td width="99"><select name="condition" id="condition" class="condition">
      <option>말머리선택</option>
      <option value="1" ><spring:message code="bbs.studentunion.title"/></option>
      <option value="2"><spring:message code="label.system"/></option>
      <option value="3"><spring:message code="label.etc"/></option>
    </select>
    </td>
    <td width="77" class="tabletitle"><spring:message code="bbs.notice.title"/></td>
    <td width="315" align="left" class="font"><input name="titleText" type="text" size="45" /></td>
    <td width="191">&nbsp;</td>
    </tr>
  <tr class="font">
    <td colspan="4" height="280"><textarea name="content" cols="96" rows="18" id="content"><c:out value = "${post.content}" /></textarea></td>
    </tr>
  <tr>
    <td height="15" colspan="3" align="left"><input name="file" type="file" id="file" size="50" maxlength="50"/></td>
    <td height="15" align="center"><input name="list" type="button" class="button" id="confirm" value="<spring:message code="label.list" />" />
      <input name="confirm2" type="button" class="button" id="confirm2" value="<spring:message code="label.insert" />" /></td>
     <td height="15" align="center">&nbsp;</td>
    </tr>
</table>

</center>
 -->
</html>
