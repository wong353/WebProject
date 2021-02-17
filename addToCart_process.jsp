<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file = "include/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("utf-8");
		
		String userid = (String)session.getAttribute("id");
		String p_id = request.getParameter("p_id");
		String sql = "INSERT INTO cart(userid, product_id, amount) VALUES(?,?,?)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userid);
		pstmt.setString(2, p_id);
		pstmt.setString(3, amount);
		
		
	%>
</body>
</html>