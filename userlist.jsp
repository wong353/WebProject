<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<style type="text/css">

</style>

</head>
<body>
<%@ include file = "/include/dbconn.jsp" %>
<%@ include file = "/include/admin.jsp" %>

<%@include file="/include/header.jsp" %>
	
	<form action="">
		<table width="1000">
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>생일</th>
				<th>우편번호</th>						
				<th>주소</th>						
				<th>상세주소</th>						
				<th>참조주소</th>						
				<th>전화번호</th>						
			</tr>

			<%

			try {
				String sql = "select * from member order by userno desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int ruserno = rs.getInt("userno");
					String name = rs.getString("name");
					String rid = rs.getString("id");
					String nickname = rs.getString("nickname");
					String email = rs.getString("email");
					String birthday = rs.getString("birthday");
					String zip = rs.getString("zip");
					String addr = rs.getString("addr");
					String addr_detail = rs.getString("addr_detail");
					String addr_ref = rs.getString("addr_ref");
					String tel = rs.getString("tel");
			%>
			<tr>
				<td><%=ruserno%></td>
				<td><%=name%></td>
				<td><%=rid%></td>
				<td><%=nickname%></td>
				<td><%=email%></td>
				<td><%=birthday%></td>
				<td><%=zip%></td>
				<td><%=addr%></td>
				<td><%=addr_detail%></td>
				<td><%=tel%></td>
				<td><a href="mypage.jsp?userno=<%=ruserno%>">수정</a> / 
				<a href="delete.jsp?userno=<%=ruserno%>&id=<%=id%>">삭제</a></td>
			</tr>
			<%
				}
			} catch (Exception e) {
				out.println("실패");
				out.println(e.getMessage());
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			%>
			<tr>
			<td><input type="button" value="돌아가기" onclick="history.back()"></td>		
			</tr>
		</table>
	</form>
	
	
<%@include file="/include/footer.jsp" %>
</body>
</html>