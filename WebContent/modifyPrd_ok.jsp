<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
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
	
	String pg = request.getParameter("pg");
	// String realFolder = "C:\\Project\\MyWeb\\WebContent\\image\\product"; //웹 어플리케이션상의 경로
	String absolutePath = getServletContext().getRealPath("/"); //servlet상의 절대 경로
	String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb
	
	try {
		
	File file = null;
	MultipartRequest multi = new MultipartRequest(request, absolutePath, maxSize, encType, new DefaultFileRenamePolicy());
	
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
	
	// 업로드된 파일명
	String thumbnail_Upload = multi.getFilesystemName("thumbnail2");	
	
	// 웹상에 보이는 이미지명
	String thumbnail2 = multi.getParameter("thumbnailImg");
	String detail1 = multi.getParameter("detail1");
	String detail2 = multi.getParameter("detail2");
	String detail3 = multi.getParameter("detail3");
	String detail4 = multi.getParameter("detail4");
	
	// 수정 전 이미지 명(DB값)
	String thumbnailOrg = multi.getParameter("imgOrigin1");
	String detail1Org = multi.getParameter("imgOrigin2");
	String detail2Org = multi.getParameter("imgOrigin3");
	String detail3Org = multi.getParameter("imgOrigin4");
	String detail4Org = multi.getParameter("imgOrigin5");
	
	Enumeration files = multi.getFileNames();	// 열거형으로 모든 파일명을 가져옴
	String[] fileTag = new String[5]; 
	String[] fileName = new String[5];
	
	/*
	1. 업로드 파일이 없을 경우
		- 1-1  기존의 파일이 있을 경우 => no touch
		- 1-2  기존의 파일이 없을 경우 => no touch
		- 1-3  기존의 파일을 삭제할 경우 => update 문 적용
	2. 업로드 파일 있을 경우 => 기존 파일 상관 없이 무조건 업로드
	*/
	
	// img 제외하고 업데이트
	String sql = "UPDATE product SET p_id=?, p_name=?, p_unitPrice=?, p_size=?,"+
			"p_color=?, p_description=?, p_category=?, p_unitsInStock=?, p_condition=? WHERE p_id=?";
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
	pstmt.setString(10, productId);
	pstmt.executeUpdate();
	pstmt.close();
	
	String file5 = (String)files.nextElement();	// detail4
	String image5 = multi.getFilesystemName(file5);	
	System.out.println("경로: "+absolutePath);
	System.out.print("<br>");
	
	String file4 = (String)files.nextElement();	// detail3
	String image4 = multi.getFilesystemName(file4);
//	out.println("디테일3: "+image4);
//	out.print("<br>");
	
	String file3 = (String)files.nextElement();	// detail2
	String image3 = multi.getFilesystemName(file3);
//	out.println("디테일2: "+image3);
//	out.print("<br>");
	
	String file2 = (String)files.nextElement();	// detail1
	String image2 = multi.getFilesystemName(file2);
//	out.println("디테일1: "+image2);
//	out.print("<br>");
	
	String file1 = (String)files.nextElement();	// thumbnail
	String image1 = multi.getFilesystemName(file1);
//	out.println("썸네일: "+image1);
//	out.print("<br>");
	
	/* out.println("thumbnail_Upload: "+thumbnail_Upload);
	out.print("<br>");
	out.println("thumbnail2: "+thumbnail2);
	out.print("<br>");
	out.println("thumbnailOrg: "+thumbnailOrg);
	out.print("<br>"); */
	
	
	// thumbnail
	// 파일 업로드시
	if(thumbnail_Upload != null && thumbnail_Upload != ""){
		String sql2 = "UPDATE product SET p_thumbnail = ? where p_id = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, thumbnail_Upload);
		pstmt.setString(2, productId);
		pstmt.executeUpdate();
		if(thumbnailOrg != "" && thumbnailOrg != null){	// 기존 파일 지우기
			// 물리적 파일삭제
			File FileList = new File(absolutePath);
			
			// 해당 폴더의 전체 파일 배열화
			String fileList[] = FileList.list();
			
			// 전체 파일
			for(int i = 0; i < fileList.length; i++){
				// 파일명 조회
				String delFileName = fileList[i];
				
				// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
				if(delFileName.equals(thumbnailOrg)){
					File deleteFile = new File(absolutePath + "\\" + delFileName);
					String s = deleteFile.getName();
					
					Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
					deleteFile.delete();
					break;
				}
			}
		}
	}// 기존 파일 삭제됐을 때
	else if(thumbnailOrg != null && thumbnailOrg != "" && thumbnail_Upload == null && thumbnail2.equals("파일선택")){	
		String sql2 = "UPDATE product SET p_thumbnail = ? where p_id = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, thumbnail_Upload);
		pstmt.setString(2, productId);
		pstmt.executeUpdate();
		
		// 물리적 파일삭제
		File FileList = new File(absolutePath);
		
		// 해당 폴더의 전체 파일 배열화
		String fileList[] = FileList.list();
		
		// 전체 파일
		for(int i = 0; i < fileList.length; i++){
			// 파일명 조회
			String delFileName = fileList[i];
			
			// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
			if(delFileName.equals(thumbnailOrg)){
				File deleteFile = new File(absolutePath + "\\" + delFileName);
				String s = deleteFile.getName();
				
				Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
				deleteFile.delete();
				break;
			}
		}
	} 
	
	// detail1
		if(image2 != null && image2 != ""){
			String sql2 = "UPDATE product SET p_fileName_detail1 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image2);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			if(detail1Org != "" && detail1Org != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail1Org)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
		}// 기존 파일 삭제됐을 때
		else if(detail1Org != null && detail1Org != "" && image2 == null && detail1.equals("파일선택")){	
			String sql2 = "UPDATE product SET p_fileName_detail1 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image2);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			
			// 물리적 파일삭제
			File FileList = new File(absolutePath);
			
			// 해당 폴더의 전체 파일 배열화
			String fileList[] = FileList.list();
			
			// 전체 파일
			for(int i = 0; i < fileList.length; i++){
				// 파일명 조회
				String delFileName = fileList[i];
				
				// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
				if(delFileName.equals(detail1Org)){
					File deleteFile = new File(absolutePath + "\\" + delFileName);
					String s = deleteFile.getName();
					
					Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
					deleteFile.delete();
					break;
				}
			}
		}
	
		// detail2
		if(image3 != null && image3 != ""){
			String sql2 = "UPDATE product SET p_fileName_detail2 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image3);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			if(detail2Org != "" && detail2Org != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail2Org)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
		}// 기존 파일 삭제됐을 때
		else if(detail2Org != null && detail2Org != "" && image3 == null && detail2.equals("파일선택")){	
			String sql2 = "UPDATE product SET p_fileName_detail2 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image3);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			
			// 물리적 파일삭제
			File FileList = new File(absolutePath);
			
			// 해당 폴더의 전체 파일 배열화
			String fileList[] = FileList.list();
			
			// 전체 파일
			for(int i = 0; i < fileList.length; i++){
				// 파일명 조회
				String delFileName = fileList[i];
				
				// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
				if(delFileName.equals(detail2Org)){
					File deleteFile = new File(absolutePath + "\\" + delFileName);
					String s = deleteFile.getName();
					
					Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
					deleteFile.delete();
					break;
				}
			}
		}

		// detail3
		if(image4 != null && image4 != ""){
			String sql2 = "UPDATE product SET p_fileName_detail3 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image4);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			if(detail3Org != "" && detail3Org != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail3Org)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
		}// 기존 파일 삭제됐을 때
		else if(detail3Org != null && detail3Org != "" && image4 == null && detail3.equals("파일선택")){	
			String sql2 = "UPDATE product SET p_fileName_detail3 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image4);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			
			// 물리적 파일삭제
			File FileList = new File(absolutePath);
			
			// 해당 폴더의 전체 파일 배열화
			String fileList[] = FileList.list();
			
			// 전체 파일
			for(int i = 0; i < fileList.length; i++){
				// 파일명 조회
				String delFileName = fileList[i];
				
				// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
				if(delFileName.equals(detail3Org)){
					File deleteFile = new File(absolutePath + "\\" + delFileName);
					String s = deleteFile.getName();
					
					Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
					deleteFile.delete();
					break;
				}
			}
		}

		// detail4
		if(image5 != null && image5 != ""){
			String sql2 = "UPDATE product SET p_fileName_detail4 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image5);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			if(detail4Org != "" && detail4Org != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail4Org)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
		}// 기존 파일 삭제됐을 때
		else if(detail4Org != null && detail4Org != "" && image5 == null && detail4.equals("파일선택")){	
			String sql2 = "UPDATE product SET p_fileName_detail4 = ? where p_id = ?";
			pstmt = conn.prepareStatement(sql2);
			pstmt.setString(1, image5);
			pstmt.setString(2, productId);
			pstmt.executeUpdate();
			
			// 물리적 파일삭제
			File FileList = new File(absolutePath);
			
			// 해당 폴더의 전체 파일 배열화
			String fileList[] = FileList.list();
			
			// 전체 파일
			for(int i = 0; i < fileList.length; i++){
				// 파일명 조회
				String delFileName = fileList[i];
				
				// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
				if(delFileName.equals(detail4Org)){
					File deleteFile = new File(absolutePath + "\\" + delFileName);
					String s = deleteFile.getName();
					
					Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
					deleteFile.delete();
					break;
				}
			}
		}	
	%>
		<script type="text/javascript">
			alert('수정 성공했습니다!');
			location.href="productList.jsp?pg=<%=pg%>";
		</script>
	<%
		
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