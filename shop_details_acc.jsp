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
#top-left{
	border-right: 1px solid gray;
}

</style>



<body>
	<%@ include file="/include/dbconn.jsp" %>
	
	<%@include file="/include/header.jsp" %>
	
	<%
		try {
		String sql = "SELECT * FROM product";
							
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()) {															
	%>
	<div id="details-body" style="margin-top: 63px; ">
			<div id="content">
				<div id="content-body">
					<div id="top">
						<div id="top-left"	style="float: left; margin-left: 200px; width: 709px; padding-right: 20px;">
							<div id="left-main">
								<a href=""><img alt="main" src="<%=rs.getString("p_fileName")%>"></a>
							</div>
						</div>	
						<div id="top-right"	style="float: right; width: 900px; padding-left: 20px; padding-right:0 px; margin-right:0px; height: 600px;">
							<div id="table-opt">
								<table border="0" height="100px">
									<tr>
										<td><h3><%=rs.getString("p_name")%></h3></td>
									</tr>
									<tr>
										<td>
											<div class="tb-details" style="float: left;">
												<%=rs.getString("p_unitPrice")%> 원 <!-- → <span style="color: #ff0000;">54,300원</span>
												(적 1,700원) -->
											</div>
										</td>
									</tr>
								</table>
								<form action="">
									<table border="0" style="margin-bottom: 500px;">
										<tr>
											<td>SIZE</td>
											<td><select name="size-opt">
													<option checked>옵션 선택</option>
													<option>S</option>
													<option>M</option>
													<option>L</option>
													<option>XL</option>
											</select></td>
										</tr>
										<tr>
											<td>총 상품 금액</td>
											<td><strong>0</strong>원</td>
										</tr>
										<tr>
											<td colspan="2"><input type="button" value="BUY NOW">
												<input type="button" value="ADD TO CART" onclick="toCart()">
												<input type="button" value="WISH LIST" onclick="wish()">
												<input type="button" value="Q&A" onclick="qna()"></td>
										</tr>
									</table>
								</form>
							</div>
						</div>
					</div>
					<div style="margin-left: 80px; border-bottom: 1px solid gray;  " >
						<img alt="Image" src="http://cdn015.negagea.net/wherehouse/ESPIONAGE/20AW/epog_20aw_59_wear_01.jpg" style="margin-top:100px;">
						<table style="text-align: center; width: 923px; margin: 0 auto;"
							border="0">
							<tbody>
								<tr>
									<td class="prd-detail-size-notice" colspan="6">MODEL :
										000CM 00KG / SIZE : LARGE</td>
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