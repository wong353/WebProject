<%@page import="java.net.InetAddress"%>
<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
%>

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
<link rel="stylesheet" type="text/css" href="stylesheet/qna_write.css">
<link rel="stylesheet" type="text/css" href="stylesheet/fileButton.css">
<style type="text/css">
</style>
<script language="javascript" type="text/javascript" src="./js/qna_write.js"></script>
<script type="text/javascript">

/* 이미지 $(document).ready(
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
		}); */
</script>
</head>
<body>
<%@ include file="/include/dbconn.jsp"%>

<%@include file="/include/loginSessionPass.jsp" %>

<%@include file="/include/header.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
	
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	try{
		String ipAddress = request.getRemoteAddr();	// 프록시서버, 클라우드, 방화벽 등의 이유로 제대로 IP 값이 나오지 않음
		if (ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")) { // 대소문자 구분없이 비교
			InetAddress inetAddress = InetAddress.getLocalHost();	//  InetAddress: IP 주소를 표현한 클래스(InetAddress 클래스의 생성자는 하나만 존재하지만, 특이하게 기본 생성자의 접근 제한자 default이기 때문에 new 연산자 객체를 생성할 수 없습니다. 따라서 InetAddress 클래스는 객체를 생성해 줄 수 있는 5개의 static 메서드를 제공하고 있습니다.)
			ipAddress = inetAddress.getHostAddress();	// 5가지 메서드 중 하나인 getLocalHost 사용하여 로컬 호스트의 IP 주소 반환
		}

		String sql = "SELECT id,name FROM member WHERE id=?";

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();

		if (rs.next()) {
%>
<form name="writeBoard" action="qna_write_process.jsp?pg=<%=pg%>" method="post" enctype="multipart/form-data">
<input type="hidden" value="<%=sf.format(nowTime)%>" name="date">
<input type="hidden" value="<%=ipAddress%>" name="ip_addr">
<input type="hidden" name="id" value="<%=id%>" readonly="readonly">
	<table>
		<tr>
			<td>
				<label class="write-title">제목</label>
			</td>
			<td>
				<input type="text" name="subject">	
			</td>
		</tr>
		<tr>
			<td>
				<label class="write-title">이름</label>
			</td>
			<td>
				<input type="text" name="name" value="<%=rs.getString("name")%>" readonly="readonly">
			</td> 
		</tr>
		<tr>
			<td>
				<label class="write-title">내용</label>
			</td>
			<td>
				<textarea rows="10" cols="30" name="content" id="content" ></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<label class="write-title">파일</label>
			</td>
			<td>
				<div class="filebox">
					<input class="upload-name" value="파일선택" disabled="disabled" name="thumbnail2">
					<label for="ex_filename">업로드</label> <input type="file" id="ex_filename" class="upload-hidden" name="thumbnail1">
				</div>
			</td>
		</tr>
		<tr>
			<td>
			 <button type="button" onclick="formCheck()" >글 작성</button>
			 
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