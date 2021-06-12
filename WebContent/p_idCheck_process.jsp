<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디중복체크</title>
<script type="text/javascript">
	<%-- function useid(){
		opener.member.id.value="<%=id%>";		
	} --%>
</script>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	PrintWriter script = response.getWriter();

	String id = request.getParameter("id");


	try {
		String rid = "";
		String sql = "SELECT p_id FROM product WHERE p_id = ?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next())
			rid = rs.getString("p_id");
		if (id.equals(rid)) {
			script.println("<script>");
			script.println("alert('입력하신 아이디는 이미 존재합니다.')");
			script.println("newProduct.id.select()");
			script.println("newProduct.id.focus()");
			script.println("</script>");
		} else {
			script.println("<script>");
			script.println("alert('입력하신 아이디는 사용 가능합니다.')");
			script.println("newProduct.name.focus()");
			script.println("</script>");
		}
	} catch (SQLException e) {
	out.println("실패");
	out.println("SQLException: " + e.getMessage());
	} finally {
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	}
	%>

</body>
</html>