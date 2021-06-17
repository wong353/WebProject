<%@page import="java.sql.*"%>
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
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://jsp-webservice.ck6ql6epxmic.ap-northeast-2.rds.amazonaws.com/webproject?serverTimezone=UTC";
		String user = "admin";
		String password2 = "cjsdlf1001";
		
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, password2);
		/* 
			String url = "jdbc:mysql://jsp-webservice.ck6ql6epxmic.ap-northeast-2.rds.amazonaws.com/webproject?serverTimezone=UTC";
		*/
		/* 
			String url = "jdbc:mysql://localhost:3306/webproject?serverTimezone=UTC";
		*/
		/* String query="ALTER TABLE member AUTO_INCREMENT=1; SET @COUNT = 0;UPDATE member SET userno = @COUNT:=@COUNT+1;"; */
		
		%>
</body>
</html>