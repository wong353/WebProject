<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file = "/include/dbconn.jsp" %>
<%@ include file = "/include/admin.jsp" %>
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
<%
	String sql2 = "select p_id from product";
	pstmt = conn.prepareStatement(sql2);
	rs = pstmt.executeQuery();
	while (rs.next()) {
		String p_id = rs.getString("p_id");
%>
	<script type="text/javascript">
	function prod_delete(){
		var con_del = confirm("정말 삭제하시겠습니까?");
		if(con_del==true)
			location.href="deleteProduct_process.jsp?p_id=<%=p_id%>";
	}
	</script>
<%} %>

<style type="text/css">
table{
	width: 70%;
}

.thumb{
	width: 100px;
	height: 100px;
}
</style>

</head>
<body>


<%@ include file="/include/header.jsp" %>
	
	<form action="">
		<table width="1000">
			<tr>
				<th>상품아이디</th>
				<th>상품명</th>
				<th>가격</th>
				<th>사이즈</th>
				<th>컬러</th>
				<th>상품 설명</th>
				<th>분류</th>						
				<th>재고수</th>						
				<th>상태</th>						
				<th>썸네일</th>						
				<th>디테일사진1</th>						
				<th>디테일사진2</th>						
				<th>디테일사진3</th>						
				<th>디테일사진4</th>						
			</tr>

			<%

			try {
				String sql = "select * from product order by p_id desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String p_id = rs.getString("p_id");
					String p_name = rs.getString("p_name");
					String p_unitPrice = rs.getString("p_unitPrice");
					String p_size = rs.getString("p_size");
					String p_color = rs.getString("p_color");
					String p_description = rs.getString("p_description");
					String p_category = rs.getString("p_category");
					String p_unitsInStock = rs.getString("p_unitsInStock");
					String p_condition = rs.getString("p_condition");
					String p_thumbnail = rs.getString("p_thumbnail");
					String p_fileName1 = rs.getString("p_fileName_detail1");
					String p_fileName2 = rs.getString("p_fileName_detail2");
					String p_fileName3 = rs.getString("p_fileName_detail3");
					String p_fileName4 = rs.getString("p_fileName_detail4");
			%>
			<tr>
				<td><%=p_id%></td>
				<td><%=p_name%></td>
				<td><%=p_unitPrice%></td>
				<td><%=p_size%></td>
				<td><%=p_color%></td>
				<td><%=p_description%></td>
				<td><%=p_category%></td>
				<td><%=p_unitsInStock%></td>
				<td><%=p_condition%></td>
				<td><img alt="이미지없음" src="<%=p_thumbnail%>" class="thumb"></td>
				<td><img alt="이미지없음" src="<%=p_fileName1%>" class="thumb"></td>
				<td><img alt="이미지없음" src="<%=p_fileName2%>" class="thumb"></td>
				<td><img alt="이미지없음" src="<%=p_fileName3%>" class="thumb"></td>
				<td><img alt="이미지없음" src="<%=p_fileName4%>" class="thumb"></td>
				<td><a href="modifyProduct.jsp?p_id=<%=p_id%>">수정</a> / 
				<input type="button" onclick="prod_delete()" value="삭제"> 
				<a href="deleteProduct_process.jsp?p_id=<%=p_id%>">삭제</a></td>
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