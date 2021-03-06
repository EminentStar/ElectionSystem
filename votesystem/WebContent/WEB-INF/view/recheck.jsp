<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<!-- 여기다 스크립트하나만듭니다 버튼에다 이벤트 달아야죠? 눌렀을때 뭐해라~-->

<script type="text/javascript" src="<spring:url value="/js/com/extends.js"/>" ></script>


<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">

/* 	window.onload = function(){
		var errorCode = "${sessionScope.error}";
		<c:remove var="error" scope="session"/>
		var username = "${sessionScope['myid']}";
		<c:remove var="myid" scope="session"/>
		
		if (errorCode.trim().length > 0) {
			if (errorCode.trim() == "7000") {
				alert('<spring:message code="msg.alert.fail.login" />');
			} else {
				alert('<spring:message code="msg.alert.error.generic" />');
			}
		}
		
    	var passwd = document.getElementById("pwd");
		
		passwd.onkeypress = keyPressHandler;
	};



	function login(){
		var form = document.getElementById("recheckform");
		var passwd = document.getElementById("pwd");
		if (passwd.value.trim().length == 0) {
    		<spring:message code="label.login.password" var="label" />
    		alert('<spring:message code="NotEmpty.general" arguments="${label}" />');
    		passwd.focus();
    		return false;
    	}
    	form.submit();	 
	} 
 */
	
	$(function recheck() {
	
	$("input[name=insert]").bind('click',function(){
		
		$.post('<spring:url value="/home/usercheck" />',
				$("#fm").serialize(),
				function(result){
					if(fm.passwd.value !="" && result.data.updCnt == 0){
						alert("<spring:message code="msg.alert.fail.passwd"/> ");
					}else if(fm.passwd.value==""){
						alert("<spring:message code="msg.alert.null.passwd"/> ");
					}else{
						/* validation.getMessage(msg.alert.complete.general
								,"<spring:message code="label.modify.userInfo"/>"); */
						//alert("<spring:message code="msg.alert.complete.title"/> ");
						window.location.href = "<spring:url value="/home/usermodify"/>";
					}
					
		});
	});
	});
	
	/* function keyPressHandler(e) {
			
			var event = window.event ? window.event : e;
			if(event.keyCode == 13) {
				login();
			}
		}   */
	
	
</script>
</head>

<body>
<jsp:include page="/WEB-INF/view/top.jsp" />

<div id="content">

  <table align="center" width="800" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line" ><spring:message code="label.modify.userInfo"/><!-- 회원정보 수정  -->
			</td>
		</tr>
   </table>
   <br>
   
  <div class="section">
    <form name="fm" id="fm">
      <input type="hidden" name="user_id" id ="user_id" value="${userInfo.username}"/>
      <!-- <input type="hidden" name="menu" value="" />
            <input type="hidden" name="token_help" value="ONo9bgNErGWkVbk1" /> -->
      <div class="box2" style="padding-bottom:0px">
        <dl class="id_pw">
        
          <dd><strong><img src="https://static.nid.naver.com/images/user/images/help/dt_id.gif" width="35" height="15" style="margin-right:15px;" alt="아이디"/>${userInfo.username}</strong></dd>
          
          <dd>
            <div class="help_wrap"  style=" zoom:1; padding-top:10px;"><img src="https://static.nid.naver.com/images/user/images/help/dt_pw.gif" width="46" height="15" alt="비밀번호"/>
              <input name="passwd" type="password" id="passwd" maxlength="16" class="input_text" style="width:93px;" />
              <div id="help2_1" class="help left h32" style="display:none; top:-5px; left:90%; z-index: 10000; margin-left:6px"> <span class="shadow1"></span> <span class="shadow2"></span> <span class="arrow"></span> </div>
            </div>
          </dd>
        </dl>
      
        <p class="desc5" style="padding-bottom:0; font-family: '맑은 고딕';">외부로부터 <strong>${userInfo.users_name}</strong>님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인 합니다.<br />
          항상 비밀번호는 타인에게 노출되지 않도록 주의해 주세요.</p>
      </div>
      <div class="btn_area" style="padding-top:3px; padding-left:170px">
        <input name="insert" id= "insert" type="button" value ="확인"/>
      </div>
      <!-- src="https://static.nid.naver.com/images/user/images/help/btn_confirm.gif" alt="확인" -->
      
    </form>
  </div>
</div>
</body>
</html>