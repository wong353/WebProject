<%@page import="java.io.PrintWriter"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxCursor.Open"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String p_id = request.getParameter("p_id");
	
	try{
		String sql = "DELETE FROM product WHERE p_id = ? ";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, p_id);
		pstmt.executeUpdate();
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제 성공했습니다.')");
		script.println("location.href='productList.jsp'");
		script.println("</script>");
		
	}catch (Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		if(pstmt!=null)pstmt.close();
		if(conn!=null)conn.close();
	}
%>
</body>
</html>