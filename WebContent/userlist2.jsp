<%@ page import = "java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<style type="text/css">

</style>

</head>
<body>
<%@ include file = "/include/dbconn.jsp" %>
<%@ include file = "/include/admin.jsp" %>

<%@include file="/include/header.jsp" %>

<%
	request.setCharacterEncoding("utf-8");


	try{
	final int ROWSIZE = 10; // 한페이지에 보일 게시물 수
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
		
		// 끝페이지 설정
	 	allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
		
		/* String sqlList = "SELECT num, name, subject, regist_day, hit, indent from board where STEP2 >=? and STEP2 <= ? order by step2 asc";
		pstmt = conn.prepareStatement(sqlList);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		rs = pstmt.executeQuery(); 
		while(rs.next()){
			int num = rs.getInt("num");
			String name = rs.getString("name");
			String subject = rs.getString("subject");
			String regist_day = rs.getString("regist_day");
			int hit = rs.getInt("hit");
			int indent = rs.getInt("indent");
		} */
%>
	
	<form action="" method="get" name="memberFrm">
		<table width="1000">
			<tr>
				<th>회원번호</th>
				<th>이름</th>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>생일</th>
				<th>우편번호</th>						
				<th>주소</th>						
				<th>상세주소</th>						
				<th>참조주소</th>						
				<th>전화번호</th>						
			</tr>

			<%

			try {
				String sql = "select * from member order by userno desc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					int ruserno = rs.getInt("userno");
					String name = rs.getString("name");
					String rid = rs.getString("id");
					String nickname = rs.getString("nickname");
					String email = rs.getString("email");
					String birthday = rs.getString("birthday");
					String zip = rs.getString("zip");
					String addr = rs.getString("addr");
					String addr_detail = rs.getString("addr_detail");
					String addr_ref = rs.getString("addr_ref");
					String tel = rs.getString("tel");
			%>
			<tr>
				<td><%=ruserno%></td>
				<td><%=name%></td>
				<td><%=rid%></td>
				<td><%=nickname%></td>
				<td><%=email%></td>
				<td><%=birthday%></td>
				<td><%=zip%></td>
				<td><%=addr%></td>
				<td><%=addr_detail%></td>
				<td><%=tel%></td>
				<td><a href="mypage.jsp?userno=<%=ruserno%>">수정</a> / 
				<a href="delete.jsp?userno=<%=ruserno%>&id=<%=id%>">삭제</a></td>
			</tr>
			<%
				}
			} catch (Exception e) {
				out.println("실패");
				out.println(e.getMessage());
			} finally {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}
			%>
			<tr>
			<td><input type="button" value="돌아가기" onclick="history.back()"></td>		
			</tr>
		</table>
	</form>
	
	
<%@include file="/include/footer.jsp" %>
</body>
</html>