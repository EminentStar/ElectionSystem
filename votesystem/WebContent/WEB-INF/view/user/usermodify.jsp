<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><spring:message code="label.modify.userInfo"/></title>
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/usermodify.css"/>">
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
	$(function(){
		var select = $("#dept_code");
		console.log(select);
		$.get(
				'<spring:url value="/join/deptlist"/>',
				function(result){
					$(result.data.deptList).each(function(index, dept){
						var opt;
						opt = document.createElement("option");
						opt.value = dept.dept_code;
						opt.text = dept.dept_name;
						select.append(opt);
					});
					$("#dept_code>option[value='${user.dept_code}']").attr("selected","selected");
				});
		//안될만하네...~.... ajax가 비동기인데 아무리 그래도 서버갔다오는시간보다 이밑의 한줄이 더 느릴까?
		//
	//	var selOpt = "${user.dept_code}";
	//	$("#dept_code>option[value='${user.dept_code}']").attr("selected","selected"); 
		$("#user_id").val("${user.user_id}");
		$("#users_name").val("${user.users_name}");
		$("#cell_Phone").val("${user.cell_Phone}");
		$("#email").val("${user.email}");
		//이렇게 호출하면되는거같아요?
		$.validator.addMethod( //외워야함 정규식을 하기위해 쓴거고 다른걸 체크하기위해 만들거다  자바스크립트에선 정규식을 사용하지 못하니깐 이거 집에가서 공부해보자
				"regex",
				function(value,element,regexp){
					var re = new RegExp(regexp);
					return this.optional(element) || re.test(value);
				},
				"Please check your input."
				);
		$("#modifyForm").validate({
			rules : {
				cell_Phone : {
					required : true,
					maxlength : 15,
					regex : /^01([0|1|6|7|9]?)-([0-9]{3,4})-?([0-9]{4})$/
				},
				passwd : {
					rangelength : [6,12]
				},
				repasswd : {
					equalTo : "#passwd"
				},
				email : {
					maxlength : 50,
					//email : true
					regex :  /[a-z0-9]{2,}@[a-z0-9-]{2,}.[a-z0-9]{2,}/i
				}
				
			},
			messages : {
				cell_Phone : {
					<spring:message code="label.cellphone" var="phone" />
					required : "<spring:message code="NotEmpty.general" arguments="${phone}" />",
					maxlength : "<spring:message code="Length.max.general" arguments="${phone},15" />",
					regex : "<spring:message code="Invalid.format.general" arguments="${phone},010-1111-2222"/>" 
				},
				passwd : {
					<spring:message code ="label.password" var="cpasswd" />
					rangelength : "<spring:message code="Length.general" arguments="${cpasswd},6,12" />"
				},
				repasswd : {
					equalTo: "<spring:message code="EqualTo.password" />"
				},
				email : {
					//Email.email=이메일 형식이 올바르지 않습니다. 예)support@javabugs.net
					<spring:message code="label.email" var="email" />
					maxlength : "<spring:message code="Length.max.general" arguments="${email},50" />",
					regex : "<spring:message code="Email.email" />"
				}
			}
		});
		
		$("input[name=modify]").bind('click',function(){
			$.post('<spring:url value="/home/usermodify" />',
					$("#modifyForm").serialize(),
					function(result){
						if(result.data.updCnt != 1){
							validation.getMessage(msg.alert.error.general
									,"<spring:message code="label.modify.userInfo"/>");
						}else{
							/* validation.getMessage(msg.alert.complete.general
									,"<spring:message code="label.modify.userInfo"/>"); */
							alert("<spring:message code="label.modify.userInfo.success"/> ");
							window.location.href = "<spring:url value="/home/main"/>";
						}
			});
		});
		$("input[name=cancel]").bind('click',function(){
			window.location.href = "<spring:url value="/home/usermodify" />";
		});
		
	});
</script>
</head>

<jsp:include page="/WEB-INF/view/top.jsp" />
<body id=join-font>
<center>
	<table align="center" width="800" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line" ><spring:message code="label.modify.userInfo"/><!-- 회원정보 수정  -->
			</td>
		</tr>
   	 </table>    
<form name="modifyForm" id="modifyForm"
  method="post" 
  action="<spring:url value="/home/usermodify"/>">  
	<table width="700" border="0" cellpadding="5" cellspacing="10">	
	  <tr>
	    <td width="120" align="right" valign="top"><spring:message code="label.userid"/></td>
	    <td width="450" align="left" class="basic-font"><label for="user_id">
	      <input name="user_id" type="text" class="textField" id="user_id" readonly />
	    </label></td>  <!--학번! 수정시 변하지 않음. DB정보 가져옴 -->
	  </tr>
	  <tr>
	    <td width="120" align="right" valign="top"><spring:message code="org.department.user.name"/></td>
	    <td width="450" align="left" class="basic-font"><label for="users_name">
	      <input name="users_name" type="text" class="textField" id="users_name" readonly />
	    </label></td>  <!-- 수정시 변하지 않음. DB정보 가져옴 -->
	  </tr>
	  <tr>
	    <td width="120" align="right" valign="top"><spring:message code="label.password"/></td>
	    <td width="450" align="left"><label for="password">
	      <input name="passwd" type="password" class="textField" id="passwd" />
	    </label></td>
	  </tr>
	 <tr>
	    <td width="120" align="right" valign="top"><spring:message code="label.repassword"/></td>
	    <td width="450" align="left"><label for="password">
	      <input name="repasswd" type="password" class="textField" id="repasswd" />
	    </label></td>
	  </tr>
	 <tr>
	    <td width="120" align="right" valign="top" ><spring:message code="label.cellphone" /></td>
	    <td width="450" align="left"><label>
	      <input name="cell_Phone" type="text" class="textField" id="cell_Phone" />
	    </label></td>
	  </tr>
	 <tr>
	    <td width="120" height="40" align="right" valign="top" ><spring:message code="label.deptname" /></td>
	    <td width="450" align="left" >
	    <select name="dept_code" class="textField" id="dept_code">
	    </select>
       </td>
	 </tr>
     <tr>
	    <td width="120" align="right" valign="top" ><spring:message code="label.email" /></td>
	    <td width="450" align="left"><label>
	      <input name="email" type="text" class="textField" id="email" />
	    </label></td>
	  </tr>
	  <tr>
	    <td colspan="2" align="center">
	     <input type="button" name="modify" class="button" id="modify" value="<spring:message code='label.update'/>" />
	      <input type="button" name="cancel" class="button" id="cancel" value="<spring:message code='label.cancel'/>" />
	    </td>
	  </tr>
	</table>
</form>
</center>
</body>
</html>