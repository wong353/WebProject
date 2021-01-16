<%@page import="java.io.PrintWriter"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA</title>
<link rel="stylesheet" type="text/css" href="stylesheet/qna_read.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css?ver1">
<style type="text/css">
</style>
</head>
<body>
<%@ include file="/include/dbconn.jsp"%>

<%@include file="/include/loginSessionPass.jsp" %>

<%@include file="/include/header.jsp"%>

<%@include file="/include/QnA_IdCheck.jsp"%>

<%@include file="/qna_hit_duplPrevent.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

	int num = Integer.parseInt(request.getParameter("num"));
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	try{
		// 삭제글에는 admin 제외 접근할 수 없도록
		if(session.getAttribute("id")=="admin"){
			String accessDeny = "SELECT parent FROM board WHERE num = ?";
			pstmt = conn.prepareStatement(accessDeny);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()){
				int parent = rs.getInt("parent");
				if(parent == 2){
					%>
					<script>
						alert("삭제된 글입니다.");
						location.href="qna.jsp?<%=pg%>";
					</script>
					<%
				}
				rs.close();
				pstmt.close();
			}
		}
		
		String cnt = "Update board set hit=hit+1 where num = ? ";
		
		pstmt = conn.prepareStatement(cnt);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		pstmt.close();
		
		String sql = "SELECT * FROM board WHERE num=?";
		
		pstmt = conn.prepareStatement(sql);		
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			String subject = rs.getString("subject");
			String rid = rs.getString("id");
			String name = rs.getString("name");
			String content = rs.getString("content");
			String thumbnail = rs.getString("thumbnail");
			String regiDate = rs.getString("regist_day");
			// sf.format(nowTime) 현재 날짜 
		
%>
<div id="title">QnA</div>
<div id="title-content">상품 사진을 첨부하시면 보다 원활한 답변이 가능합니다.</div>
<form name="writeBoard" id="writeBoard" action="write_process.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" value="<%=sf.format(nowTime)%>" name="date">
	<table border="0">
		<tr>
			<td id="labeltag">
				<label id="subtitle">NAME:</label>
			</td>
			<td>
				<input type="text" name="name" value="<%=name%>" class="subtitle" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td id="labeltag">
				<label class="subtitle">DATE:</label>
			</td>
			<td>
				<input type="text" name="date" value="<%=regiDate%>" class="subtitle" readonly="readonly">
			</td> 
		</tr>
			<tr>
				<td colspan="2">
					<div id="content-wraaper">
						<div id="content"><%if (thumbnail != null) {%> <img alt="" src="<%=thumbnail%>">  <br> <%}%> <%=content%></div>
					</div>
				</td>
			</tr>
			<tr>
			<td colspan="2" id="view-menu">
				<div class="view-link">
					<a href="qna_modify.jsp?num=<%=num%>&id=<%=id%>&pg=<%=pg%>" class="view-link2">글수정</a>
				</div>
				<div class="view-link">
					<a href="qna_delete.jsp?num=<%=num%>&pg=<%=pg%>" class="view-link2">글삭제</a>
				</div>
				<div class="view-link">
					<a href="qna_write.jsp?pg=<%=pg%>" class="view-link2">글쓰기</a>
				</div>
				<% if(session.getAttribute("id").equals("admin")){ // 관리자만 답글을 이용할 수 있도록 조건문으로 막기%>
				<div class="view-link">
					<a href="qna_reply.jsp?num=<%=num%>&pg=<%=pg%>" class="view-link2">답글</a>
					<%-- <input type=button value="답글" OnClick="window.location='qna_reply.jsp?num=<%=num%>'"> 이렇게도 사용 가능 --%>
				</div>	
				<%} %>
				<div class="view-link">
					<a href="qna.jsp?pg=<%=pg%>" class="view-link2">목록</a>
				</div>				
			</td>
		</tr>
	</table>
</form>
<%
		}
	} catch (Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	} finally{
		if(rs!=null) rs.close();
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
	}
%>

<%@include file="/include/footer.jsp"%>
</body>
</html>