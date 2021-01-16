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
#banner{
	width:100%;
	height: auto;
}
</style>
<body>
	<%@ include file="/include/dbconn.jsp"%>

	<%@include file="/include/header.jsp"%>

	<div id="shop_banner">
		<a href="lookbook.jsp"><img alt="banner" src="./image/banner.png" id="banner"></a>
	</div>
	<div id="shop_bannerwords">
		<a href="lookbook.jsp"> GARMENTDYING 2020 F/W DUCK AND COVER<br>
			<span>CHAPTER 01 OFFICIAL LOOK</span><br>CLICK TO FEATURE
		</a>
	</div>
	<!-- top_banner -->

	<div class="item-wrap" style="">
		<!-- 신상품 -->
		<div class="item-list">
			<table border="0">
				<tbody>
					<%
						try {
						String sql = "SELECT * FROM product";
						
						
						int i = 0;

						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							if(i%3==0) out.print("<tr>");
							String thum = rs.getString("p_thumbnail");
					%>
						<td>
							<ul class="item" style="font-size:10pt;">
								<div class="box unfocused">
									<li>
										<div class="thumb">
											<a href="shop_details_top.jsp"><img src="<%=thum%>" style="width:50%"></a>
										</div>
									</li> <a href="shop_details_top.jsp"><li class="prd-desc"><span class="MK-product-icons"></span></li>
										<li class="prd-name"><%=rs.getString("p_name")%></li>
										<li class="prd-price"><%=rs.getString("p_unitprice")%>원</li>
										<li class="prd-desc"><%=rs.getString("p_description")%></li> </a>
								</div>
							</ul>
						</td>
					<%
						i++;
						if(i%3==0) out.print("</tr>");
						}
					} catch (Exception e) {
					e.printStackTrace();
					out.println("오류" + e.getMessage());
					} finally {
					if (rs != null)
					rs.close();
					if (pstmt != null)
					pstmt.close();
					if (conn != null)
					conn.close();
					}
					%>
					
				</tbody>
			</table>
		</div>
	</div>

	<%@ include file="/include/footer.jsp"%>
</body>
</html>