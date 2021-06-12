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

	String id = request.getParameter("id");


	try {
		
		String rid = "";
		String sql = "SELECT id FROM member WHERE id = ?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next())
			rid = rs.getString("id");
		if (id.equals(rid)) {
	%>
	입력하신 아이디는 <font color="red"><%=rid%></font> 이며, 사용할 수 없습니다.
	<br>
	<input type="button" value="확인" onclick="window.close()">
	<%
		} else {
	%>
	입력하신 아이디는 <font color="red"><%=id%></font>이며, 사용할 수있는 아이디입니다.
	<input type="button" value="사용" onclick="window.close()">
	<%
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