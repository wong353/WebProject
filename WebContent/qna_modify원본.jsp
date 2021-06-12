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
<link rel="stylesheet" type="text/css" href="stylesheet/header.css">
<link rel="stylesheet" type="text/css" href="stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="stylesheet/qna_read.css">
<link rel="stylesheet" type="text/css" href="stylesheet/fileButton.css">
<style type="text/css">
</style>
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
<script type="text/javascript" src="./js/qna_modify.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				var fileTarget = $('.filebox .upload-hidden');
				fileTarget.on('change', function() { // 값이 변경되면
					if (window.FileReader) { // modern browser
						var filename = $(this)[0].files[0].name;
					} else { // old IE
						var filename = $(this).val().split('/').pop().split(
								'\\').pop(); // 파일명만 추출
					} // 추출한 파일명 삽입
					$(this).siblings('.upload-name').val(filename);
				});
			});
</script>
<script>
	function setThumbnail(event) {
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			document.querySelector("div#image_container").appendChild(img);
		};
		reader.readAsDataURL(event.target.files[0]);
	}
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

	String num = request.getParameter("num");
	String nowDate = sf.format(nowTime); // 현재 날짜
	String thumbnail="";
	String thumb_sub1="";
	try {
		String sql = "SELECT * FROM board WHERE num=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, num);
		rs = pstmt.executeQuery();

		if (rs.next()) {
		String subject = rs.getString("subject");
		String rid = rs.getString("id");
		String name = rs.getString("name");
		String content = rs.getString("content");
		if (rs.getString("thumbnail") != null){
			thumbnail = rs.getString("thumbnail");
			thumb_sub1 = thumbnail.substring(12); // 파일 명만 나오도록 substring */	
		}
		String regiDate = rs.getString("regist_day");
%>
<form name="modifyForm" method="post" enctype="multipart/form-data" action="qna_modify_process.jsp?num=<%=num%>&id=<%=id%>&pg=<%=pg%>">
	<input type="hidden" value="<%=sf.format(nowTime)%>" name="dateNow"> 
	<table border="1">
		<tr>
			<td>
				<label>SUBJECT:</label>
			</td>
			<td>
				<input type="text" name="subject" value="<%=subject%>" class="text-area">
			</td> 
		</tr>
		<tr>
			<td>
				<label>NAME:</label>
			</td>
			<td>
				<input type="text" name="name" value="<%=name%>" class="text-area" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td>
				<label>CONTENT:</label>
			</td>
			<td>
				<!-- 널 값이 아니라면 출력하도록 조건문 -->
				<%if(thumbnail!=null){%>
					<div id="image_container"><img alt="" src="<%=thumbnail%>"></div>
				<%}%><br> 	
				
				<textarea rows="10" cols="30" name="content" id="content"><%=content%></textarea> 

				<div class="filebox">
					<input class="upload-name" value=<%=thumb_sub1%> disabled="disabled" name="thumbnail2">
					<label for="ex_filename">수정 업로드</label> <input type="file" id="ex_filename" class="upload-hidden" name="thumbnail1" accept="image/*" onchange="setThumbnail(event);">
					<span></span>
				</div>
				</td>
		</tr>
		<tr>
			<td colspan="2">
			<input type="button" value="글쓰기" class="button" onclick="modifyCheck();">
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