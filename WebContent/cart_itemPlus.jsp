<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
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
		String userId = (String)session.getAttribute("id");
		String p_id = request.getParameter("p_id");
		String p_size = request.getParameter("p_size");
		int amount = Integer.parseInt(request.getParameter("amount"));
		int p_unitsInStock = Integer.parseInt(request.getParameter("p_unitsInStock"));
		
		if(amount >= p_unitsInStock){
	%>
		<script type="text/javascript">
			alert('상품의 최대 수량입니다!');
			location.href = document.referrer;
		</script>
	<%
		} else {
			String sql = "ALTER TABLE cart AUTO_INCREMENT=1";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "SET @COUNT = 0";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "UPDATE cart SET cart_id = @COUNT:=@COUNT+1";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			pstmt.close();
			
			sql = "UPDATE cart SET amount = amount + 1 WHERE user_id = ? and product_id = ? and product_size = ? "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, p_id);
			pstmt.setString(3, p_size);
			pstmt.executeUpdate();
			}
			// response.sendRedirect(header);
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



