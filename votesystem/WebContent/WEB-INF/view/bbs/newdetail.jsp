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
<!-- head 부분-->

<table width="700" border="0">
  <tr class="titlefont">
    <td colspan="4" class="line" align="left">Q&amp;A or 공지사항</td>
    </tr>
<!-- body 부분 -->  
  
  <tr align="center">
    <td width="97"><select name="condition" id="condition" class="condition">
      <option>말머리선택</option>
      <option>학생회활동</option>
      <option>시스템</option>
      <option>기타</option>
    </select></td>
    
    <td width="78" class="tabletitle">제목</td>
    <td width="420" align="left" class="font"><input name="titleText" type="text" size="60" /></td>
    <td width="87">&nbsp;</td>
    </tr>

 <!-- 내용부분 -->
  
  <tr class="font">
    <td colspan="4" height="280"><textarea name="content" cols="96" rows="18" id="content"></textarea></td>
    </tr>

<!-- 파일선택 -->
  <tr>
    <td height="15" colspan="3" align="left">
    <input name="file" type="file" id="file" size="50" maxlength="50"/></td>

<!-- 수정버튼 -->
    <td height="15" align="center">
    <input name="modify" type="button" class="button" id="modify" value="수정" /></td>
    </tr>
</table>

</center>
</body>
</html>
