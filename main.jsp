<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>

<style type="text/css">

table {
	width: 100%;
	margin: 0 auto;
	margin-left: 0 !important;
	border-collapse: collapse;
	border-spacing: 0;
	table-layout: fixed;
	word-wrap: break-word;
	word-break: keep-all;
}

ul li{
	list-style-type: none;
}

p{
	align-text: center;
}

.main_bn li img {
    width: 394px;
    height: 248px;
    display: block;
    margin: 0px auto;
    padding-left: 10px;
    float: left;
    
}

/* #logo{
	width:auto;
	height:auto;
	max-width:5px;
	max-height:5px;
} */
</style>

</head>
<body>
<%@ include file = "include/dbconn.jsp" %>

	<%@include file="include/header.jsp" %>
		<div id="main_contents">
			<div id="mains">
				<!-- <div class="part" rel="0" style="-286px; opacity:0; z-index: 1;"> -->
				<a href=""><img src="http://cdn015.negagea.net/wherehouse/2020/webstore/main/200918_main_01.jpg"></a>
				<!-- </div> -->
				<!-- <div class="part" rel="1" style="-286px; opacity:0; z-index: 1;">
				<a href=""><img src="C:\Users\user\Desktop\project\image\main_wide\1.jpg"></a>
				</div>
				<div class="part" rel="2" style="-286px; opacity:0; z-index: 1;">
				<a href=""><img src="C:\Users\user\Desktop\project\image\main_wide\1.jpg"></a>
				</div> -->
			</div>
			<div id="main">
				<div id="main_1200">
					<!-- 카테고리 배너박스 -->
					<!-- <ul class=main_bn>
						<li><a href=""><img src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title002.jpg"></a></li>
						<li><a href=""><img src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title002.jpg"></a></li>
						<li><a href=""><img src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title002.jpg"></a></li>
					</ul> -->
					<!-- 카테고리 배너박스 -->
					<div class="item-wrap" style="">
						<!-- 신상품 -->
						<div class="item-list">
							<table>
								<colgroup>
									<col width="25%">
									<col width="25%">
									<col width="25%">
									<col width="25%">
								</colgroup>
								<tbody>
									<tr>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href=""><li class="prd-desc"><span
															class="MK-product-icons"></span></li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li> </a>
												</div>
												<a href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href=""><li class="prd-desc"><span
															class="MK-product-icons"></span></li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li> </a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
														<li class="prd-discount">169,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
									</tr>
									<tr>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
										<td>
											<ul class="item">
												<div class="box unfocused">
													<li>
														<div class="thumb">
															<a href=""><img
																src="http://cdn015.negagea.net/wherehouse/2020/webstore/mid/mid_title001.jpg"></a>
														</div>
													</li> <a href="">
														<li class="prd-desc"><span class="MK-product-icons"></span>
													</li>
														<li class="prd-brand">가먼트다잉</li>
														<li class="prd-name">셔츠</li>
														<li class="prd-price">150,000원</li>
														<li class="prd-discount">169,000원</li>
													</a>
												</div>
												<a
													href="/shop/shopdetail.html?branduid=1000002746&amp;xcode=061&amp;mcode=009&amp;scode=&amp;special=1&amp;GfDT=bmp%2FW1w%3D">
													<!-- .box unfocused -->
												</a>
											</ul>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- main_1200 -->
			</div>
			<!-- main -->
		</div>
		<!-- main_contents -->
	<%@include file="include/footer.jsp" %>
</body>
</html>