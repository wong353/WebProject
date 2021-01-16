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
		String p_id = request.getParameter("p_id");
	%>
	<h4>회원탈퇴</h4>
	정말로 회원탈퇴 하시겠습니까?
	<a href="deleteProduct_process.jsp?p_id=<%=p_id%>">회원탈퇴</a>
	<a href="productList.jsp">취소</a>
</body>
</html>