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
<title>GARMENTDYING OFFICIAL SITE</title>
</head>

<style type="text/css">
#banner{
	width: 1900px;
	bottom: 0;
	left: 0;
	margin: auto;
	overflow: auto;
	right: 0;
	stop: 0;
}

#shop_banner, #shop_bannerwords{
	text-align: center;
}

.item .prd-brand, .item .prd-name, .item .prd-price, .item .prd-desc {
	text-align: center;
}
	
</style>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%@include file="/include/header.jsp"%>
<%-- 	<%
		String preUrl = request.getRequestURL().toString();
		if(request.getQueryString() != null)
			preUrl = preUrl + "?" + request.getQueryString();
	%>
	<input type ="hidden" name="preUrl" value=<%=preUrl%>>
 --%>	
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
			<table>
				<tbody>
					<%
						try{
						String sql = "SELECT p_id,p_thumbnail,p_name,p_unitPrice,p_description FROM product";
						
						int i = 0;

						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
							if(i%3==0) out.print("<tr>");
							String p_id = rs.getString("p_id");
							String thumb = rs.getString("p_thumbnail");
							String name = rs.getString("p_name");
							String unitPrice = rs.getString("p_unitPrice");
							String description = rs.getString("p_description");
					%>
						<td>
							<ul class="item" style="font-size:10pt;">
								<div class="box unfocused">
									<li>
										<div class="thumb">
											<a href="shop_details_top.jsp?p_id=<%=p_id%>"><img src="<%=thumb%>"></a>
										</div>
									</li> <a href="shop_details_top.jsp"><li class="prd-desc"><span class="MK-product-icons"></span></li>
										<li class="prd-name"><%=name%></li>
										<li class="prd-price"><%=unitPrice%>원</li>
										<li class="prd-desc"><%=description%></li> </a>
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