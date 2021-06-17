<%@page import="java.io.PrintWriter"%>
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

	String reason = request.getParameter("reason");
	String id = (String) session.getAttribute("id");
	String userno = (String) session.getAttribute("userno");

	try {
		String sql = "INSERT INTO member_out(id,reason) VALUES(?,?)";
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, id);
		pstmt.setString(2, reason);
		pstmt.executeUpdate();
		pstmt.close();	// 다음 pstmt 사용할 시에 leak 방지
		
		// foreign key를 참조하는 값이 있는 컬럼, 테이블 제거 시, 존재하지 않는 테이블을 참조하는 상황이 발생함에따라 foreign key check 비활성화.
		sql = "SET foreign_key_checks = 0";
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		stmt.close();
		
		String sql2 = "DELETE from member WHERE userno = ? and id = ?";
		pstmt = conn.prepareStatement(sql2);

		pstmt.setString(1, userno);
		pstmt.setString(2, id);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql2 = "DELETE from cart WHERE user_id = ?";
		pstmt = conn.prepareStatement(sql2);

		pstmt.setString(1, id);
		pstmt.executeUpdate();
		
		// 다시 활성화
		sql = "SET foreign_key_checks = 1";
		stmt = conn.createStatement();
		stmt.executeUpdate(sql);
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('삭제 성공했습니다.이용에 감사드립니다.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
			
		session.invalidate();

		
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
	} finally {
		if(pstmt != null) pstmt.close();
		if(stmt != null) stmt.close();
		if(conn != null) conn.close();
	}
	%>
</body>
</html>