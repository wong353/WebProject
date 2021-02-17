<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<meta charset="UTF-8">
<title>입력</title>
</head>
<style type="text/css">
#cart-wrapper{
	width: 1200px;
	margin: 0 auto;
}
#cart_content{
	width: 1200px;
	margin: 0 auto;
	margin-bottom: 200px;
}
#cart_content th tr td{
	font-weight: 10pt;
}
#head_subject{
	float: left;
	padding-left: 40px;
	color: black;
	font-weight: bold;
	display: block;
    font-size: 1.17em;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
}

</style>


<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%@include file="/include/loginSessionPass.jsp" %>
	<%@include file="/include/header.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");
	
		int i = 0;
		
		String sql = "SELECT id, p_name, p_unitPrice, amount, p_unitPrice*amount as price FROM member m, product p, cart c WHERE m.id=c.userid and p.p_id=c.product_id";
		
		
	%>
		<form action="">
			<div id="cart-wrapper">
				<h3 id="head_subject">CART</h3>
				<div id="cart-table">
						<table id="cart_content">
						<th>NO.</th>
						<th>PRODUCT</th>
						<th>TITLE</th>
						<th>AMOUNT</th>
						<th>PRICE</th>
						<th>CANCEL</th>
						<%-- <%while(true){ %> --%>
						<tr>
							<%-- <% if(true){ %><td colspan="6" style="padding:30px 0;"> 장바구니가 비어 있습니다.</td><%}%> --%>
							
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<%-- <%} %> --%>
					</table>
				</div>
			</div>
		</form>
		
	<%@include file="/include/footer.jsp"%>
</body>
</html>