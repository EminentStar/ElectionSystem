<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<%@ page import="java.util.Date" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%  Date now = new Date();
	SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");  
	String time = (String)simpleDate.format(now);%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
<title>투표율 현황</title>
<link href="<spring:url value="/css/view/current_voteresult.css" />" rel="stylesheet" type="text/css" />
<!-- <script type="text/javascript">
function gourl(url){
	window.location.href=url;
	
}

</script> -->
</head>
<body style="font-family: '맑은 고딕';">
<jsp:include page="/WEB-INF/view/top.jsp" />

<div class="middle">

<center>
<div class="current_voteresult" id="current_voteresult">

  <div class="content">
    
	  <div class="top_block s1">
			<div class="content" style="font-weight: bold; font-size: 15px; font-family: '맑은 고딕'; vertical-align: middle; text-align: center; color: #FFF;">
			  <table width="99%" height="152" border="0" cellpadding="0" cellspacing="0">
			    <tr>
			      <td>&nbsp;</td>
		        </tr>
			    <tr>
			      <td>&nbsp;</td>
		        </tr>
			    <tr>
			      <td align="center" bgcolor="#FF9900">온 라 인 투 표 현 황</td>
		        </tr>
		      </table>
			  
		</div>
    </div>
        
    <div class="middle_block s2">
			
            
            <div style="height: 360px; width: 33%; float: left; display:table;">
            	<div style="background-color: #FF7979; height:359px; width: 100; float; left; display:table-cell; vertical-align:; font-family: '맑은 고딕'; font-weight: bold; font-size: 14px;">
            
              <table width="96%" height="125" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="right">총 인원 수</td>
                </tr>
                <tr>
                  <td align="right">총 투표자 수</td>
                </tr>
                <tr>
                  <td align="right">투표율</td>
                </tr>
              </table>
               </div>
      </div>
            
            
        <div style="background-color: #FF7979; height: 360px; float: left; width: 33%;">
              <table width="98%" height="125" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td align="center"><input name="e1" style = "text-align:right;" type="text" id="e1" readonly="readonly" value="<c:out value="${vote.total}"/>" />명</td>
                </tr>
                <tr>
                  <td align="center"><input name="e2" style = "text-align:right;" type="text" id="e2" readonly="readonly" value="<c:out value="${vote.total_vote}"/>" />명</td>
                </tr>
                <tr>
                  <td align="center"><input name="e3" style = "text-align:right;" type="text" id="e3" readonly="readonly" value="<c:out value="${vote.rate}"/>" />%</td>
                </tr>
              </table>
      </div>
            
            <div style="background-color: #FF7979; height: 360px; float: left; width: 33%;">
 			</div>
  
    </div>
		
        <div class="top_block s3">
       	  <div class="content" style="text-align: center;">
            	<div style=" position:absolute text-align: left; font-family: '맑은 고딕'; height: 110px; width: 50%; float: left;">최근 업데이트 시간 
            	  <input name="recently_time" type="text" id="recently_time" size="30" readonly="readonly" value="<%=time %>" />
            	</div>
          <%--     <div style="height: 110px; width: 50%; float: left;">
                <form id="form1" name="form1" method="post" action="">
                  <input type="button" name="do_vote" id="do_vote" value="메인으로 가기" onClick="gourl('<spring:url value = "/home/main" />')"/>
                  
                </form>
                
          </div> --%>
       	  </div>
		</div>
	
    </div>
</div>
</center>
</div>
</body>
</html>
