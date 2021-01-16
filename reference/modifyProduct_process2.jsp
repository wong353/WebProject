<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ include file="/include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	
	String productId = request.getParameter("id");
	String realFolder = "C:\\Project\\1016\\WebContent\\image"; //웹 어플리케이션상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb
	
	try {
		
	File file = null;
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	Enumeration files = multi.getFileNames();
	
	String file5 = (String)files.nextElement();
	String image4 = "./image/"+multi.getFilesystemName(file5);
	if(image4.equals("./image/null")) image4 = null;
	
	String file4 = (String)files.nextElement();
	String image3 = "./image/"+multi.getFilesystemName(file4);
	if(image3.equals("./image/null")) image3 = null;
	
	String file3 = (String)files.nextElement();
	String image2 = "./image/"+multi.getFilesystemName(file3);
	if(image2.equals("./image/null")) image2 = null;
	
	String file2 = (String)files.nextElement();
	String image1 = "./image/"+multi.getFilesystemName(file2);
	if(image1.equals("./image/null")) image1 = null;
	
	String file1 = (String)files.nextElement();
	String thumbnail = "./image/"+multi.getFilesystemName(file1);
	
		String sql = "update product set p_thumbnail=?, p_fileName_detail1=?, p_fileName_detail2=?, p_fileName_detail3=?, p_fileName_detail4=? where p_id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, thumbnail);
		pstmt.setString(2, image4);
		pstmt.setString(3, image3);
		pstmt.setString(4, image2);
		pstmt.setString(5, image1);
		pstmt.setString(6, productId);
		pstmt.executeUpdate();
			
		String success="<script> alert('수정 성공했습니다!')</script>";
		
		out.print(success);
		if(!success.isEmpty()){
			response.sendRedirect("productList.jsp");	
		}

	} catch (Exception e) {
		out.println("입력 실패");
		out.println(e.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (conn != null)
			conn.close();
	}
	%>
</body>
</html>