<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!doctype html>
<html lang="ko">
<head>
    <title>javabugs EXAMPLE</title>
	<script type="text/javascript">
		//window.location.href = "/index";
		window.location.href = "<spring:url value="/home/main"/>";
	</script>
</head>
<body></body>
</html>