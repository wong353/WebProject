<%@page import="java.io.PrintWriter"%>
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
	String suserid = "";
	
	if (session.getAttribute("id") == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다. 로그인 페이지로 이동합니다.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	%>
</body>
</html>