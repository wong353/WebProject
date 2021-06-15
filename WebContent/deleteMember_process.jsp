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
	
	String userno = request.getParameter("userno");
	String pg = request.getParameter("pg");
	
	try{
		String sql = "DELETE FROM member WHERE userno = ?";
		pstmt = conn.prepareStatement(sql);
		
		pstmt.setString(1, userno);
		pstmt.executeUpdate();
%>	
		<script type="text/javascript">
			alert('삭제 성공했습니다.');
			location.href= "userList.jsp?pg='<%=pg%>'";
		</script>
<%		
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