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
<script lang="javascript" type ="text/javascript" src ="./js/check_modifyProduct.js"></script>

<style type="text/css">
table{

}
</style>

</head>
<body>

<%@ include file = "/include/dbconn.jsp" %>
<%@ include file = "/include/admin.jsp" %>

<%@include file="/include/header.jsp" %>

<%
			request.setCharacterEncoding("utf-8");
			
			String p_id = request.getParameter("p_id");
			
			
			try{
				
			String sql = "SELECT * FROM product WHERE p_id=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			rs = pstmt.executeQuery();
			while(rs.next()){
				String rp_id  = rs.getString("p_id");		
				String p_name  = rs.getString("p_name");		
				int p_unitPrice = rs.getInt("p_unitPrice");	
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

<form name="newProduct" action="modifyProduct_process.jsp" enctype ="multipart/form-data" method="post">
<input type="hidden" name="p_id" value="<%=rp_id%>">
	<table border="0">
		<caption><h3>상품 수정</h3></caption>
			
		<tr>	 
			<td>상품아이디</td>
			<td><input type="text" name="id" id="id" value="<%=rp_id%>"> </td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name" id="name" value="<%=p_name%>"> </td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="unitPrice" id="unitPrice" value="<%=p_unitPrice%>"> </td>
		</tr>
		<tr>
			<td>사이즈</td>
			<td>
				S<input type="checkbox" name="size" class="size" value="S" <% if(p_size.indexOf("S")>0 ) { %> checked <% }%>>
				M<input type="checkbox" name="size" class="size" value="M"<% if(p_size.indexOf("M")>0) { %> checked <% }%>>
				LAR<input type="checkbox" name="size" class="size"  value="LAR"<% if(p_size.indexOf("LAR")>0) { %> checked <% }%>>
				XL<input type="checkbox" name="size" class="size" value="XL"<% if(p_size.indexOf("XL")>0) { %> checked <% }%>>
				FREE<input type="checkbox" name="size" class="size" value="FREE"<% if(p_size.indexOf("FREE")>0) { %> checked <% }%>>
			</td>
		</tr>
		<tr>
			<td>컬러</td>
			<td><input type="text" name="color" id="color" value="<%=p_color%>"> </td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><textarea name="description" id="description" placeholder="설명란" value="<%=p_description%>"><%=p_description%></textarea> </td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
				Top<input type="radio" name="category" id="category" value="top" <% if(p_category.equals("top")) { %> checked <% } %>>
				Bottom<input type="radio" name="category" id="category" value="bottom" <% if(p_category.equals("bottom")) { %> checked <% } %>>
				ACC.<input type="radio" name="category" id="category" value="acc" <% if(p_category.equals("acc")) { %> checked <% } %>>
			 </td>
		</tr>
		<tr>
			<td>재고수</td>
			<td><input type="text" name="unitsInStock" id="unitsInStock" value="<%=p_unitsInStock%>"> </td>
		</tr>
		<tr>
			<td>상태</td>
			<td>
				NEW<input type="radio" name="condition" id="condition" value="new" <% if(p_condition.equals("new")){ %> checked <% } %>>
				OLD<input type="radio" name="condition" id="condition" value="old" <% if(p_condition.equals("old")){ %> checked <% } %>>
				RESERVED<input type="radio" name="condition" id="condition" value="reserved" <% if(p_condition.equals("reserved")){ %> checked <% } %>>			
			</td>
		</tr>
		<tr>
			<td>썸네일</td>
			<td><input type="file" name="thumbnail" id="thumbnail" value=""></td>
		</tr>
		<tr>
			<td>상품디테일1</td>
			<td><input type="file" name="image1"> </td>
		</tr>
		<tr>
			<td>상품디테일2</td>
			<td><input type="file" name="image2"> </td>
		</tr>
		<tr>
			<td>상품디테일3</td>
			<td><input type="file" name="image3"> </td>
		</tr>
		<tr>
			<td>상품디테일4</td>
			<td><input type="file" name="image4"> </td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" onclick="checkModifyProduct()" value="수정"><input type="button" onclick="cancel()" value="취소"></td>
		</tr>
	</table>
</form>
			<%
			}
			}	catch (Exception e){
					out.println("실패");
					out.println(e.getMessage());
				} finally{
					if(rs!=null) rs.close();
					if(pstmt!=null) pstmt.close();
					if(conn!=null) conn.close();
					
				}
			%>
	
<%@include file="/include/footer.jsp" %>
</body>
</html>