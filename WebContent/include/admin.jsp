<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	String userid = "";
	
	if (session.getAttribute("id") != null) {
		userid = (String) session.getAttribute("id");
	} else{
		response.sendRedirect("login.jsp");
	}
	if (!userid.equals("admin")) {
	%>
	<script type="text/javascript">
		alert("접근이 불가합니다! 메인 페이지로 돌아갑니다.");
		location.href="main.jsp";
	</script>
	<%
	}
	%>
</body>
</html>