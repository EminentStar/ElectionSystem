<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>

<body id=join-font>
<form action="" class="register">
  <h1>　회 원 가 입</h1>
  <fieldset class="row1">
    <legend>Personal Details</legend>
    <p>
      <label>학 번 * </label>
      <input type="text" name="userId" id="userid"/>
	  <button name="userIdCheck" class="button" id="userIdCheck" style="margin-bottom: auto; margin-top: auto; background-color: #C13E4A; text-decoration: none; color: #FFF; font-size: 11px; font-family: '맑은 고딕';">중복확인</button>
    </p>
    <p>
      <label>이 름 * </label>
      <input type="text" class="long" name="name" id="name"/>
    </p>
    <p>
      <label>비밀번호* </label>
      <input type="password"  name="password" id="password"/>
    </p>
    <p>
      <label>비밀번호 확인* </label>
      <input type="password" name="passwordCheck" id="passwordCheck"/>
    </p>
    <p>
      <label>Phone * </label>
      <input type="text" name="phone"id="phone" maxlength="10"/>
    </p>
     <p>
      <label>E-mail* </label>
      <input type="text" name="email"id="email" maxlength="10"/>
    </p>
    <p>
      <label>학 과 * </label>
      <select>
        <option selected="selected"> </option>
       
      </select>
    </p>
    <br />
  </fieldset>
  <fieldset class="row2">
    <button class="button" name="confirm" id="confirm">회원가입 &raquo;</button>
    <button class="button" name="formreset" id="reset">재등록 &raquo;</button>
  </fieldset>
</form>
</body>
</html>
