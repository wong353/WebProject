<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css"
	href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<meta charset="UTF-8">
<title>입력</title>
</head>
<style type="text/css">
table {
	width: 70%;
	margin: 0 auto;
	margin-top: 200px;
	margin-bottom: 200px;
}
</style>


<body>
	<%@ include file="/include/dbconn.jsp"%>
	
	<%@include file="/include/loginSessionPass.jsp" %>

	<%@include file="/include/header.jsp"%>


	<form action="">
		<div id="cart-wrapper">
			<div id="cart-table">
				<table border="1">
					<th>NO.</th>
					<th>PRODUCT</th>
					<th>TITLE</th>
					<th>QUANTITY</th>
					<th>MILEAGE</th>
					<th>PRICE</th>
					<th>DELIVERY</th>
					<th>CANCEL</th>
					<tr>
						<td colspan="8" style="padding: 30px 0;">장바구니가 비어 있습니다.
					</tr>
				</table>
			</div>
		</div>
	</form>


	<%@include file="/include/footer.jsp"%>
</body>
</html>