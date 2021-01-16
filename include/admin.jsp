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
	}
	if (!userid.equals("admin")) {
		response.sendRedirect("login.jsp");
	}
	%>
</body>
</html>