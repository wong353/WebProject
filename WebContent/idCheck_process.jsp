<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="/include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GarmentDying</title>
<link rel="stylesheet" type="text/css" href="stylesheet/idCheck.css">
<script type="text/javascript">
function setPartentText(){
	opener.document.getElementById("notThisId").value = "idCheck";
	window.close();
}
</script>
</head>
<body>
	<%
	try {
		request.setCharacterEncoding("utf-8");
		
		int idx = 1;
		String id = request.getParameter("id");
		String rid = "";
		
		String sql = "SELECT id FROM member WHERE id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next())
			rid = rs.getString("id");

			if (id.equals(rid)) {
	%>
				<div id="sentence">
					입력하신 아이디는 <font id="font"><%=id%></font> 이며, 사용하실 수 없습니다.
				</div>
				<br>
				<input type="button" value="확인" onclick="window.close()" id="btn">
				<input type="hidden" value=<%=id%> id="id">
	<%
			} else {
	%>
				<div id="sentence">
					입력하신 아이디는 <font id="font"><%=id%></font>이며, 사용하실 수 있는 아이디입니다.
				</div>
				<input type="button" value="사용" onclick="setPartentText()" id="btn">
				<input type="hidden" value="<%=id%>" id="id">
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