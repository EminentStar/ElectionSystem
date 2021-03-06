<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>투표기간활성화/메인수정</title>
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
function deleteResult(deletepic){
	
	 document.getElementById("num_bid").value=deletepic;
}

$(function(){
	/* console.log(${term}); */
	switch("${term}")
	{
	case '1':
		$("input[value=1]").attr("checked",true);
		break;
	case '2':
		$("input[value=2]").attr("checked",true);
		break;
	default:
		$("input[value=3]").attr("checked",true);
	}


	
	$.post("<spring:url value="/home/homesearch"/>"
			,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
			,function(result) {
		//결과처리
		//기존 화면 제거
		//$("#homeList").html("");
		//새로운 리스트 추가
		
		$(result.homeList).each(function(index, home) {
			//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
			 //손가락 표시
			var $tr = $("<tr>");
			$tr.append($("<td align='right'> <input type='radio' id='deletepic' name='deletepic' onclick='deleteResult(this.value)' value='"+home.num_bid+"'/>"));
			$tr.append($("<td>").append(home.title));
			$tr.append($("<td>").append(home.filename));
			$tr.append($("<td>").append(home.filepath));
			$tr.append($("<td>&nbsp;</td>"));
			$("#homeList").append($tr);
						
		});
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

	
	/* window.location.href =vs.config.contextRoot +"/bbs/list/${postParam.bbs_type}"; */
	
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

	$("input[name=checkconfirm]").bind('click',function(){
		$.post('<spring:url value="/vote/homecheck"/>',
		$("#homeCheck").serialize(),
		function(result){
			if(result.data != null  &&  result.data.error != undefined){
				console.log(result.data.error);
			}else{
				alert("설정을 바꿨습니다.");
			}
		
		});
	});
	$("#insert").bind('click',function(){
		$("#homeCheck").submit();
	});
	$("input[name=delete]").bind('click',function(){
		$.post('<spring:url value="/home/delete"/>',
				$("#homeCheck").serialize(),
				function(result){
				if(result.data != null  &&  result.data.error != undefined){
					console.log(result.data.error);
				}else{
					alert("삭제가 완료되었습니다.");
					window.location.href="<spring:url value="/home/homemodify"/>"
				}
			
		});
	});
});


</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<center>
<table align="center" width="780" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line" ><spring:message code="label.home.homemodify"/>
			</td>
		</tr>
		
   </table>
   <br>
<form id="homeCheck" name="homeCheck"
	  method="post"
	  enctype="multipart/form-data"
	  action="<spring:url value="/home/detail"/>">
<input type='hidden' name='num_bid' id='num_bid'/>
<input type="hidden" name="bbs_type" id="bbs_type" value="4"/>
<input type="hidden" name="first_word" id="first_word" value="9"/>
<input type="hidden" name="content" id="content" value='<spring:message code="label.main"/>'/>
<table id="homeList" name="homeList" width="780" height="50" border="1" cellspacing="0" cellpadding="3">
	
  <tr>
    <td height="40" colspan="5" align="left">기간 활성화</td>
    </tr>
  <tr>
    <td width="80">&nbsp;</td>
    <td colspan="3" align="left"><input type="radio" name="activecheck" id="activecheck" onclick="displayResult(this.value)"value="1"/>
      투표기간 활성화</td>
    <td width="80">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3" align="left"><input type="radio" name="activecheck" id="activecheck" onclick="displayResult(this.value)"value="2"/>
     당선자공지기간 활성화 </td>
    <td>&nbsp;</td>
  </tr>
   <tr>
    <td width="80">&nbsp;</td>

    <td colspan="3" align="left"><input type="radio" name="activecheck" id="activecheck" onclick="displayResult(this.value)" value="3" />

     default</td>
    <td width="80">&nbsp;</td>
  </tr>
   
  <tr>
   <td colspan="5" align="right"><input type="button" name="checkconfirm" id="checkconfirm" value="등록" /><input type='hidden' name='checkname' id='checkname'/></td>
    </tr>
  <tr>
    <td height="40" colspan="5" align="left">메인페이지 이미지 변경</td>
    </tr>
  
    
 
  
  <tr>
    <td height="23">&nbsp;</td>
    <td height="23" align="center" bgcolor="#999999">Title 입력</td>
    <td height="23" colspan="2" align="left"><input name="title" type="text" id="title" size="50" /></td>
    <td height="23">&nbsp;</td>
    </tr>
    <!-- <tr>
    <td height="23">&nbsp;</td>
    <td height="23" align="center" bgcolor="#999999">이미지 설명</td>
    <td height="23" colspan="2" align="left"><input name="content" type="text" id="content" size="50" /></td>
    <td height="23">&nbsp;</td>
    </tr> -->
    
  <tr>
    <td height="25">&nbsp;</td>
    <td align="center" bgcolor="#999999">이미지 파일</td>
    <td colspan="2" align="left"><input name="attachment" type="file" id="attachment" size="45" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="25">&nbsp;</td>
    <td colspan="3" align="right"><input type="button" name="insert" id="insert" value="등록" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr align="center">
    <td>&nbsp;</td>
    <td width="130" bgcolor="#999999">Title</td>
    <td width="130" bgcolor="#999999">파일명</td>
    <td width="246" bgcolor="#999999">파일경로</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td height="25">&nbsp;</td>
    <td colspan="3" align="right"><input type="button" name="delete" id="delete" value="삭제" /></td>
    <td>&nbsp;</td>
    
  </tr>
 
  
</table>
</form>
</center>
<script>
function displayResult(activecheck){
	
	 document.getElementById("checkname").value=activecheck;
}
</script>
</body>
</html>
