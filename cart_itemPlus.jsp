<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="./include/dbconn.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");

	try {

		String header = request.getHeader("referer");

		String sql = "ALTER TABLE cart AUTO_INCREMENT=1";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		if (pstmt != null) pstmt.close();
		
		sql = "SET @COUNT = 0";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		if (pstmt != null) pstmt.close();
		
		sql = "UPDATE cart SET cart_id = @COUNT:=@COUNT+1";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		
		/*sql = "UPDATE cart SET amount = amount + 1 WHERE "; */

		response.sendRedirect(header);
	%>
	<script type="text/javascript">
		location.href = document.referrer;
	</script>
	<%
		} catch (Exception e) {
	e.printStackTrace();
	out.println(e.getMessage());
	} finally {
	if (rs != null) rs.close();
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
	}
	%>
</body>
</html>



