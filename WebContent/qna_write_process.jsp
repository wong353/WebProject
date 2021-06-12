<%@page import="sun.font.Script"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file ="/include/dbconn.jsp" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String realFolder = "C:\\Project\\MyWeb\\WebContent\\image\\qna"; //웹 어플리케이션상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb
	String id ="";
	String content ="";
	
	int pg = Integer.parseInt(request.getParameter("pg"));
	
	try {
		
	File file = null;
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String subject = multi.getParameter("subject");
	id = multi.getParameter("id");
	String name = multi.getParameter("name");
	content = multi.getParameter("content");
	String date = multi.getParameter("date");
	String ip_addr = multi.getParameter("ip_addr");
	int max = 0;
	
	Enumeration files = multi.getFileNames();

	String file1 = (String) files.nextElement();
	String qna_real = "./image/qna/";
	String thumbnail = qna_real + multi.getFilesystemName(file1);
	if (thumbnail.equals(qna_real + "null")) {
		thumbnail = null;
	}
	
	String sql = "SELECT MAX(num) from board";
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);
	
	if(rs.next()){
		max = rs.getInt(1);
	}

	sql = "INSERT INTO board(subject,id,name,regist_day,content,thumbnail,ip,ref,ref2)"
			 + "VALUES(?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, subject);
	pstmt.setString(2, id);
	pstmt.setString(3, name);
	pstmt.setString(4, date);
	pstmt.setString(5, content);
	pstmt.setString(6, thumbnail);
	pstmt.setString(7, ip_addr);
	pstmt.setInt(8, max+1);
	pstmt.setInt(9, max+1);
	pstmt.executeUpdate();
	pstmt.close();

	String lineup = "ALTER TABLE board AUTO_INCREMENT=1";
	String lineup2 = "SET @COUNT = 0;";
	String lineup3 = "UPDATE board SET num = @COUNT:=@COUNT+1";
	pstmt = conn.prepareStatement(lineup);
	pstmt.executeUpdate();
	pstmt = conn.prepareStatement(lineup2);
	pstmt.executeUpdate();
	pstmt = conn.prepareStatement(lineup3);
	pstmt.executeUpdate();
	%>
	<script>
		alert("게시글 등록에 성공했습니다.");
		document.location.href = "qna.jsp?pg=<%=pg%>";
	</script>
	<%

} catch (Exception e) {
	e.printStackTrace();
	out.println(e.getMessage());
	/* out.println(id);
	out.println(content); */
} finally {
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	if (stmt != null)
		stmt.close();
}
%>

</body>
</html>