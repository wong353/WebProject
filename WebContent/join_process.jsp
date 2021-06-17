<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");

	String name = request.getParameter("name");
	String id = request.getParameter("id");
	String pwd1 = request.getParameter("pwd1");
	String nickname = request.getParameter("nickname");
	String email = request.getParameter("email");
	String birthday = request.getParameter("birthyear") + request.getParameter("birthmonth")+request.getParameter("birthdate");
	String zip = request.getParameter("zip");
	String addr = request.getParameter("addr");
	String addr_detail = request.getParameter("addr_detail");
	String addr_ref = request.getParameter("addr_ref");	
	String tel = request.getParameter("tel1") + request.getParameter("tel2") + request.getParameter("tel3");

	try {
		
		String sql = "INSERT INTO member(name, id, password, nickname, email, birthday, zip, addr, addr_detail, addr_ref, tel) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, name);
		pstmt.setString(2, id);
		pstmt.setString(3, pwd1);
		pstmt.setString(4, nickname);
		pstmt.setString(5, email);
		pstmt.setString(6, birthday);
		pstmt.setString(7, zip);
		pstmt.setString(8, addr);
		pstmt.setString(9, addr_detail);
		pstmt.setString(10, addr_ref);
		pstmt.setString(11, tel);

		pstmt.executeUpdate();
		out.println("<script>");
		out.println("alert('회원가입에 성공하셨습니다!')");
		out.println("location.href='login.jsp'");
		out.println("</script>");

	} catch (Exception e) {
		e.printStackTrace();
		out.println("실패");
		out.println("SQLException: " + e.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	%>
</body>
</html>