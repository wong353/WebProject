<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@include file="include/dbconn.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");

	try {
		String preUrl = request.getHeader("referer");
		
		if(session.getAttribute("id") == null){
			%>
			<script type="text/javascript">
				alert('로그인이 필요한 작업입니다. 로그인 페이지로 이동합니다.');
				location.href='login.jsp?preUrl=<%=preUrl%>';
			</script>
			<%
		}else{
			String userid = (String) session.getAttribute("id");
			String p_id = request.getParameter("p_id");
			String p_size = request.getParameter("p_size");
			
			String sql = "SELECT user_id, product_id, product_size FROM cart WHERE user_id = ? and product_id = ? and product_size = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, p_id);
			pstmt.setString(3, p_size);
			rs = pstmt.executeQuery();
			if (rs.next()) {
		%>
				<script type="text/javascript">
					alert('이미 추가한 상품입니다!');
					history.back();
				</script>
		<%
			} else {
				pstmt.close();
	
				sql = "INSERT INTO cart(user_id, product_id, product_size, amount) VALUES(?,?,?,1)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, p_id);
				pstmt.setString(3, p_size);
				pstmt.executeUpdate();
				if (pstmt != null) {
		%>
					<script type="text/javascript">
						location.href = document.referrer;
						alert('장바구니에 추가 완료했습니다!');
					</script>
		<%
				}
			}
		}
	}catch (Exception e) {
	e.printStackTrace();
	out.println(e.getMessage());

	} finally {
	if (pstmt != null)
	pstmt.close();
	if (rs != null)
	rs.close();
	if (conn != null)
	conn.close();
	}
	%>
</body>
</html>