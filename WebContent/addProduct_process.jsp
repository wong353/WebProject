<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="/include/dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	
	String realFolder = "C:\\Project\\1024\\WebContent\\image"; //웹 어플리케이션상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb
	try{
		
	File file = null;
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	String productId = multi.getParameter("id");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String[] size = multi.getParameterValues("size");
	String rsize = Arrays.toString(size);
	String color = multi.getParameter("color");
	String description = multi.getParameter("description");
	String category = multi.getParameter("category");
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
	
	String sql = "insert into product values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	
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
	pstmt.setString(12, image3);
	pstmt.setString(13, image2);
	pstmt.setString(14, image1);
	pstmt.executeUpdate();
	
	String success="<script> alert('등록 성공했습니다!')</script>";
	out.print(success);
	if(!success.isEmpty()){
		response.sendRedirect("productList.jsp");	
	}
	
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
