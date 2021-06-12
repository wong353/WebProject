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
<link rel="stylesheet" type="text/css" href="stylesheet/userList.css?ver=1.0">
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
	
		String sqlCount = "SELECT COUNT(*) FROM member";
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
<form action="" method="get" name="memberFrm" >
			<div id="usr-caption">
				<div id="usr-subject">
					<h3>USERLIST</h3>
				</div>
				<div id="usr-wrapper">
					<div id="usr-table">
							<table>
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
									<th></th>			
								</tr>				
								
<%
	if(total==0){
%>
								<tr align="center" bgcolor="#FFFFFF" height="30">
	 	  							<td colspan="5">등록된 회원이 없습니다.</td>
	 	  						</tr>
<%	} else {
	
		sql = "SELECT * FROM member ORDER by userno DESC";	
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while(rs.next()){
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
									<td class="usr_list"><%=ruserno%></td>
									<td class="usr_list"><%=name%></td>
									<td class="usr_list"><%=rid%></td>
									<td class="usr_list"><%=nickname%></td>
									<td class="usr_list"><%=email%></td>
									<td class="usr_list"><%=birthday%></td>
									<td class="usr_list"><%=zip%></td>
									<td class="usr_list"><%=addr%></td>
									<td class="usr_list"><%=addr_detail%></td>
									<td class="usr_list"><%=addr_ref%></td>	
									<td class="usr_list"><%=tel%></td>	
									<td><a href="mypage.jsp?userno=<%=ruserno%>">수정</a> / 
									<a href="delete.jsp?userno=<%=ruserno%>&id=<%=id%>">삭제</a></td>
								</tr>
<%
		}
	}
%>
							<tr>
								<td align="center" colspan="5"> 
									<%
										if(pg>BLOCK) {
									%>
										<a href="userlist.jsp?pg=1">◀◀</a>
										<a href="userlist.jsp?pg=<%=startPage-1%>">◀</a>
									<%
										}
									%>
									
									<%
										for(int i=startPage; i<= endPage; i++){
											if(i==pg){
									%>
												<div id="number"><b><%=i%></b></div>
									<%
											}else{
									%>
												<a href="userlist.jsp?pg=<%=i%>"><%=i%></a>
									<%
											}
										}
									%>
									
									<%
										if(endPage<allPage){
									%>
										<a href="userlist.jsp?pg=<%=endPage+1%>">▶</a>
										<a href="userlist.jsp?pg=<%=allPage%>">▶▶</a>
									<%
										}
									%>
								</td>
							</tr>
							<tr>
								<td colspan="14" id="searchMember">
									<label>
										<input type="radio" value="rname" name="radio">이름
									</label>
									<label>
										<input type="radio" value="rnick" name="radio" checked>닉네임
									</label>
									 <label>
										<input type="radio" value="rusrno" name="radio">회원번호
									</label>
									<span class="key-wrap"> <input type="text" name="search_text" value="" class="MS_input_txt"><input type="submit" value="검색">
									</span>
									<p>회원 수 : <%=total%> 명 </p>
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