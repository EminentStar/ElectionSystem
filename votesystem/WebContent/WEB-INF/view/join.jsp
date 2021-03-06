<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<!-- 여기다 스크립트하나만듭니다 버튼에다 이벤트 달아야죠? 눌렀을때 뭐해라~-->

<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/join.css"/>">

<script type="text/javascript">
	String.prototype.trim = function(){
		 return this.replace(/(^\s*)|(\s*$)/gi, ""); 
		 //이건 정규식이고 자바스크립트에서 정규식을쓸때 /로 시작하고 ()로 묶으면 하나의 문단같은걸으미해요 
		 //^꺽쇠면 글자의 시작 시작하는 문자가 공백이고 나머지는 다상관없다! 
		 //첫번쨰가 공백이거나 맨뒤가 공백이다? 그러면 이거는 여러개가 나와도 다바꾸겠다! 라는 의미가 됩니다
	};

	String.prototype.checkLength = function( min, max){
		return this.trim().length < min || this.trim().length >max ; 
	};

		$(function(){
			var select = $("#dept_code");
			//console.log(select);
			$.get(
					'<spring:url value="/join/deptlist"/>',
					function(result){
						$(result.data.deptList).each(function(index, dept){
							//console.log(dept.dept_name+" : "+ dept.dept_code);
							//var code = dept.dept_code;
							//var name = dept.dept_name;
							//console.log(code+name);
							/* var opts = document.getElementById("dept_code");
							var opt = document.createElement(dept.dept_code);
							opt.innerText = dept.dept_name;
							opts.insertAdjacentElement("beforeEnd",opt); */
							
							/* var opt = document.createElement('option');
							opt.text = dept.dept_name;
							opt.value = dept.dept_code;
							document.form['joinForm'].elements['selectName'].add(opt); */
							
							var opt;
							opt = document.createElement("option");
							opt.value = dept.dept_code;
							opt.text = dept.dept_name;
							//console.log(opt);
							select.append(opt);
						});
					});
			
			
			 //이렇게 호출하면되는거같아요?
			$.validator.addMethod( //외워야함 정규식을 하기위해 쓴거고 다른걸 체크하기위해 만들거다  자바스크립트에선 정규식을 사용하지 못하니깐 이거 집에가서 공부해보자
					"regex",
					function(value,element,regexp){
						var re = new RegExp(regexp);
						return this.optional(element) || re.test(value);
					},
					"Please check your input."
					);
			 
			$("#joinForm").validate({
				rules:{
					user_id: {//JSON은 키밸류형식이니깐 맞춰야되요?
						required : true,
						/* minlength : 6,
						maxlength : 18 */
						rangelength : [6,18]  //범위설정
					//	regex :  /[^0-9]/
					},
					passwd : {
						required : true,
						rangelength : [6,12]
					},
					repasswd : {
						equalTo: "#passwd"
					},
					users_name : {
						required : true,
						rangelength : [2,12]
					},
					cell_Phone : {
						required : true,
						maxlength : 15,
						regex : /^01([0|1|6|7|9]?)-([0-9]{3,4})-?([0-9]{4})$/
					},
					
					dept_code : {
							required: true
					},
					
					email : {
						required : true,
						maxlength : 50,
						//email : true
						regex :  /[a-z0-9]{2,}@[a-z0-9-]{2,}.[a-z0-9]{2,}/i
					}
				},
				messages:{
					
					user_id: {
						<spring:message code ="label.num" var="cid" /> //이걸찍지않고 변수로 선언할래!
						required : "<spring:message code="NotEmpty.general" arguments="${cid}" />",
						/* minlength : "6자 이상으로 입력하세요.",
						maxlength : "18자 이하로 입력하세요" */
						rangelength : "<spring:message code="Length.general" arguments="${cid},6,18" />"
						//regex: "<spring:message code ="Invalid.format.general" arguments="${cid},092351" />"
						
					},
					passwd : {
						<spring:message code ="label.password" var="cpasswd" />
						required : "<spring:message code="NotEmpty.general" arguments="${cpasswd}" />",
						rangelength : "<spring:message code="Length.general" arguments="${cpasswd},6,12" />"
					},
					
					repasswd : {
						equalTo: "<spring:message code="EqualTo.password" />"
					},
					
					users_name : {
						<spring:message code ="label.name" var="name" /> //이걸찍지않고 변수로 선언할래!
						required : "<spring:message code="NotEmpty.general" arguments="${name}" />",
						/* minlength : "6자 이상으로 입력하세요.",
						maxlength : "18자 이하로 입력하세요" */
						rangelength : "<spring:message code="Length.general" arguments="${name},2,12" />"
					},
					cell_Phone : {
						//Length.max.general={0}은(는) {1}자 이내로 입력해 주세요.
						//Invalid.format.general={0} 형식이 올바르지 않습니다. 예){1}
						<spring:message code="label.cellphone" var="phone" />
						required : "<spring:message code="NotEmpty.general" arguments="${phone}" />",
						maxlength : "<spring:message code="Length.max.general" arguments="${phone},15" />",
						regex : "<spring:message code="Invalid.format.general" arguments="${phone},010-1111-2222"/>"
					},
					dept_code : {
						//Email.email=이메일 형식이 올바르지 않습니다. 예)support@javabugs.net
						<spring:message code="label.dept" var="dept" />					
						required: "<spring:message code = "NotEmpty.general" arguments= "${dept}" />" 
					},
					email : {
						//Email.email=이메일 형식이 올바르지 않습니다. 예)support@javabugs.net
						<spring:message code="label.email" var="email" />
						required : "<spring:message code="NotEmpty.general" arguments="${email}" />",
						maxlength : "<spring:message code="Length.max.general" arguments="${email},50" />",
						regex : "<spring:message code="Email.email" />"
					}
				}
			});
			
			$("#userIdCheck").bind('click',function(){
				//url엔 뭘넣느냐?join컨트롤러에 뭘만들어야죠?checkValidation메소드를 쓰도록하죠
				//console.log($("#joinForm").valid());
				//if($("#joinForm").valid()){//바뀐부분
					//console.log("111111111111111111111111");
				$.get('<spring:url value="/join/checkValidation" />',
						{"user_id":$("#user_id").val()} ,
				function(result){
			 		if(!result.data.user_id){
						//이미 사용중인 아이디 입니다
						alert("<spring:message code="Duplicate.cid" />");
					} 
			 		else if(joinForm.user_id.value!="" && result.data.user_id){ 						
						alert("<spring:message code="label.cid" />");
					}
			 		else{
			 			alert("<spring:message code="label.insert.cid"/>");
			 		}
				});
			//아이디는 한글이없기에 겟으로 보내도 무방 (url,parameter, callback메서드)
				//}
			});
			$("#formreset").bind('click',function(){
	            //url엔 뭘넣느냐?join컨트롤러에 뭘만들어야죠?checkValidation메소드를 쓰도록하죠
	           // console.log($("#joinForm").valid());
	            //if($("#joinForm").valid()){//바뀐부분
	               console.log("111111111111111111111111");
	            $.get('<spring:url value="/join/checkValidation" />',
	                  {"user_id":$("#user_id").val()} ,
	            function(result){
	                	 alert("<spring:message code="label.join.reset.message"/>");
	                     window.location.href = "<spring:url value = "/join/index" />";
	            });
	         //아이디는 한글이없기에 겟으로 보내도 무방 (url,parameter, callback메서드)
	            //}
	         });   
			
			$("#confirm").bind('click',function(){
				//url엔 뭘넣느냐?join컨트롤러에 뭘만들어야죠?checkValidation메소드를 쓰도록하죠
				//console.log($("#joinForm").valid());
				//if($("#joinForm").valid()){//바뀐부분
				console.log("등록버튼 누름 확인");
					
					$.get('<spring:url value="/join/checkValidation" />',
						{"user_id":$("#user_id").val()} ,
				function(result){
			 		if(!result.data.user_id){
						//이미 사용중인 아이디 입니다
						alert("<spring:message code="Duplicate.check" />");
					}else{ 
						//회원 가입 진행
						$.post('<spring:url value="/join/create" />' ,
								$("#joinForm").serialize(),
								function(result){
									//다른방법?
								if(result.data != null  &&  result.data.error != undefined ){
										console.log(result.data.error);
										//validation.showMessage(result.data.error,"td#label_");
										alert("<spring:message code="msg.alert.fail.join" />");
								}else{
									//로그인 페이지로 보내자
									alert("<spring:message code="msg.alert.complete.join" />");
									window.location.href = "<spring:url value = "/login" />";
									
								}
						});
					}
				});
			//아이디는 한글이없기에 겟으로 보내도 무방 (url,parameter, callback메서드)
				//}
			});
		});
		
	</script>
<%--
	 <jsp:include page="../../css/view/menu.css" /> 
	--%>
<title><spring:message code="label.join.title" /></title>
</head>
<body>
<body id="login">

	<form id="joinForm" name="joinForm">
		<table border="0" cellspacing="0" cellpadding="0" id="login-box">
		
			<tr>
				<td width="570" rowspan="16">&nbsp;</td>
				<td height="271" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="160" height="34" colspan="2" align="left">
				<input name="user_id" type="text"
					id="user_id" class="textField" maxlength="10" style="height:25px"/>
				<img src="<spring:url value="../img/Javabugs/recheck.jpg"/>" width="76" height="35" style="vertical-align: middle;" name="userIdCheck" id="userIdCheck">
				
				</td>		
				
			</tr>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><input type="text" class="long"
					name="users_name" class="textField" id="users_name" style="height:25px"/></td>
			</tr>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><input type="password" name="passwd"
					class="textField" id="passwd" style="height:25px"/></td>
			</tr>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><input type="password" name="repasswd"
					class="textField" id="repasswd" style="height:25px"/></td>
			</tr>
			<tr>
				<td height="29" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><input type="text" name="cell_Phone"
					class="textField" id="cell_Phone" style="height:25px"/></td>
			</tr>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><input type="text" name="email"
					class="textField" id="email" style="height:25px"/></td>
			</tr>
			<tr>
				<td height="28" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td height="34" colspan="2" align="left"><select name="dept_code" class="selectField" id="dept_code" style="font-size:12pt"></select></td>
			</tr>
			<tr>
				<td height="26" colspan="2">&nbsp;</td>
			</tr>
			<tr>
				<td width="160" align="left" style="padding-left:88px" colspan="2">
				<img src="<spring:url value="../img/Javabugs/check.jpg"/>" width="76" height="40" name="confirm" id="confirm" /> 
				<img src="<spring:url value="../img/Javabugs/rechecked.jpg"/>" width="76" height="40" name="formreset" id="formreset">
				</td>		
			</tr>
		</table>
	</form>
</body>
</html>
