<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body onload="alert('회원 탈퇴가 완료되었습니다.')">
	 <!-- 팝업창 작동 안 함 -->
	 
	<%
	
	session.invalidate();
	response.sendRedirect("main.jsp");
	%>
	
</body>
</html>