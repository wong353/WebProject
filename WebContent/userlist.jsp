<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
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
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
</head>
<script type="text/javascript">
	function checkSearch() {
		let txtVal = $('#search_text').val();
		txtVal = txtVal.trim();    // 문자열 중간 제외 앞뒤 공백을 제거
		if (!txtVal || txtVal == "") {
			alert('단어를 입력해주세요!');
			memberFrm.search_text.focus();
			return false;
		} else {
			memberFrm.submit();
		}
	}
</script>
<body>
<%@ include file = "/include/dbconn.jsp" %>
<%@ include file = "/include/admin.jsp" %>

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
	
		String sqlCount = "SELECT COUNT(*) FROM member";
		pstmt = conn.prepareStatement(sqlCount);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			total = rs.getInt(1)-1;
		}
		
		int sort = 1;
		
		rs.close();
		pstmt.close();
		
		// 정렬을 위한 쿼리
		String sqlSort = "SELECT userno FROM member ORDER BY userno desc";
		pstmt = conn.prepareStatement(sqlSort);
		rs = pstmt.executeQuery();
		 while(rs.next()){
			int stepNum = rs.getInt(1);
			sql = "UPDATE member SET ref = ? where userno = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sort);
			pstmt.setInt(2, stepNum);
			pstmt.executeUpdate();
			sort++;
		}
		pstmt.close();
		rs.close();
		
		// 끝페이지 설정
	 	allPage = (int)Math.ceil(total/(double)ROWSIZE);
		
		if(endPage > allPage) {
			endPage = allPage;
		}
%>
<form action="" method="post" name="memberFrm" >
			<div id="usr-caption">
				<div id="usr-subject">
					<h3>USERLIST</h3>
				</div>
				<div id="usr-wrapper">
					<div id="usr-table">
							<table>
								<tr style="border: 0;">
									<td colspan="14" id="searchMember">
											회원 수 : <%=total%> 명
									</td>
								</tr>	
								<tr>
									<th>NO.</th>
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
	
		sql = "SELECT * FROM member WHERE ref >=? and ref <= ? and id != ? ORDER by ref";	
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		pstmt.setString(3, "admin");
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
			int ref =rs.getInt("ref");
			
%>	
								<tr>
									<td class="usr_no"><%=ref%></td>
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
									<td>
										<a href="userList_modify.jsp?userno=<%=ruserno%>&pg=<%=pg%>">수정</a> / 
										<a href="deleteMember.jsp?userno=<%=ruserno%>&id=<%=rid%>&pg=<%=pg%>">삭제</a>
									</td>
								</tr>
<%
		}
	}
%>
							<tr id="member-page">
								<td align="center" colspan="12" id="boardNum"> 
									<%
										if(pg>BLOCK) {
									%>
										<a href="userList.jsp?pg=1">◀◀</a>
										<a href="userList.jsp?pg=<%=startPage-1%>">◀</a>
									<%
										}
									%>
									
									<%
										for(int i=startPage; i<= endPage; i++){
											if(i==pg){
									%>
												<b><%=i%></b>
									<%
											}else{
									%>
												<a href="userList.jsp?pg=<%=i%>"> <%=i%> </a>
									<%
											}
										}
									%>
									
									<%
										if(endPage<allPage){
									%>
										<a href="userList.jsp?pg=<%=endPage+1%>">▶</a>
										<a href="userList.jsp?pg=<%=allPage%>">▶▶</a>
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