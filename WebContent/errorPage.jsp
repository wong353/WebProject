<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error Page</title>
</head>
<body>
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 404}">
		<script type="text/javascript">
			alert('서버가 요청한 페이지를 찾을 수 없습니다.\r 문제가 지속될 시에는 관리자에게 문의해주세요.');
			location.href = "main.jsp";
		</script>
	</c:if>
	<c:if test="${requestScope['javax.servlet.error.status_code'] == 500}">
		<script type="text/javascript">
			alert('서버에 오류가 발생하여 요청을 수행할 수 없습니다. 문제가 지속될 시에는 관리자에게 문의해주세요.');
			location.href = "main.jsp";
		</script>
	</c:if>
</body>
</html>