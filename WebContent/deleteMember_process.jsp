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
<title>GARMENTDYING OFFICIAL SITE</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String userNum = request.getParameter("userNum");
	String userId = request.getParameter("userId");
	String pg = request.getParameter("pg");
	
	try{
		// foreign key를 참조하는 값이 있는 컬럼, 테이블 제거 시, 존재하지 않는 테이블을 참조하는 상황이 발생함에따라 foreign key check 비활성화.
		String sql = "SET foreign_key_checks = 0";
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		stmt.close();
		
		sql = "DELETE FROM member WHERE userno = ? && id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, userNum);
		pstmt.setString(2, userId);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "DELETE from cart WHERE user_id = ?";
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, userId);
		pstmt.executeUpdate();
		
		// 다시 활성화
		sql = "SET foreign_key_checks = 1";
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
%>	
		<script type="text/javascript">
			alert('삭제 성공했습니다.');
			location.href= "userList.jsp?pg="+<%=pg%>;
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