<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%@include file="/include/dbconn.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");

	try {

		String p_id = request.getParameter("p_id");
		String p_size = request.getParameter("p_size");
		String u_id = (String) session.getAttribute("id");

		String sql = "DELETE from cart WHERE product_id=? and product_size=? and user_id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		pstmt.setString(2, p_size);
		pstmt.setString(3, u_id);
		pstmt.executeUpdate();
		
		if (pstmt != null) {
			%>
						<script type="text/javascript">
							location.href = document.referrer;
							// document.referrer : 이전페이지를 저장하는 속성 값. 페이지 이동 후 새로고침되는 점이 history.back(-1)과는 다름
						</script>
			<%
		}
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
	} finally {
		if (pstmt != null) pstmt.close();
		if (rs != null) rs.close();
		if (conn != null) conn.close();
	}
	/* 	"SELECT id, p_name, p_unitPrice, product_id, amount, product_size, p_thumbnail, p_unitPrice*amount as price"+
		"FROM member m, product p, cart c"+
		"WHERE m.id=c.user_id and p.p_id=c.product_id and m.id=?"; */
	%>
</body>
</html>