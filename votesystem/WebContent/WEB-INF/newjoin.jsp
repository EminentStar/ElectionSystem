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
  <h1>��ȸ �� �� ��</h1>
  <fieldset class="row1">
    <legend>Personal Details</legend>
    <p>
      <label>�� �� * </label>
      <input type="text" name="userId" id="userid"/>
	  <button name="userIdCheck" class="button" id="userIdCheck" style="margin-bottom: auto; margin-top: auto; background-color: #C13E4A; text-decoration: none; color: #FFF; font-size: 11px; font-family: '���� ���';">�ߺ�Ȯ��</button>
    </p>
    <p>
      <label>�� �� * </label>
      <input type="text" class="long" name="name" id="name"/>
    </p>
    <p>
      <label>��й�ȣ* </label>
      <input type="password"  name="password" id="password"/>
    </p>
    <p>
      <label>��й�ȣ Ȯ��* </label>
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
      <label>�� �� * </label>
      <select>
        <option selected="selected"> </option>
       
      </select>
    </p>
    <br />
  </fieldset>
  <fieldset class="row2">
    <button class="button" name="confirm" id="confirm">ȸ������ &raquo;</button>
    <button class="button" name="formreset" id="reset">���� &raquo;</button>
  </fieldset>
</form>
</body>
</html>
