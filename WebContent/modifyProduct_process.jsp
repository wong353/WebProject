<%@page import="javafx.scene.control.Alert"%>
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
	
	String realFolder = "C:\\Project\\MyWeb\\WebContent\\image\\product"; //웹 어플리케이션상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb
	
	try {
		
	File file = null;
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("id");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String[] size = multi.getParameterValues("size");
	String rsize = Arrays.toString(size);
	String color = multi.getParameter("color");
	String description = multi.getParameter("description");
	String category = multi.getParameter("category2");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	Integer price;

	if (unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);

	long stock;

	if (unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	

	String params="";
	String fileName="";
	
	/*
		1. 업로드 파일이 없을 경우
			- 1-1  기존의 업로드 파일이 있을 경우 => no touch
			- 1-2  기존의 업로드 파일이 없을 경우 => no touch
			- 1-3  기존의 업로드 파일을 삭제할 경우 => update 문 적용
		2. 업로드 파일 있을 경우 => 기존 파일 상관 없이 무조건 업로드
	*/
	
	Enumeration files = multi.getFileNames();	// 열거형으로 모든 파일명을 가져옴
	
	String file5 = (String)files.nextElement();	// 파일명 하나씩 String에 담음
	String image4 = "./image/product"+multi.getFilesystemName(file5);	// 로컬 경로와 파일명을 더해줌
	if(image4.equals("./image/product/null")) image4 = null;	// 이미지 경로에 대한 값이 없을 때에 null로 만듦
	
	String file4 = (String)files.nextElement();
	String image3 = "./image/product"+multi.getFilesystemName(file4);
	if(image3.equals("./image/product/null")) image3 = null;
	
	String file3 = (String)files.nextElement();
	String image2 = "./image/product"+multi.getFilesystemName(file3);
	if(image2.equals("./image/product/null")) image2 = null;
	
	String file2 = (String)files.nextElement();
	String image1 = "./image/product"+multi.getFilesystemName(file2);
	if(image1.equals("./image/product/null")) image1 = null;
	
	String file1 = (String)files.nextElement();
	String thumbnail = "./image/product"+multi.getFilesystemName(file1);
	
		String sql = "update product set p_id=?, p_name=?, p_unitPrice=?, p_size=?,"+
				"p_color=?, p_description=?, p_category=?, p_unitsInStock=?, p_condition=?,p_thumbnail=?, p_fileName_detail1=?, p_fileName_detail2=?, p_fileName_detail3=?, p_fileName_detail4=? where p_id=?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		pstmt.setString(2, name);
		pstmt.setInt(3, price);
		pstmt.setString(4, rsize);
		pstmt.setString(5, color);
		pstmt.setString(6, description);
		pstmt.setString(7, category);
		pstmt.setLong(8, stock);
		pstmt.setString(9, condition);
		pstmt.setString(10, thumbnail);
		pstmt.setString(11, image4);
		pstmt.setString(12, image1);
		pstmt.setString(13, image2);
		pstmt.setString(14, image3);
		pstmt.setString(15, productId);
		pstmt.executeUpdate();
			
		/* response.sendRedirect("modifyProduct_process2.jsp"); */
	
		response.sendRedirect("productList.jsp");	
		out.print("<script>");
		out.print("alert('수정 성공했습니다!');");
		out.print("</script>");

	} catch (Exception e) {
		e.printStackTrace();
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