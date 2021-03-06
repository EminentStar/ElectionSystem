<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
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
<script type="text/javascript">

$(function() {//document.ready랑 같다?씨발?
	//$("input[name=conditionText]").attr('disabled',true);
	$("input[name=search]").bind('click', function() {
		search();
	});
	$("input[name=conditionText]").bind('keypress', function(e) {
		if (e.keyCode == 13) {
			e.preventDefault();
			search();
		}
	});
	search();// 처음에 무조건 호출해(jQuery로 변경시 해주는 작업)
});

function updateUnion(user_id){
	var conf = confirm(user_id+"의 권한을 총학생회로 바꾸시겠습니까?");
	if(conf){
		$.post("<spring:url value="/user/updateauth"/>"
				,{user_id : user_id, authorities_code : "ROLE_ADMIN"}
				,function(result){
					alert(user_id+"를 총학생회로 바꿨습니다.");			
					window.location.href = "<spring:url value="/user/userlist"/>";
				});
	}else{
		alert("초기리스트로 이동");
		window.location.href = "<spring:url value="/user/userlist"/>";
	}
}
function updateStudent(user_id){
	var conf = confirm(user_id+"의 권한을 일반학생으로 바꾸시겠습니까?");
	if(conf){
		$.post("<spring:url value="/user/updateauth"/>"
				,{user_id : user_id, authorities_code : "ROLE_USER"}
				,function(result){
					alert(user_id+"를 일반학생으로 바꿨습니다.");
					window.location.href = "<spring:url value="/user/userlist"/>";
				});
	}else{
		alert("초기리스트로 이동");
		window.location.href = "<spring:url value="/user/userlist"/>";
	}
}

function search(){
	 $.post("<spring:url value="/user/usersearch"/>"
	         ,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
	         ,function(result) {
	      console.log(result);
	      $("#userList").html("");
	      
	      //새로운 리스트 추가 
	      $(result.userList).each(function(index, user) {
	         var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
	         console.log(result.userList);
	         $tr.append($("<td>").append(user.user_id));
	         $tr.append($("<td>").append(user.users_name));            
	         $tr.append($("<td>").append(user.dept_name));
	         $tr.append($("<td>").append(user.cell_Phone));
	         $("input:radio[name='NAME']:radio[value='VALUE']").attr("checked",true);
	      // $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_USER' /> 일반학생" )); 
	      // $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_ADMIN'/> 총학생회" ));
	         if(user.authorities_code=="ROLE_USER"){
	        //    $("input:radio[name='"+user.user_id+"']:input[value='ROLE_USER']").attr("checked",true);
	           	 $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_USER' checked  /> ROLE_USER" )); 
	             $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_ADMIN' onClick='updateUnion(\""+user.user_id+"\");' /> ROLE_ADMIN" ));
	         }else{//user.authorities_code=="ROLE_ADMIN"
	           	 $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_USER' onClick='updateStudent(\""+user.user_id+"\");' /> ROLE_USER" )); 
	             $tr.append($("<td>").append("<input type='radio' id='authority' name='"+ user.user_id + "' value='ROLE_ADMIN' checked /> ROLE_ADMIN" ));
	         }
	         $("#userList").append($tr);
       
				$tr.bind('mouseover',function(){
					$tr.css("background","#ffffff");
				});
				$tr.bind('mouseleave',function(){
					$tr.css("background","#f0e68c");
				});
      });
   });
}
	
</script>
<title>학생정보/권한수정</title>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<div class="middle">
<center>

<table align="center" width="780" >
		<tr align="left" class="titlefont">
			<td colspan="6" class="line"><spring:message code="label.user.userlist"/><!-- Q&A  -->
			</td>
		</tr>
   </table>
   <br>
<form id="searchForm" name="searchForm">   
<select name="condition" id="condition" onclick='displayResult(this.value)'>
  <option value="null" selected="selected">선택</option>
  <option value="user_id" >학번</option>
  <option value="users_name">이름</option>
  <option value="department">학과</option>
  <option value="authority">권한</option>
</select>

<!-- <script>
function displayResult(condition){
	
	 document.getElementById("conditionT").value=condition;
} 

</script> -->
<input name="conditionT" id="conditionT" type="hidden" size="30" />
	<%-- <c:choose>
  	<c:when test="${conditionT==authority}">
		<input type="radio" id="conditionText" name="conditionText" value="ROLE_USER"/>일반학생
		<input type="radio" id="conditionText" name="conditionText" value="ROLE_ADMIN"/>총학생회
			
	</c:when>
	</c:choose> --%>
		<input name="conditionText" id="conditionText" type="text" size="30"/>
	
	
	<input name="search" id="search" type="button" value="검색" />





</form>
<br>

<table width="780" height="50" border="1" cellspacing="0" cellpadding="3">
  <thead>
  	<tr align="center" bgcolor="#999999">
  	<td colspan="6"><font color="#ffffff">*ROLE_USER=일반학생   ROLE_ADMIN=총학생회*</font></td>
  	</tr>
   <tr align="center" bgcolor="#999999">
    <td width="111">학번</td>
    <td width="111">이름</td>
    <td width="172">학과</td>
    <td width="111">핸드폰번호</td>
    <td colspan="2" width="172">권한</td> 
  </tr>
  </thead>
  
  <tbody id="userList">
  <!-- <tr>
    <td rowspan="2">DB</td>
    <td rowspan="2">DB</td>
    <td rowspan="2">DB</td>
    <td rowspan="2">DB</td>
    <td><input type="radio" name="radio" id="elected_athority" value="elected_athority" />
      총학생회 </td>  
  </tr>
  <tr>
    <td><input type="radio" name="radio" id="student_athority" value="student_athority" />
      일반학생 
     </td>
  </tr>  -->
   
   </tbody>
</table>

<!-- <select name="condition" id="condition">
  <option selected="selected">학번</option>
  <option>이름</option>
  <option>권한</option>
</select>

<input name="conditionText" type="text" />
<input name="search" type="button" value="검색" /> -->
</center>
</div>
</body>
</html>