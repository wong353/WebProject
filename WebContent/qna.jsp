<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="stylesheet/qna.css?ver=1.0">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css?ver=1.1">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<meta charset="UTF-8">
<title>QnA</title>
</head>

<script type="text/javascript">
	function checkSearch(){
		let txtVal = document.myform.search_text;
		if(txtVal.value.equals("") || !txtVal.value || txtVal.value == ""){
			alert('단어를 입력해주세요!');
			myfrm.search_text.focus();
			return false;
		}else{
			myfrm.submit();
		}
	}
</script>
<body>
<%@ include file = "/include/dbconn.jsp" %>

<%@include file="/include/loginSessionPass.jsp" %>

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
	
		String sqlCount = "SELECT COUNT(*) FROM board";
		pstmt = conn.prepareStatement(sqlCount);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			total = rs.getInt(1);
		}
		
		int sort = 1;
		
		rs.close();
		pstmt.close();
		
		//step2 설정을 위한 쿼리
		String sqlSort = "SELECT num FROM board order by ref desc, step asc";
		pstmt = conn.prepareStatement(sqlSort);
		rs = pstmt.executeQuery();
		 while(rs.next()){
			int stepNum = rs.getInt(1);
			sql = "UPDATE board SET step2 = ? where num = ?";
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
<form action="qna_search_process.jsp" method="post" name="myform" onsubmit='return frm_action()'>
			<div id="qna-caption">
				<div id="subject">
					<h3>Q&A</h3>
				</div>
				<div id="qna-wrapper">
					<div id="qna-table">
						<table border="1">
						<tr>
							<th class="numTab">NO.</th>
							<th class="subTab">SUBJECT</th>
							<th class="nameTab">NAME</th>
							<th class="dateTab">DATE</th>
							<th class="hitTab">HITS</th>						
						</tr>
<%
	if(total==0){
%>
							<tr align="center" bgcolor="#FFFFFF" height="30">
	 	  						<td colspan="5">등록된 글이 없습니다.</td>
	 	  					</tr>
<%	}else{
		sql = "SELECT * FROM board  where STEP2 >=? and STEP2 <= ? order by step2 asc";	
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		rs = pstmt.executeQuery();
		while(rs.next()){
			int num = rs.getInt("num");
			String subject = rs.getString("subject");
			String rid = rs.getString("id");
			String name = rs.getString("name");
			// 이름 마스킹 처리
			String name_sub1 = name.substring(0, name.length()-1);	// 시작부터 마지막 전까지 저장
			String name_masking = name_sub1+"*";
			
			String regist_day = rs.getString("regist_day");
			int hit = rs.getInt("hit");
			String content = rs.getString("content");
			String ip = rs.getString("ip");
			int indent = rs.getInt("indent");
			int parent = rs.getInt("parent");
			
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDate = sf.format(date);
%>	
							<tr>
								<td><%=num%></td>
								<td><%for(int j=0; j<indent; j++){ // 답글의 들여쓰기 정도%>	
										&nbsp;&nbsp;&nbsp;&nbsp;
									<%}%>
									<%if(indent!=0 && parent!=2){ // 답글 아이콘 %>
										<img src="./image/icon/reply.gif">		
									<%}else if(indent!=0 && parent==2){ // 삭제된 답글 아이콘%>
										<img src="./image/icon/reply.gif" id="delSubject">
									<%}%>	
									
									<a href="qna_read.jsp?num=<%=num%>&id=<%=rid%>&pg=<%=pg%>" <%if(parent == 2){ %> style="pointer-events: none; color: #c2c2c2;s"<%}%>><%=subject%></a>
									<%if(regist_day.equals(nowDate) && parent != 2){ %> <img src="./image/icon/new.jpg"> <% } %></td>
								<td><%=name_masking%></td>
								<td><%=regist_day%></td>
								<td><%=hit%></td>
							</tr>
<%
		}
	}
%>
							<tr style="border: 0;">
								<td colspan="3" align="left" id="labelTab">
									<label>
										<input type="radio" value="rname" name="radio">이름
									</label>
									<label>
										<input type="radio" value="rsubject" name="radio" checked>제목
									</label>
									 <label>
										<input type="radio" value="rcontent" name="radio">내용
									</label>
									<span class="key-wrap">
										<input type="text" name="search_text" id="search_text" value="" class="MS_input_txt"><input type="submit" id="searchBtn" value="검색" onclick="checkSearch()">
									</span>
								</td>
								<td colspan="2"><input type="button" id="writeBtn" value="글쓰기" onclick="window.location='qna_write.jsp?id=<%=id%>&pg=<%=pg%>'"></td>
							</tr>
							<tr id="qna-page">
								<td align="center" colspan="5" > 
									<%
										if(pg>BLOCK) {
									%>
										<a href="qna.jsp?pg=1">◀◀</a>
										<a href="qna.jsp?pg=<%=startPage-1%>">◀</a>
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
												<a href="qna.jsp?pg=<%=i%>"><%=i%></a>
									<%
											}
										}
									%>
									
									<%
										if(endPage<allPage){
									%>
										<a href="qna.jsp?pg=<%=endPage+1%>">▶</a>
										<a href="qna.jsp?pg=<%=allPage%>">▶▶</a>
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