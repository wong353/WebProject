<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.*"%>
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
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css"
	href="stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/header_cate2.css?ver1">
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/qna_write.css">
<link rel="stylesheet" type="text/css" href="stylesheet/fileButton.css">
<style type="text/css">
</style>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script language="javascript" type="text/javascript" src="./js/qna_reply.js"></script>
<script type="text/javascript">
$(document).ready(
		function() {
			var fileTarget = $('.filebox .upload-hidden');
			fileTarget.on('change', function() { // 값이 변경되면
				if (window.FileReader) { // modern browser
					var filename = $(this)[0].files[0].name;
				} else { // old IE
					var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출
				} // 추출한 파일명 삽입
				$(this).siblings('.upload-name').val(filename);
			});
		});
</script>
</head>
<body>

<%@ include file="/include/dbconn.jsp"%>

<%@include file="/include/loginSessionPass.jsp" %>

<%@include file="/include/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");

	int pg = Integer.parseInt(request.getParameter("pg"));

	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	
	String loginName = (String)session.getAttribute("loginName");
	int num = Integer.parseInt(request.getParameter("num"));
	String nowDate = sf.format(nowTime); // 현재 날짜
	String thumbnail="";
	String thumb_sub1="";
	
	try {
		String sql = "SELECT subject FROM board WHERE num=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();

		if (rs.next()) {
		String subject = rs.getString("subject");
%>
<form name="replyForm" method="post" enctype="multipart/form-data" action="qna_reply_process.jsp?num=<%=num%>&pg=<%=pg%>">
	<input type="hidden" value="<%=nowDate%>" name="dateNow"> 
	<div id="title">REPLY</div>
	<table>
		<tr>
			<td>
				<label class="write-title">SUBJECT:</label>
			</td>
			<td>
				<input type="text" name="subject" value="<%=subject%>" class="text-area" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td>
				<label class="write-title">NAME:</label>
			</td>
			<td>
				<input type="text" name="name" value="<%=loginName%>" class="text-area" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td>
				<label class="write-title">CONTENT:</label>
			</td>
			<td>	
				<textarea rows="10" cols="30" name="content" id="content"></textarea> 
				<div class="filebox">
					<input class="upload-name" value="파일선택" disabled="disabled" name="thumbnail2">
					<label for="ex_filename">업로드</label> <input type="file" id="ex_filename" class="upload-hidden" name="thumbnail1">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2">
			 <input type="button" value="글쓰기" class="button" onclick="replyCheck();">
			<input type="button" value="취소" class="button" onclick="history.back(-1);">
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