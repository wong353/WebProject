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
<script src="./include/jquery-3.5.1.js"></script>
<script lang="javascript" type ="text/javascript" src ="./js/check_addProduct.js"></script>
<script type="text/javascript">
	$(function() {
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
<style type="text/css">
</style>

</head>
<body>

<%@ include file = "/include/dbconn.jsp" %>

<%@include file="/include/admin.jsp" %>

<%@include file="/include/header.jsp" %>


<form name="newProduct" action="addProduct_process.jsp" enctype ="multipart/form-data" method="post">
	<table border="0">
		<caption><h3>상품 등록</h3></caption>
		<tr>	
			<td>상품아이디</td>
			<td><input type="text" name="id" id="id" ><!-- onkeyup="duplicationCheck() --></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name" id="name"> </td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="unitPrice" id="unitPrice"> </td>
		</tr>
		<tr>
			<td>사이즈</td>
			<td>
				S<input type="checkbox" name="size" class="size" value="S">
				M<input type="checkbox" name="size" class="size" value="M">
				L<input type="checkbox" name="size" class="size" value="LAR">
				FREE<input type="checkbox" name="size" class="size" value="FREE">
			</td>
		</tr>
		<tr>
			<td>컬러</td>
			<td><input type="text" name="color" id="color"> </td>
		</tr>
		<tr>
			<td>상품 설명</td>
			<td><textarea name="description" id="description" placeholder="설명란"></textarea> </td>
		</tr>
		<tr>
			<td>분류</td>
			<td>
				<select id="category" name="category" onchange="cateChange()">
					<option value="">선택</option>
					<option value="top">top</option>
					<option value="bottom">bottom</option>
					<option value="outer">outer</option>
				</select>
				<select id="category2" name="category2">
					<option value="">선택</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>재고수</td>
			<td><input type="text" name="unitsInStock" id="unitsInStock"> </td>
		</tr>
		<tr>
			<td>상태</td>
			<td>
				NEW<input type="radio" name="condition" id="condition" value="new">
				OLD<input type="radio" name="condition" id="condition" value="old">
				EVENT<input type="radio" name="condition" id="condition" value="event">			
			</td>
		</tr>
		<tr>
			<td>썸네일</td>
			<td><input type="file" name="thumbnail" id="thumbnail"> </td>
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
			<td colspan="2"><input type="button" onclick="checkAddProduct()" value="입력"><input type="button" onclick="cancel()" value="취소"></td>
		</tr>
	</table>
</form>
	
<%@include file="/include/footer.jsp" %>
</body>
</html>