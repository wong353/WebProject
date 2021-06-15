<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ include file="/include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	
	String userno = request.getParameter("userno");
	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String password  = request.getParameter("pwd1");
	String nickname = request.getParameter("nickname");
	String email = request.getParameter("email");
	String birthday = request.getParameter("birthyear")+request.getParameter("birthmonth")+request.getParameter("birthdate");
	String zip = request.getParameter("zip");
	String addr = request.getParameter("addr");
	String addr_detail = request.getParameter("addr_detail");
	String addr_ref = request.getParameter("addr_ref");
	String tel = request.getParameter("tel1")+request.getParameter("tel2")+request.getParameter("tel2");
	

	try {
		String sql = "update member set password=?, nickname=?, email=?, birthday=?, zip=?, addr=?, addr_detail=?, addr_ref=?, tel=? where userno=?";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, password);
		pstmt.setString(2, nickname);
		pstmt.setString(3, email);
		pstmt.setString(4, birthday);
		pstmt.setString(5, zip);		
		pstmt.setString(6, addr);		
		pstmt.setString(7, addr_detail);		
		pstmt.setString(8, addr_ref);		
		pstmt.setString(9, tel);		
		pstmt.setString(10, userno);		
		pstmt.executeUpdate();
		
		String pg="s";
		if(request.getParameter("pg")!=null){
			pg = request.getParameter("pg");
			System.out.println(pg);
			response.sendRedirect("userList.jsp?pg="+pg);
		}
	%>
		<script type="text/javascript">
			alert(<%=pg%>');
		</script>
	<%
		response.sendRedirect("main.jsp");

	} catch (Exception e) {
		out.println("입력 실패");
		out.println(e.getMessage());
		out.println(birthday);		
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	%>
</body>
</html>