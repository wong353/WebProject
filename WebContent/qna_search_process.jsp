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
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
<meta charset="UTF-8">
<title>QnA</title>
</head>
<script type="text/javascript">
	function checkSearch() {
		let txtVal = $('#search_text').val();
		txtVal = txtVal.trim();    // 문자열 중간 제외 앞뒤 공백을 제거
		if (!txtVal || txtVal == "") {
			alert('단어를 입력해주세요!');
			myform.search_text.focus();
			return false;
		} else {
			myform.submit();
		}
	}
</script>
<body>
<%@ include file="/include/dbconn.jsp"%>
<%@include file="/include/header.jsp" %>
<%@include file="/include/loginSessionPass.jsp" %>


<%
	try{
		request.setCharacterEncoding("utf-8");
		
		String search_text = request.getParameter("search_text");
		String radio = request.getParameter("radio");
		
		final int ROWSIZE = 10; // 한페이지에 보일 게시물 수
		final int BLOCK = 5; // 아래에 보일 페이지 최대개수 1~5 / 6~10 / 11~15 식으로 5개로 고정
		
		int pg = 1; //기본 페이지값
		
		if (request.getParameter("pg") != null) { //받아온 pg값이 있을때, 다른페이지일때
			pg = Integer.parseInt(request.getParameter("pg")); // pg값을 저장
		}
		
		int start = (pg * ROWSIZE) - (ROWSIZE - 1); // 해당페이지에서 시작번호(step3)
		int end = (pg * ROWSIZE); // 해당페이지에서 끝번호(step3)
		
		int allPage = 0; // 전체 페이지수
		
		int startPage = ((pg - 1) / BLOCK * BLOCK) + 1; // 시작블럭숫자 (1~5페이지일경우 1, 6~10일경우 6)
		int endPage = ((pg - 1) / BLOCK * BLOCK) + BLOCK; // 끝 블럭 숫자 (1~5일 경우 5, 6~10일경우 10)
		
		int total = 0;
		int count;
		
		// 검색결과 count
		if(radio.equals("rname")){
			String searchQuery = "SELECT count(*) FROM board WHERE name LIKE ?";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}else if(radio.equals("rsubject")){
			String searchQuery = "SELECT count(*) FROM board WHERE subject LIKE ?";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}else if(radio.equals("rcontent")){
			String searchQuery = "SELECT count(*) FROM board WHERE content LIKE ?";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			total = rs.getInt(1);
		}
		int sort = 1;
		
		rs.close();
		pstmt.close();
		
		//step3 설정을 위한 쿼리
		if(radio.equals("rname")){
			String searchQuery = "SELECT * FROM board WHERE name LIKE ? ORDER BY ref DESC, step ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}else if(radio.equals("rsubject")){
			String searchQuery = "SELECT * FROM board WHERE subject LIKE ? ORDER BY ref DESC, step ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}else if(radio.equals("rcontent")){
			String searchQuery = "SELECT * FROM board WHERE content LIKE ? ORDER BY ref DESC, step ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
		}
		rs = pstmt.executeQuery();
		 while(rs.next()){
			int stepNum = rs.getInt(1);
			String sql = "UPDATE board SET step3 = ? where num = ?";
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
<form action="qna_search_process.jsp?search_text=<%=search_text%>&radio=<%=radio%>" method="get" name="myform">
	<%-- <input type="hidden" name="search_text" value="<%=search_text%>">
	<input type="hidden" name="radio" value="<%=radio%>"> --%>
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
		<td colspan="5">검색된 글이 없습니다.</td>
	</tr>
<% 
	}else{
		if(radio.equals("rname")){
			String searchQuery = "SELECT * FROM board WHERE name LIKE ? and STEP3 >=? and STEP3 <= ? ORDER BY step3 ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		}else if(radio.equals("rsubject")){
			String searchQuery = "SELECT * FROM board WHERE subject LIKE ? and STEP3 >=? and STEP3 <= ? ORDER BY step3 ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		}else if(radio.equals("rcontent")){
			String searchQuery = "SELECT * FROM board WHERE content LIKE ? and STEP3 >=? and STEP3 <= ? ORDER BY step3 ASC";
			pstmt = conn.prepareStatement(searchQuery);
			pstmt.setString(1, "%"+search_text+"%");
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
		}
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
			int step2 = rs.getInt("step2");
			
			Date date = new Date();
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDate = sf.format(date);
%>
					<tr>
						<td><%=step2%></td>
						<td><%
								for(int j=0; j<indent; j++){
							%>&nbsp;&nbsp;&nbsp;&nbsp;
								<%}%>
							<%if(indent!=0 && parent!=2){%>
								<img src="./image/icon/reply.gif">		
							<%}else if(indent!=0 && parent==2){%>
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
<tr>
						<tr style="border: 0;">
							<td colspan="3" align="left" id="labelTab">
								<label>
									<input type="radio" value="rname" name="radio" <%if(radio.equals("rname")){%> checked="checked"<%}%>>이름
								</label>
								<label>
									<input type="radio" value="rsubject" name="radio"  <%if(radio.equals("rsubject")){%> checked="checked"<%}%> >제목
								</label>
								 <label>
									<input type="radio" value="rcontent" name="radio"  <%if(radio.equals("rcontent")){%> checked="checked"<%}%>>내용
								</label>
								<span class="key-wrap"> <input type="text" name="search_text" id="search_text" value=""><input type="button" id="searchBtn" value="검색" onclick="checkSearch()">
								</span>
							</td>
							<td colspan="2"><input type="button" value="글쓰기" id="writeBtn" onclick="window.location='qna_write.jsp?id=<%=id%>&pg=<%=pg%>'"></td>
						</tr>
						<td align="center" colspan="5"> 
							<%
								if(pg>BLOCK) {
							%>
								<a href="qna_search_process.jsp?pg=1">◀◀</a>
								<a href="qna_search_process.jsp?pg=<%=startPage-1%>">◀</a>
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
										<a href="qna_search_process.jsp?pg=<%=i%>&search_text=<%=search_text%>&radio=<%=radio%>"><%=i%></a>
							<%
									}
								}
							%>
							
							<%
								if(endPage<allPage){
							%>
								<a href="qna_search_process.jsp?pg=<%=endPage+1%>">▶</a>
								<a href="qna_search_process.jsp?pg=<%=allPage%>">▶▶</a>
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
		out.println(e.getMessage());
	}finally{
		if(pstmt!=null) pstmt.close();
		if(rs!=null) rs.close();
		if(conn!=null) conn.close();
	}
%>
	
<%@include file="/include/footer.jsp" %>

</body>
</html>