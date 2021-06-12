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
		
		String sql2 = "DELETE from member WHERE userno=?";
		pstmt = conn.prepareStatement(sql2);

		pstmt.setString(1, userno);
		pstmt.executeUpdate();
		
		// 정렬 쿼리		
		String arrange = "ALTER TABLE member AUTO_INCREMENT=1";
		pstmt.executeUpdate(arrange);

		String arrange2 = "SET @COUNT = 0;"; // count라는 변수를 선언 및 초기화(프로시저가 끝나도 계속 유지되는 값)
		pstmt.executeUpdate(arrange2);
		
		String arrange3 = "UPDATE member SET num = @COUNT:=@COUNT+1"; // := 는 왼쪽 피연산자에 오른쪽 피연산자를 대입함.
		pstmt.executeUpdate(arrange3);
		
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
		if(conn != null) conn.close();
	}
	%>
</body>
</html>