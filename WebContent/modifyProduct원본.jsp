<%@ page import="java.sql.*"%>
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
<script lang="javascript" type="text/javascript" src="./js/check_modifyProduct.js"></script>
<script src="./include/jquery-3.5.1.js"></script>
<style type="text/css">
table {
	
}
</style>
</head>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%@ include file="/include/admin.jsp"%>
	<%@include file="/include/header.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");

		String p_id = request.getParameter("p_id");

		try {
			String sql = "SELECT * FROM product WHERE p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String rp_id = rs.getString("p_id");
				String p_name = rs.getString("p_name");
				int p_unitPrice = rs.getInt("p_unitPrice");
				String p_size = rs.getString("p_size");
				String p_color = rs.getString("p_color");
				String p_description = rs.getString("p_description");
				String p_categorySub = rs.getString("p_category");
				String p_categoryTop = "";
				if (p_categorySub.equals("mtm") || p_categorySub.equals("shirts") || p_categorySub.equals("t-shirts")  || p_categorySub.equals("hood")) {
					p_categoryTop = "top";
				} else if (p_categorySub.equals("pants")  || p_categorySub.equals("shorts")) {
					p_categoryTop = "bottom";
				} else if (p_categorySub.equals("coat")  || p_categorySub.equals("jacket"))  {
					p_categoryTop = "outer";
				}
				String p_unitsInStock = rs.getString("p_unitsInStock");
				String p_condition = rs.getString("p_condition");
				String p_thumbnail = rs.getString("p_thumbnail");
				String p_fileName1 = rs.getString("p_fileName_detail1");
				String p_fileName2 = rs.getString("p_fileName_detail2");
				String p_fileName3 = rs.getString("p_fileName_detail3");
				String p_fileName4 = rs.getString("p_fileName_detail4");
	%>
<script type="text/javascript">
	$(window).on('load',function(){
	    const temp = $("select[name=category2]");
		const a = $(category).val();
		let b = "<%=p_categorySub%>";
		temp.children().remove();
		temp.append('<option value="">선택 </option>');
			
		if (a == 'top') {
			temp.append("<option value='mtm'>mtm</option>");
			temp.append("<option value='shirts'>shirts</option>");
			temp.append("<option value='t-shirts'>t-shirts</option>");
			temp.append("<option value='hood'>hood</option>");
		}
		if (a == 'bottom') {
			temp.append("<option value='pants'>pants</option>");
			temp.append("<option value='shorts'>shorts</option>");
		}
		if (a == 'outer') {
			temp.append("<option value='coat'>coat</option>");
			temp.append("<option value='jacket'>jacket</option>");
		}
		$("#category2").val(b).prop("selected", true);
	});
</script>
<script type="text/javascript">
	$(function cateChange() {
		$("select[name=category]").change(function() {
			const temp = $("select[name=category2]");
			const a = $(this).val();
			temp.children().remove();
			temp.append('<option value="">선택</option>');
	
			if (a == 'top') {
				temp.append('<option value="mtm">mtm</option>');
				temp.append('<option value="shirts">shirts</option>');
				temp.append('<option value="t-shirts">t-shirts</option>');
				temp.append('<option value="hood">hood</option>');
			}
			if (a == 'bottom') {
				temp.append('<option value="pants">pants</option>');
				temp.append('<option value="shorts">shorts</option>');
			}
			if (a == 'outer') {
				temp.append('<option value="coat">coat</option>');
				temp.append('<option value="jacket">jacket</option>');
			}
		});
	});
</script>

	<form name="modifyProduct" action="modifyProduct_process.jsp"
		enctype="multipart/form-data" method="post">
		<table border="0">
			<caption>
				<h3>상품 수정</h3>
			</caption>
			<tr>
				<td>상품아이디</td>
				<td><input type="text" name="id" id="id" value="<%=rp_id%>">
				</td>
			</tr>
			<tr>
				<td>상품명</td>
				<td><input type="text" name="name" id="name" value="<%=p_name%>"></td>
			</tr>
			<tr>
				<td>가격</td>
				<td><input type="text" name="unitPrice" id="unitPrice" value="<%=p_unitPrice%>"></td>
			</tr>
			<tr>
				<td>사이즈</td>
				<td>S<input type="checkbox" name="size" class="size" value="S"
					<%if (p_size.indexOf("S") > 0) {%> checked <%}%>>
					M<input	type="checkbox" name="size" class="size" value="M"
					<%if (p_size.indexOf("M") > 0) {%> checked <%}%>>
					L<input	type="checkbox" name="size" class="size" value="L"
					<%if (p_size.indexOf("L") > 0) {%> checked <%}%>>
					FREE<input type="checkbox" name="size" class="size" value="FREE"
					<%if (p_size.indexOf("FREE") > 0) {%> checked <%}%>>
				</td>
			</tr>
			<tr>
				<td>컬러</td>
				<td><input type="text" name="color" id="color"
					value="<%=p_color%>"></td>
			</tr>
			<tr>
				<td>상품 설명</td>
				<td><textarea name="description" id="description"
						placeholder="설명란" value="<%=p_description%>"><%=p_description%></textarea>
				</td>
			</tr>
			<tr>
				<td>분류</td>
				<td>
					<select id="category" name="category" onchange="cateChange()">
 						<option value="">선택</option>
						<option value="top" <%if(p_categoryTop.equals("top")){%> selected <%}%>>top</option>
						<option value="bottom" <%if(p_categoryTop.equals("bottom")){%> selected <%}%>>bottom</option>
						<option value="outer" <%if(p_categoryTop.equals("outer")){%> selected <%}%>>outer</option>
					</select>
					<select id="category2" name="category2">
						<option value="">선택</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>재고수</td>
				<td><input type="text" name="unitsInStock" id="unitsInStock"
					value="<%=p_unitsInStock%>"></td>
			</tr>
			<tr>
				<td>상태</td>
				<td>New<input type="radio" name="condition" id="condition"
					value="new" <%if (p_condition.equals("new")) {%> checked <%}%>>
					Old<input type="radio" name="condition" id="condition" value="old"
					<%if (p_condition.equals("old")) {%> checked <%}%>>
					Delayed<input type="radio" name="condition" id="condition"
					value="delayed" <%if (p_condition.equals("delayed")) {%> checked
					<%}%>>
				</td>
			</tr>
			<tr>
				<td>썸네일</td>
				<td><input type="file" name="thumbnail" id="thumbnail" value=""></td>
			</tr>
			<tr>
				<td>상품디테일1</td>
				<td><input type="file" name="image1"></td>
			</tr>
			<tr>
				<td>상품디테일2</td>
				<td><input type="file" name="image2"></td>
			</tr>
			<tr>
				<td>상품디테일3</td>
				<td><input type="file" name="image3"></td>
			</tr>
			<tr>
				<td>상품디테일4</td>
				<td><input type="file" name="image4"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" onclick="checkModifyProduct()" value="수정">
					<input type="button" onclick="cancel()" value="취소">
				</td>
			</tr>
		</table>
	</form>
	<%
		}
	} catch (Exception e) {
	out.println("실패");
	out.println(e.getMessage());
	} finally {
	if (rs != null)
	rs.close();
	if (pstmt != null)
	pstmt.close();
	if (conn != null)
	conn.close();
	}
	%>
	
	<%@include file="/include/footer.jsp"%>
</body>
</html>