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
<title>입력</title>
</head>

<style type="text/css">
#top-left {
	border-right: 1px solid gray;
	float: left;
	margin-left: 200px;
	width: 709px;
	padding-right: 20px;
}

#top-right {
	float: right;
	width: 900px;
	padding-left: 20px;
	padding-right: 0 px;
	margin-right: 0px;
	height: 600px;
}

</style>
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
			String fileName_detail1 = rs.getString("p_fileName_detail1");
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
	<div id="details-body" style="margin-top: 63px; ">
			<div id="content">
				<div id="content-body">
					<div id="top">
						<div id="top-left">
							<div id="left-main">
								<a href=""><img alt="main" src="<%=thumbnail%>"></a>
							</div>
						</div>	
						<div id="top-right">
							<div id="table-opt">
								<table height="100px">
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
									<table border="0" style="margin-bottom: 500px;">
										<tr>
											<td>SIZE</td>
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
											<td colspan="2"><input type="button" value="BUY NOW">
												<input type="button" value="ADD TO CART" onclick="check_shop_detail();">
												<input type="button" value="WISH LIST" onclick="wish()">
												<input type="button" value="Q&A" onclick="qna()"></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
					<div style="margin-left: 80px; border-bottom: 1px solid gray;  " >
						<img alt="Image" src="<%=fileName_detail1%>" style="margin-top:100px;">
						<table style="text-align: center; width: 923px; margin: 0 auto;" border="0">
							<tbody>
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
									<td class="prd-detail-size-td"><span>52.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>M</span></td>
									<td class="prd-detail-size-td"><span>52.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>L</span></td>
									<td class="prd-detail-size-td"><span>52.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-td"><span>XL</span></td>
									<td class="prd-detail-size-td"><span>52.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
									<td class="prd-detail-size-td"><span>00.0</span></td>
								</tr>
								<tr>
									<td class="prd-detail-size-notice" colspan="6"><span>본
											실측표의 측정 치수는 GARMENTDYING에서 제공되며 절대적이지 않은 참고용 자료입니다.<br>측정자에
											따라서 약간의 오차가 있을 수 있으며 같은 제품 내에서도 실제 기재된 수치와 차이가 있으니 참고용 자료로만
											사용하시기 바랍니다.
									</span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<h3>DESCIPTION</h3>
					<h1><%=description%></h1>
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