<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<center>
<!-- head �κ�-->

<table width="700" border="0">
  <tr class="titlefont">
    <td colspan="4" class="line" align="left">Q&amp;A or ��������</td>
    </tr>
<!-- body �κ� -->  
  
  <tr align="center">
    <td width="97"><select name="condition" id="condition" class="condition">
      <option>���Ӹ�����</option>
      <option>�л�ȸȰ��</option>
      <option>�ý���</option>
      <option>��Ÿ</option>
    </select></td>
    
    <td width="78" class="tabletitle">����</td>
    <td width="420" align="left" class="font"><input name="titleText" type="text" size="60" /></td>
    <td width="87">&nbsp;</td>
    </tr>

 <!-- ����κ� -->
  
  <tr class="font">
    <td colspan="4" height="280"><textarea name="content" cols="96" rows="18" id="content"></textarea></td>
    </tr>

<!-- ���ϼ��� -->
  <tr>
    <td height="15" colspan="3" align="left">
    <input name="file" type="file" id="file" size="50" maxlength="50"/></td>

<!-- ������ư -->
    <td height="15" align="center">
    <input name="modify" type="button" class="button" id="modify" value="����" /></td>
    </tr>
</table>

</center>
</body>
</html>
