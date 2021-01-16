<%@page import="java.io.PrintWriter"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/include/dbconn.jsp"%>
	<%
	request.setCharacterEncoding("utf-8");
	
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	String ipAddress = request.getRemoteAddr();	// 프록시서버, 클라우드, 방화벽 등의 이유로 제대로 IP 값이 나오지 않음
	if (ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")) {	// 대소문자 구분없이 비교
		InetAddress inetAddress = InetAddress.getLocalHost();	//  InetAddress: IP 주소를 표현한 클래스(InetAddress 클래스의 생성자는 하나만 존재하지만, 특이하게 기본 생성자의 접근 제한자 default이기 때문에 new 연산자 객체를 생성할 수 없습니다. 따라서 InetAddress 클래스는 객체를 생성해 줄 수 있는 5개의 static 메서드를 제공하고 있습니다.)
		ipAddress = inetAddress.getHostAddress();	// 5가지 메서드 중 하나인 getLocalHost 사용하여 로컬 호스트의 IP 주소 반환
	}
	
	try{
	String realFolder = "C:\\Project\\1024\\WebContent\\image\\qna";
	String encType = "utf-8";
	int maxSize = 10 * 1024 * 1024; 
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String qid = "";
	String qcontent = "";
	
	File file = null;
		
	String subject = multi.getParameter("subject");
	String dateNow = multi.getParameter("dateNow");
	String thumbnail = multi.getFilesystemName("thumbnail1");
	String content = multi.getParameter("content");
	int num = Integer.parseInt(request.getParameter("num"));
	
	// 썸네일 null or 변경하지 않을 시에는 update 적용 x
	String sql = "UPDATE board SET regist_day=?, content=?, ip=?, subject=? where num = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, dateNow);
	pstmt.setString(2, content);
	pstmt.setString(3, ipAddress);
	pstmt.setString(4, subject);
	pstmt.setInt(5, num);
	pstmt.executeUpdate();
	pstmt.close();
	
	if(thumbnail!=null){	// 썸네일 변경할 시에 파일명 update 쿼리 적용
		String imgPath = "./image/qna/";
		String realThumb = imgPath+thumbnail;
		String sql2 = "UPDATE board SET thumbnail = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, realThumb);
		pstmt.executeUpdate();
	}
	
	%>
	<script>
		alert("게시글 변경에 성공했습니다.");
		document.location.href = "qna.jsp?pg=<%=pg%>";
	</script>
	<%
		
	}catch(Exception e){
		e.printStackTrace();
		out.println(e.getMessage());
	}finally{
		if(pstmt!=null) pstmt.close();
		if(conn!=null) conn.close();
	}
	%>
</body>
</html>