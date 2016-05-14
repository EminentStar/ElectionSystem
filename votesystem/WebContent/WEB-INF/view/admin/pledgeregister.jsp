<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
<title>Insert title here</title>
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
	
	 //이렇게 호출하면되는거같아요?
	$.validator.addMethod( //외워야함 정규식을 하기위해 쓴거고 다른걸 체크하기위해 만들거다  자바스크립트에선 정규식을 사용하지 못하니깐 이거 집에가서 공부해보자
			"regex",
			function(value,element,regexp){
				var re = new RegExp(regexp);
				return this.optional(element) || re.test(value);
			},
			"Please check your input."
			);
	 
	
	$("input[name=confirm]").bind('click',function(){
		//url엔 뭘넣느냐?join컨트롤러에 뭘만들어야죠?checkValidation메소드를 쓰도록하죠
		console.log($("#pledgeRegister").valid());
		//if($("#joinForm").valid()){//바뀐부분
		$.post('<spring:url value="/pledge/pledgesearch" />' ,
							$("#pledgeRegister").serialize(),
		function(result){
			
			if(result.data != null  &&  result.data.error != undefined){
				console.log(result.data.error);
			}else{
			
			alert("<spring:message code="label.complete.vote" />");
	        window.location.href = "<spring:url value = '/pledge/pledgelist' />";
			}
				});
		
		});

</script>
</head>
<body>
<center>

<form id="pledgeRegister" name="pledgeRegister">
<table width="700" border="1">
  <tr>
    <td bgcolor="#999999" align="right">후보자 기호</td>
    <td align="left"><input name="cand_id" type="text" id="cand_id" size="4" /></td>
    <td><input name="cand_id" type="text" id="cand_id" /></td>
  </tr>
  <tr>
    <td bgcolor="#999999" align="right">공약 번호</td>
    <td align="left"><input name="pledge_id" type="text" id="pledge_id" size="4" /></td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td colspan="3" bgcolor="#FFFFFF">&nbsp;</td>
    </tr>
  <tr>
    <td width="111" bgcolor="#999999">공약 사항</td>
    <td width="347"><input name="pledge_title" type="text" id="pledge_title" size="4" /></td>
    <td width="170" align="right">&nbsp;</td>
  </tr>
  <tr>
    <td height="200" colspan="3"><textarea name="pledge_contents" cols="96" rows="15" id="pledge"></textarea></td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#FFFFFF">&nbsp;</td>
    <td bgcolor="#FFFFFF" align="right">
    <input name="confirm" type="button" value="등록" />
    <input name="list" type="button" value="목록" />
    </td>
    </tr>
</table>
</form>
</center>
</body>
</html>
