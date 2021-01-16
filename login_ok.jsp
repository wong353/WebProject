<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	PrintWriter script = response.getWriter();

	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");

	try {
		String sql = "SELECT userno,id,password,name FROM member WHERE id=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (!rs.equals(id) || !rs.equals(pwd)) {
			script.println("<script>");
			script.println("alert('정보가 틀렸습니다')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		if (rs.next()) {
			String userno = rs.getString("userno");
			String rid = rs.getString("id");
			String rpwd = rs.getString("password");
			String loginName = rs.getString("name");

			if (id.equals(rid) && pwd.equals(rpwd)) {
			session.setAttribute("userno", userno);	//	유저 고유 번호
			session.setAttribute("id", id);	// 아이디
			session.setAttribute("loginName", loginName);	// 이름
			response.sendRedirect("main.jsp");
			}
		}
	} catch (Exception e) {
		out.println("실패");
		out.println(e.getMessage());
	} finally {
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	%>

</html>