<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>입력</title>
</head>

<style type="text/css">
#banner{
	width:100%;
	height: auto;
}
</style>

<body>
	<%@ include file = "/include/dbconn.jsp" %>

	<%@include file="/include/header.jsp" %>
		
		<div id="shop_banner">
		<a href="lookbook.jsp"><img alt="banner" src="./image/banner.png" id="banner"></a>
		</div>
		<div id="shop_bannerwords">
		<a href="lookbook.jsp"> GARMENTDYING 2020 F/W DUCK AND COVER<br><span>CHAPTER 01 OFFICIAL LOOK</span><br>CLICK TO FEATURE</a>
		</div>
		<div>
			<h2>SHOP</h2>
		</div>
		<div id="cate-wrap">
			<dl class="cate-list">
				<dd>
					<ul class="menu_cate">
						<li><a href="shop_top.jsp">TOP</a></li>
						<li><a href="shop_bottom.jsp">BOTTOM</a></li>
						<li><a href="shop_acc.jsp">ACC</a>.</li>
					</ul>
				</dd>
			</dl>
		</div>
		<div class="item-wrap" style="">
						<!-- 신상품 -->
						<div class="item-list">
							<table border="0">
								<colgroup>
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
									<col width="20%">
								</colgroup>
								<tbody>
									<tr>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href=""><li class="prd-desc"><span	class="MK-product-icons"></span></li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li> </a>
												</div>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img	src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img	src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href=""><li class="prd-desc"><span class="MK-product-icons"></span></li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li> </a>
												</div>
											</ul>
										</td>
									</tr>
									<tr>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img src="http://espionage.co.kr/shopimages/zooyork77/0610010004342.jpg?1598420115"></a>
														</div>
													</li> <a href=""><li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">마원</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
											</ul>
										</td>
									</tr>									
								</tbody>
							</table>
						</div>
					</div>
					
		<%@ include file = "/include/footer.jsp" %>
</body>
</html>