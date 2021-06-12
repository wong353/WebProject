<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css"/>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css"/>
<link rel="stylesheet" type="text/css" href="stylesheet/all.css"/>
<link rel="stylesheet" type="text/css" href="stylesheet/header.css"/>
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css"/>
<link rel="stylesheet" type="text/css" href="stylesheet/cart.css?after"/>
<link href="https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css" rel="stylesheet"/>
<meta charset="UTF-8">
<title>Garment Dying</title>
<script src="./js/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%@include file="/include/loginSessionPass.jsp"%>
	<%@include file="/include/header.jsp"%>
	<%
		request.setCharacterEncoding("utf-8");
		int totalPrice = 0;
		int sumPrice = 0;
		
		try{
		int i = 0;
		int amount = 0; 
		/* String amountStr = request.getParameter("amount");
		if(amountStr != null){
			amount = Integer.parseInt(amountStr);
		} */
		
		String cartId = (String)session.getAttribute("id");
	
		String sql = "SELECT id, p_name, p_unitPrice, product_id, amount, product_size, p_thumbnail,amount, p_unitsInStock, p_unitPrice*amount as price FROM member m, product p, cart c WHERE m.id=c.user_id and p.p_id=c.product_id and m.id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, cartId);
		rs = pstmt.executeQuery();

	%>
	<form action="">
		<div id="cart-wrapper">
			<h3 id="head_subject">CART</h3>
			<div id="cart-table">
				<ul class="cart-container">
					<% 
						if(rs==null || rs.isBeforeFirst() == false){	// 쿼리의 결과의 커서가 첫 row 바로 앞이면 true, 바로 앞이 아니거나 결과 row가 없으면 false. 해당 rs 메소드만 동시 실행 가능.
					%>
						<div>장바구니가 비었습니다.</div>
					<%
						} else{
							while(rs.next()){
								out.print("<li class='cart-goods'>");		
								String p_name = rs.getString("p_name");
								String p_unitPrice = rs.getString("p_unitPrice");
								String p_id = rs.getString("product_id");
								String p_size = rs.getString("product_size");
								String p_thumbnail = rs.getString("p_thumbnail");
								String p_unitsInStock = rs.getString("p_unitsInStock");
								
								//request.setAttribute("p_stock", p_unitsInStock);	 object 형으로 속성 이름과 값으로 넘기기 
								//Object p_stock = request.getAttribute("p_stock").toString();
								
								amount = rs.getInt("amount");
								int unitPrice = Integer.parseInt(p_unitPrice); 
								String unitPriceComma = NumberFormat.getInstance().format(unitPrice); // 천단위 콤마
					%>
						<div class="goods-thumb">
							<img src="<%=p_thumbnail%>" alt="Retro Resin Col V2">
						</div>
						<div class="cart-info-box">
							<div class="item-info">
								<dl>
									<dt class="info-name"><%=p_name%> (<%=p_size%>)</dt>
									<dd class="info-price"><%=unitPriceComma%> won</dd>
								</dl>
								<button class="item-remove" type="button" onclick="location.href='cartDel.jsp?p_id=<%=p_id%>&p_size=<%=p_size%>'">Remove</button>
							</div>
							<div class="item-control">
								<div class="item-count">
									<button class="count-minus" type="button" onclick="location.href='cart_itemMinus.jsp?amount=<%=amount%>&p_id=<%=p_id%>&p_size=<%=p_size%>'">
										<i class="bx bx-minus"></i>
									</button>
									<span class="count"><%=amount%></span>
									<button class="count-plus" type="button" onclick="location.href='cart_itemPlus.jsp?amount=<%=amount%>&p_id=<%=p_id%>&p_size=<%=p_size%>&p_unitsInStock=<%=p_unitsInStock%>'">
										<i class="bx bx-plus"></i>
									</button>
								</div>
					<%
						sumPrice = unitPrice*amount;
						String sumPriceComma = NumberFormat.getInstance().format(sumPrice); 			
					%>
								<strong class="single-total-price"><%=sumPriceComma%> </strong>
							</div>
						</div>
					<%	
						totalPrice += sumPrice;
						out.print("</li>");
							}
						}
					%>
				</ul>
				<div class="cart-total">
					<dl class="total">
					<%
						if(totalPrice != 0){
							String totalPriceComma = NumberFormat.getInstance().format(totalPrice);
					%>
						<dt class="total-title">Total</dt>
						<dd class="total-price"><%=totalPriceComma%> &#8361;</dd>
					<%	}%>
					</dl>
				</div>
			</div>
		</div>
	</form>
	<%
	} catch(Exception e){
					e.printStackTrace();
					out.println(e.getMessage());
				} finally{
					if (rs != null)	rs.close();
					if (pstmt != null) pstmt.close();
					if (conn != null) conn.close();
				}
	%>
	<%@include file="/include/footer.jsp"%>
</body>
</html>