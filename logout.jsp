<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LOGOUT/title>
</head>
<body>
	<%
	session.invalidate();
	//session.removeAttribute("id");

	response.sendRedirect("main.jsp");
	%>
</body>
</html>