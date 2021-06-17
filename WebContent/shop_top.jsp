<%@page import="java.text.NumberFormat"%>
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
<link rel="stylesheet" type="text/css" href="stylesheet/shop.css?after">
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
</head>

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
		<a href=#><img alt="banner" src="./image/main_bn/shop_banner.jpg" id="banner"></a>
	</div>
	<div id="shop_bannerwords">
		<a href=#> GARMENTDYING 2021 S/S RATS IN THE DESERT<br>
			<span>CHAPTER 01 OFFICIAL LOOK</span><br>CLICK TO FEATURE <!-- 미구현  -->
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
						String sql = "SELECT * FROM product WHERE "+
								"p_category = ? || p_category = ? || p_category = ? || p_category = ?";
						
						int i = 0;
						pstmt = conn.prepareStatement(sql);
						pstmt.setString(1, "mtm");
						pstmt.setString(2, "shirts");
						pstmt.setString(3, "t-shirts");
						pstmt.setString(4, "hood");
						rs = pstmt.executeQuery();
						while (rs.next()) {
							if(i%4==0) out.print("<tr>");
							String p_id = rs.getString("p_id");
							String thumb = rs.getString("p_thumbnail");
							String name = rs.getString("p_name");
							String unitPrice = rs.getString("p_unitPrice");
							int unitPriceInt = Integer.parseInt(unitPrice); 
							String unitPriceComma = NumberFormat.getInstance().format(unitPriceInt); // 천단위 콤마
							String description = rs.getString("p_description");
					%>
						<td>
							<ul class="item">
									<li>
										<div class="thumb">
											<a href="shop_details.jsp?p_id=<%=p_id%>"><img src="<%=thumb%>" class="prd-image"></a>
										</div>
									</li> <a href="shop_details.jsp"><li class="prd-desc"><span class=""></span></li>
										<li class="prd-name"><%=name%></li>
										<li class="prd-price"><%=unitPriceComma%>원</li>
										 </a>
							</ul>
						</td>
					<%
						i++;
						if(i%4==0) out.print("</tr>");
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