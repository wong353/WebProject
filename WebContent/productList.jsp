<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/productlist.css?ver=1.1">
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
</head>
<body>
<%@ include file = "/include/dbconn.jsp" %>
<%@ include file="/include/admin.jsp"%>
<%@include file="/include/header.jsp" %>

<%
	request.setCharacterEncoding("utf-8");


	try{
	final int ROWSIZE = 5; // 한페이지에 보일 게시물 수
	final int BLOCK = 5; // 아래에 보일 페이지 최대개수 1~5 / 6~10 / 11~15 식으로 5개로 고정
	
	int pg = 1; //기본 페이지값
	
	if (request.getParameter("pg") != null) { //받아온 pg값이 있을때, 다른페이지일때
		pg = Integer.parseInt(request.getParameter("pg")); // pg값을 저장
	}
	
	int start = (pg * ROWSIZE) - (ROWSIZE - 1); // 해당페이지에서 시작번호(step2)
	int end = (pg * ROWSIZE); // 해당페이지에서 끝번호(step2)
	
	int allPage = 0; // 전체 페이지수
	
	int startPage = ((pg - 1) / BLOCK * BLOCK) + 1; // 시작블럭숫자 (1~5페이지일경우 1, 6~10일경우 6)
	int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK; // 끝 블럭 숫자 (1~5일 경우 5, 6~10일경우 10)

	int total = 0;
	int count;
	
	String sql = "";
	
		String sqlCount = "SELECT COUNT(*) FROM product";
		pstmt = conn.prepareStatement(sqlCount);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			total = rs.getInt(1);
		}
		
		int sort = 1;
		
		rs.close();
		pstmt.close();
		
		// 정렬을 위한 쿼리
		String sqlSort = "SELECT p_id FROM product ORDER BY p_id desc";
		pstmt = conn.prepareStatement(sqlSort);
		rs = pstmt.executeQuery();
		 while(rs.next()){
			String stepNum = rs.getString(1);
			sql = "UPDATE product SET ref = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sort);
			pstmt.setString(2, stepNum);
			pstmt.executeUpdate();
			sort++;
		}
		
		// 끝페이지 설정
	 	allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
		
		
%>
<form action="" method="get" name="myform" >
			<div id="prd-caption">
				<div id="prd-subject">
					<h3>PRODUCTLIST</h3>
				</div>
				<div id="prd-wrapper">
					<div id="prd-table">
							<table>
								<tr style="border: 0;">
									<td colspan="14" id="searchPrd">
											상품 수 : <%=total%> 개
									</td>
								</tr>	
								<tr>
									<th>No.</th>
									<th>상품아이디</th>
									<th>상품명</th>
									<th>가격</th>
									<th>사이즈</th>
									<th>컬러</th>
									<th>상품 설명</th>
									<th>분류</th>						
									<th>재고수</th>						
									<th>상태</th>						
									<th>썸네일</th>						
									<th>디테일사진1</th>						
									<th>디테일사진2</th>						
									<th>디테일사진3</th>						
									<th>디테일사진4</th>	
									<th></th>		
								</tr>				
								
<%
	if(total==0){
%>
							<tr align="center" bgcolor="#FFFFFF" height="30">
	 	  						<td colspan="5">등록된 상품이 없습니다.</td>
	 	  					</tr>
<%	}else{
		/* sql = "SELECT p_id FROM product ORDER By p_id DESC";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()){
			int idx = Integer.parseInt((rs.getString("p_id").substring(1)));
			System.out.println(idx);
		} */
		sql = "select * from product where ref >= ? and ref <= ? ORDER BY ref"; // p_id 의 P를 substring 후 비교	
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		rs = pstmt.executeQuery();
		while(rs.next()){
			int ref = rs.getInt("ref");
			String p_id = rs.getString("p_id");
			String p_name = rs.getString("p_name");
			String p_unitPrice = rs.getString("p_unitPrice");
			String p_size = rs.getString("p_size");
			String p_color = rs.getString("p_color");
			String p_description = rs.getString("p_description");
			String p_category = rs.getString("p_category");
			String p_unitsInStock = rs.getString("p_unitsInStock");
			String p_condition = rs.getString("p_condition");
			String p_thumbnail = rs.getString("p_thumbnail");
			/* if(p_thumbnail != null) p_thumbnail = realPath + p_thumbnail;  */ 
			String p_fileName1 = rs.getString("p_fileName_detail1");
			String p_fileName2 = rs.getString("p_fileName_detail2");
			String p_fileName3 = rs.getString("p_fileName_detail3");
			String p_fileName4 = rs.getString("p_fileName_detail4");
%>	
								<tr>
									<td class="prd_list"><%=ref%></td>
									<td class="prd_list"><%=p_id%></td>
									<td class="prd_list"><%=p_name%></td>
									<td class="prd_list"><%=p_unitPrice%></td>
									<td class="prd_list"><%=p_size%></td>
									<td class="prd_list"><%=p_color%></td>
									<td class="prd_list"><%=p_description%></td>
									<td class="prd_list"><%=p_category%></td>
									<td class="prd_list"><%=p_unitsInStock%></td>
									<td class="prd_list"><%=p_condition%></td>
									<%
										if (p_thumbnail == null) {
									%>
									<td></td>
									<%
										} else {
									%>
									<td class="prd_list_img"><img alt="" src="<%=p_thumbnail%>" class="thumb"></td>
									<%}%>
									<%
										if (p_fileName1 == null) {
									%>
									<td></td>
									<%
										} else {
									%>
									<td class="prd_list_img"><img alt="" src="<%=p_fileName1%>" class="thumb"></td>
									<%}%>
									<%
										if (p_fileName2 == null) {
									%>
									<td></td>
									<%
										} else {
									%>
									<td class="prd_list_img"><img alt="" src="<%=p_fileName2%>" class="thumb"></td>
									<%}%>
									<%
										if (p_fileName3 == null) {
									%>
									<td></td>
									<%
										} else {
									%>
									<td class="prd_list_img"><img alt="" src="<%=p_fileName3%>" class="thumb"></td>
									<%}%>
									<%
										if (p_fileName4 == null) {
									%>
									<td></td>
									<%
										} else {
									%>
									<td class="prd_list_img"><img alt="" src="<%=p_fileName4%>" class="thumb"></td>
									<%}%>
									
									<td>
										<a href="modifyProduct.jsp?p_id=<%=p_id%>&pg=<%=pg%>">수정</a> / 
										<a href="deleteProduct.jsp?p_id=<%=p_id%>&pg=<%=pg%>">삭제</a>
									</td>
								</tr>
<%
		}
	}
%>
							<tr id="prd-page">
								<td colspan="13"> 
									<%
										if(pg>BLOCK) {
									%>
										<a href="productList.jsp?pg=1">◀◀</a>
										<a href="productList.jsp?pg=<%=startPage-1%>">◀</a>
									<%
										}
									%>
									
									<%
										for(int i=startPage; i<= endPage; i++){
											if(i==pg){
									%>
												<b id="boardNum"><%=i%></b>
									<%
											}else{
									%>
												<a href="productList.jsp?pg=<%=i%>"><%=i%></a>
									<%
											}
										}
									%>
									
									<%
										if(endPage<allPage){
									%>
										<a href="productList.jsp?pg=<%=endPage+1%>">▶</a>
										<a href="productList.jsp?pg=<%=allPage%>">▶▶</a>
									<%
										}
									%>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</form>
<%
	}catch(Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	} finally{
		if(rs!=null) rs.close();
		if(pstmt!=null) pstmt.close();
		if(stmt!=null) stmt.close();
		if(conn!=null) conn.close();
	}
%>
		
<%@include file="/include/footer.jsp" %>

</body>
</html>