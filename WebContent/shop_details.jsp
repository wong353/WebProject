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
<link rel="stylesheet" type="text/css" href="stylesheet/shop_detail.css">
<title>GARMENTDYING OFFICIAL SITE</title>
</head>
<body>
	<%@ include file="/include/dbconn.jsp" %>
	
	<%@include file="/include/header.jsp" %>
	
	<%  
		try {
		String p_id = request.getParameter("p_id");
		String u_id = (String)session.getAttribute("id");
		String preUrl = request.getRequestURL().toString();
		if(request.getQueryString() != null)
			preUrl = preUrl + "?" + request.getQueryString();
		
		String sql = "SELECT * FROM product where p_id=?";	
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			String thumbnail = rs.getString("p_thumbnail");
			String name = rs.getString("p_name");
			String unitPrice = rs.getString("p_unitPrice");
			String detail1 = rs.getString("p_fileName_detail1");
			String detail2 = rs.getString("p_fileName_detail2");
			String detail3 = rs.getString("p_fileName_detail3");
			String detail4 = rs.getString("p_fileName_detail4");
			String description = rs.getString("p_description");
			String p_size = rs.getString("p_size");
	%>
	<script type="text/javascript">
		'use strict';
		function check_shop_detail() {
	
			// size 체크
			if (shop.p_size.value === "옵션 선택") {
				alert("사이즈를 선택해주세요!");
				return false;
			}
			let getId = '<%=u_id%>';
			if(getId == "null"){
				alert("로그인이 필요합니다");
				location.href = 'login.jsp?preUrl=<%=preUrl%>';
			}else{
				shop.submit();
			}
		}
	</script>
	<div id="details-body">
			<div id="content">
				<div id="content-body">
					<div id="top">
						<div id="top-left">
							<div id="left-main">
								<img alt="main" src="<%=thumbnail%>">
							</div>
						</div>	
						<div id="top-right">
							<div id="table-opt">
								<table id="priceTable">
									<tr>
										<td><h3><%=name%></h3></td>
									</tr>
									<tr>
										<td>
											<div class="tb-details" style="float: left;">
												<%=unitPrice%> 원 <!-- → <span style="color: #ff0000;">54,300원</span>
												(적 1,700원) -->
											</div>
										</td>
									</tr>
								</table>
								<form action="addToCart_process.jsp" name="shop">
									<input type="hidden" value="<%=p_id%>" name="p_id"> 
									<table style="margin-bottom: 500px;">
										<tr>
											<td id="size">SIZE</td>
											<td>
												<select name="p_size" id="p_size">
													<option>옵션 선택</option>
													<%if(p_size.indexOf("S")>0) {%><option value="S">S</option><%}%>
													<%if(p_size.indexOf("M")>0) {%><option value="M">M</option><%}%>
													<%if(p_size.indexOf("L")>0) {%><option value="L">L</option><%}%>
													<%if(p_size.indexOf("F")>0) {%><option value="FREE">FREE</option><%}%>
												</select>
											</td>
										</tr>
										<tr>
											<td colspan="2"><div style="border-bottom: 1px solid gray"></div></td>
										</tr>
										<tr>
											<td colspan="2"></td>
										</tr>
										<tr>
											<td>총 상품 금액</td>
											<td><strong><%=unitPrice%></strong>원</td>
										</tr>
										<tr>
											<td colspan="2"><input type="button" value="BUY NOW" disabled="disabled">
												<input type="button" value="ADD TO CART" onclick="check_shop_detail();">
												<input type="button" value="WISH LIST" disabled="disabled" onclick="wish()">
												<input type="button" value="Q&A" disabled="disabled" onclick="qna()"></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
					<div id="space"></div>
					<div id="detail-imageBox">
						<div id="img-container">
							<%if(detail1 != null && !detail1.equals("")){%>
									<div id="detail-img1">
										<img alt="Image" id="" src="<%=detail1%>">
									</div>
							<%}%>						
							<%if(detail2 != null && !detail2.equals("")){%>
									<div id="detail-img">
										<img alt="Image" id="" src="<%=detail2%>">
									</div>
							<%}%>						
							<%if(detail3 != null && !detail3.equals("")){%>
									<div id="detail-img">
										<img alt="Image" id="" src="<%=detail3%>">
									</div>
							<%}%>						
							<%if(detail4 != null && !detail4.equals("")){%>
									<div id="detail-img">
										<img alt="Image" id="" src="<%=detail4%>">
									</div>
							<%}%>	
						</div>					
						<table style="" id="detailTable">
							<tbody>
								<%-- <%if(detail2 != null && !detail2.equals("")){%>
								<tr>
									<td colspan="5">
										<div id="detail-img">
											<img alt="Image" id="" src="<%=detail2%>">
										</div>
									</td>
								</tr>
								<%}%>
								<%if(detail3 != null && !detail3.equals("")){%>
								<tr>
									<td colspan="5">
										<div id="detail-img">
											<img alt="Image" id="" src="<%=detail3%>>">
										</div>
									</td>
								</tr>
								<%}%>
								<%if(detail4 != null && !detail4.equals("")){%>
								<tr>
									<td colspan="5">
										<div id="detail-img">
											<img alt="Image" id="" src="<%=detail4%>">
										</div>
									</td>
								</tr>
								<%}%>
								 --%>
								<tr>
									<td class="prd-detail-size-notice" colspan="6">MODEL :	000CM 00KG / SIZE : LARGE</td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>단위:cm</span></td>
									<td class="prd-detail-size-td"><span>어깨</span></td>
									<td class="prd-detail-size-td"><span>가슴</span></td>
									<td class="prd-detail-size-td"><span>기장</span></td>
									<td class="prd-detail-size-td"><span>팔</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>S</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>M</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>L</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>FREE</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr id="prd-detail-size-notice-box">
									<td class="prd-detail-size-notice" colspan="6"><span>본
											실측표의 측정 치수는 GARMENTDYING에서 제공되며 절대적이지 않은 참고용 자료입니다.<br>측정자에
											따라서 약간의 오차가 있을 수 있으며 같은 제품 내에서도 실제 기재된 수치와 차이가 있으니 참고용 자료로만
											사용하시기 바랍니다.
									</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<%-- <div id="description">
						<h3>DESCIPTION</h3>
						<h1><%=description%></h1>
					</div> --%>
				</div>
			</div>
		</div>
		<%
			}
				}
			catch(Exception e){
				e.printStackTrace();
				out.print(e.getMessage());
			}
			finally{
				if (rs != null)
				rs.close();
				if (pstmt != null)
				pstmt.close();
				if (conn != null)
				conn.close();
			}
		%>
<%@include file="/include/footer.jsp" %>

</body>
</html>