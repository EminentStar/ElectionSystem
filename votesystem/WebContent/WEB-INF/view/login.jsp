<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%-- <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
	<!-- <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> -->
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<title>Login</title>
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/login-box.css" />">
	<script type="text/javascript" src="<spring:url value="/js/com/extends.js"/>" ></script>
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/join.css"/>">
	<script type="text/javascript">
		window.onload = function() {
		//	document.getElementById("login-box").style.margin = ((window.screen.height - 352) / 4) + 'px auto';
			document.getElementById("login-box").style.display = 'block';
			 
    		var errorCode = "${sessionScope.error}";
    		<c:remove var="error" scope="session"/>
    		var username = "${sessionScope['j_username']}";
    		<c:remove var="j_username" scope="session"/>
    		
    		if (errorCode.trim().length > 0) {
    			if (errorCode.trim() == "7000") {
    				alert('<spring:message code="msg.alert.fail.login" />');
    			} else {
    				alert('<spring:message code="msg.alert.error.generic" />');
    			}
    		}
			
			//var form = document.getElementById("loginform");
        	var userName = document.getElementById("j_username");
        	var passwd = document.getElementById("j_password");
			
			userName.value = username;
			userName.onkeypress = keyPressHandler;
			passwd.onkeypress = keyPressHandler;
		};
		
		function login() {
        	var form = document.getElementById("loginform");
        	var userName = document.getElementById("j_username");
        	var passwd = document.getElementById("j_password");
        	
        	if (userName.value.trim().length == 0) {
        		<spring:message code="label.num" var="label" />
        		alert('<spring:message code="NotEmpty.general" arguments="${label}"/>');
        		userName.focus();
        		return false;
        	} 
        	
        	if (passwd.value.trim().length == 0) {
        		<spring:message code="label.login.password" var="label" />
        		alert('<spring:message code="NotEmpty.general" arguments="${label}" />');
        		passwd.focus();
        		return false;
        	}
        	form.submit();	 
        }
		
		function keyPressHandler(e) {
			var event = window.event ? window.event : e;
			if(event.keyCode == 13) {
				login();
			}
		}
	</script>
</head>
	<body id="login">
	<form id="loginform" action="j_spring_security_check" method="post">
	<table id="login-box" height="412" >
	  <tr>
	    <td width="54%" rowspan="5">&nbsp;</td>
	    <td height="263" colspan="3">&nbsp;</td>
	  </tr>
	  <tr>
	    <td width="19%" height="40" align="left"><input type="text" name="j_username" id="j_username" /></td>
	    <td width="11%" rowspan="2" align="center"><a href="javascript:login();"><img src="<spring:url value="/img/Javabugs/loginsystem.png"/>"/></td>
	    <td width="16%" rowspan="3">&nbsp;</td>
	  </tr>
	  <tr>
	    <td height="40" align="left"><input type="password" name="j_password" id="j_password" /></td>
	  </tr>
	  <tr>
	    <td id="font" height="40"><input type="checkbox" name="_spring_security_remember_me" id="_spring_security_remember_me" value="on" checked/><spring:message code="label.login.auto"/></td>
	    <td id="font" align="right"><a href="<spring:url value="/join/index"/>"/><spring:message code="label.join"/></a></td>
	  </tr>
	  <tr>
	    <td height="15" colspan="3">&nbsp;</td>
	  </tr>
	</table>




	<!-- <form id="loginform" class="register" action="j_spring_security_check" method="post"> -->
    <%-- <span><img src="<spring:url value="/img/Javabugs/h1.png"/>"></span>
    <H1>Login</H1> --%>
  <!-- <fieldset class="row1">
   <legend> 개인정보</legend> -->
  <%-- <p> <label>학 번 * </label> </p>
      <input type="text" name="j_username"   id="j_username" class="text-field" size="30" maxlength="30" style="float: left;"/>
	  
  

  <p> <label>비밀 번호* </label> 
  	
      <input type="password" name="j_password" id="j_password" class="textfield"  size="30" maxlength="30" style=" float: left;"/>
      
	</p>
	<p>
<span><input type="checkbox" id="_spring_security_remember_me" name="_spring_security_remember_me" value="on" checked="true" style="margin: 0px;"> 
</span>

</p>
 </fieldset>
  <fieldset class="row2">
   <p> <label></label>
  	<a href="<spring:url value="/join/index"/>" style="margin-left:30px;"><spring:message code="label.join"/></a>
 	<a href="<spring:url value="/jon/findPwd"/>" style="margin-left:30px;"> <spring:message code="label.password.lost"/></a>
   <div>
  	<a href="javascript:login();"><img src="<spring:url value="/img/login-btn.png"/>" width="103" height="42" style="margin-left:90px;" /></a>
   </div>
  </fieldset> --%>
                
               
	</form>
</body>
</html>

