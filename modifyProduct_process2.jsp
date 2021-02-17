<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="/include/dbconn.jsp"%>
<%
	request.setCharacterEncoding("utf-8");

	String category1 = request.getParameter("category1");
	String category2 = request.getParameter("category2");
%>
<%=category1 %>
<%=category2 %>
</body>
</html>