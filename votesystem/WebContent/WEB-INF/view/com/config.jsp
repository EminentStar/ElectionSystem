<%@page import="org.springframework.security.core.context.SecurityContext"%>
<%@page import="net.javabugs.web.common.mvc.model.dto.JavabugsUser"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%
response.setHeader("Pragma", "no-cache");
response.setHeader("Cache-Control", "no-cache,no-store,must-revalidate");
response.setDateHeader("Expires", 0);

//ë¡ê·¸ì¸ì´ ìëìì¼ë©´ ê°ì²´ê°ìë¤! Null! ê·¸ë°ìíê° ë²ì´ì§ììì£ ?

if(session//이게 컨트롤러에서 해줬던 세션받는거랑 같다  여기서 userInfo를 세팅해서 script.jsp에서 userInfo를 쓸수있는것임
		.getAttribute("SPRING_SECURITY_CONTEXT") != null){
 JavabugsUser userInfo = (JavabugsUser)((SecurityContext)session
.getAttribute("SPRING_SECURITY_CONTEXT")).getAuthentication().getPrincipal();
request.setAttribute("userInfo", userInfo); 
}
//<c:set var="userInfo" value="${SPRING_SECURITY_CONTEXT.authentication.principal}" />
%>
