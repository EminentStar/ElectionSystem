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
<link rel="stylesheet" type="text/css" href="bold.css">
<style type="text/css">
	body {
		margin-left: 0px;
		margin-top: 0px;
		margin-right: 0px;
		margin-bottom: 0px;
	}
</style>
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
				});
		var selOpt = "${user.dept_code}";
		
		$("#dept_code>option[value=selOpt]").attr("selected",true);
		$("#user_id").val("${user.user_id}");
		$("#users_name").val("${user.users_name}");
		$("#cell_Phone").val("${user.cell_Phone}");
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
				}
				repasswd : {
					equalTo : "#passwd"
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
				}
			}
		});
		$("input[name=modify]").bind('click',function(){
			$.post('<spring:url value="/home/userModify" />',
					$("#modifyForm").serialize(),
					function(result){
						if(result.data.updCnt != 1){
							validation.getMessage(msg.alert.error.general
									,"<spring:message code="label.modify.userInfo"/> ");
						}else{
							validation.getMessage(msg.alert.complete.general
									,"<spring:message code="label.modify.userInfo"/> ");
							window.location.href = "<spring:url value="/home/main"/>";
						}
			});
		});
		$("input[name=cancel]").bind('click',function(){
			window.location.href = "<spring:url value="/home/usermodify" />";
		});
		
	}); */
</script>
</head>
<body>
<table width="778" align="center">
  <tr>
    <td class="bold">아이디 와 패스워드 찾기</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><form id="form3" name="form3" method="post" action="">
      <table width="100%">
        <tr>
          <td width="31%">&lt;아이디 찾기&gt;</td>
          <td width="69%">&nbsp;</td>
        </tr>
        <tr>
          <td>이름</td>
          <td><label for="textfield2"></label>
            <input type="text" name="textfield2" id="textfield2" /></td>
        </tr>
        <tr>
          <td>휴대폰 번호</td>
          <td><label for="textfield2"></label>
            <input type="text" name="textfield" id="textfield2" /></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><input type="submit" name="button" id="button" value="확인" /></td>
        </tr>
      </table>
    </form></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td><table width="100%">
      <tr>
        <td width="230">&lt;패스워드 찾기&gt;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="230">학번</td>
        <td><input type="text" name="textfield3" id="textfield3" /></td>
      </tr>
      <tr>
        <td width="230">이름</td>
        <td><input type="text" name="textfield4" id="textfield4" /></td>
      </tr>
      <tr>
        <td width="230">휴대폰 번호</td>
        <td><input type="text" name="textfield5" id="textfield5" /></td>
      </tr>
      <tr>
        <td width="230">&nbsp;</td>
        <td><input type="submit" name="button2" id="button2" value="확인" /></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>