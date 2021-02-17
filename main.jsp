<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>

<link rel="stylesheet" type="text/css" href="./stylesheet/imageSlide.css">
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

p {
	align-text: center;
}

#main_1200 {
	clear: both;
	width: 1200px;
	margin: 0 auto;
	padding-top: 4px;
}

.main_bn {
	width: 1200px;
	margin: 5px 0;
	overflow: hidden;
	padding: 0px;
}

.main_bn ul {
	margin: 0;
	padding: 0;
}

.main_bn li img {
	width: 394px;
	height: 248px;
	display: block;
	margin: 0 0 0 5px;
	float: left;
}

/* 아이템 목록 */
.item-wrap .item-list {
	margin: 0px 0 0px -53px;
	width: 1253px;
}

.item-wrap .item-list ul li .thumb img {
	max-width: 260px;
	min-height: 260px;
	max-height: 320px;
	text-align: center;
	margin-bottom: 0px;
	vertical-align: top;
}
</style>

</head>

<body>
	<%@ include file="include/dbconn.jsp"%>
	<%@include file="include/header.jsp"%>

	<div class="slideshow-container">
		<div class="mySlides fade">
			<a href=""><img src="./image/main/main1.jpg"></a>
		</div>
		<div class="mySlides fade">
			<a href=""><img src="./image/main/main2.jpg"></a>
		</div>
		<div class="mySlides fade">
			<a href=""><img src="./image/main/main3.jpg"></a>
		</div>
		<a class="prev" onclick="plusSlides(-1)">&#10094;</a>
		<a class="next" onclick="plusSlides(1)">&#10095;</a>
	</div>
	<br>
	<div style="text-align: center">
		<span class="dot" onclick="currentSlide(1)"></span>
		<span class="dot" onclick="currentSlide(2)"></span>
		<span class="dot" onclick="currentSlide(3)"></span>
	</div>

	<script type="text/javascript" src="./js/imageSlide.js"></script>
	<!-- 이미지 슬라이드 스크립트 -->

	<div id="main">
		<div id="main_1200">
			<ul class="main_bn">
				<li><a href="shop_outer.jsp"><img alt="" src="./image/main_bn/outer.jpg"></a></li>
				<li><a href="shop_top.jsp"><img alt="" src="./image/main_bn/2.jpg"></a></li>
				<li><a href=""><img alt="" src="./image/main_bn/bottom.jpg"></a></li>
			</ul>
			<div class="item-wrap">
				<div class="item-list">
					<table>
						<!-- 상품 정보 가져오는 로직 -->
						<%
							request.setCharacterEncoding("utf-8");

						try {
							String sql = "SELECT * FROM product";

							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();

							int i = 0;

							while (rs.next()) {
								if (i % 4 == 0) out.print("<tr>");
								String thumb = rs.getString("p_thumbnail");
								String price = rs.getString("p_unitPrice");
								String name = rs.getString("p_name");
								String desciption = rs.getString("p_description");
						%>
						<td>
							<ul class="item" style="font-size: 10pt;">
								<div class="box unfocused">
									<li>
										<div class="thumb">
											<a href=""><img src="<%=thumb%>"></a>
										</div>
									</li> 
									<a href=""><li class="prd-desc"><span class="MK-product-icons"></span></li>
										<li class="prd-brand"><%=name%></li>
										<li class="prd-name"><%=desciption%></li>
										<li class="prd-price"><%=price%>원</li> </a>
								</div>
							</ul>
						</td>

						<%
							i++;
							if (i % 4 == 0)	out.print("</tr>");
							}
	
							} catch (Exception e) {
								out.println(e.getMessage());
							} finally {
								if(rs!=null)rs.close();
								if(pstmt!=null)pstmt.close();
								if(conn!=null)conn.close();
							}
						%>
					</table>
				</div>
			</div>
		</div>
		<!-- main_1200 -->
	</div>
	<!-- main_contents -->
	<%@include file="include/footer.jsp"%>
</body>
</html>