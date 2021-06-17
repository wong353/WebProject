<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.mysql.cj.x.protobuf.MysqlxCursor.Open"%>
<%@page import="com.sun.java.swing.plaf.windows.resources.windows"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="include/dbconn.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String p_id = request.getParameter("p_id");
	String pg = request.getParameter("pg");
	
	/* String encType = "utf-8"; //인코딩 타입
	int maxSize = 10 * 1024 * 1024; //최대 업로드될 파일의 크기10Mb */
	
	// String absolutePath2 = getServletContext().getContextPath(); // 상대경로
	String absolutePath = getServletContext().getRealPath("/"); //절대경로
	
	/* File file = null;
	MultipartRequest multi = new MultipartRequest(request, absolutePath, maxSize, encType, new DefaultFileRenamePolicy());
	 */
	
	
	try{
		String sql = "SELECT * FROM product WHERE p_id = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		rs = pstmt.executeQuery();
		if(rs.next()){
			String thumbnail = rs.getString("p_thumbnail");
			String detail1 = rs.getString("p_fileName_detail1");
			String detail2 = rs.getString("p_fileName_detail2");
			String detail3 = rs.getString("p_fileName_detail3");
			String detail4 = rs.getString("p_fileName_detail4");
			if(thumbnail != "" && thumbnail != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(thumbnail)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
			if(detail1 != "" && detail1 != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail1)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
			if(detail2 != "" && detail2 != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail2)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
			if(detail3 != "" && detail3 != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail3)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
			if(detail4 != "" && detail4 != null){	// 기존 파일 지우기
				// 물리적 파일삭제
				File FileList = new File(absolutePath);
				
				// 해당 폴더의 전체 파일 배열화
				String fileList[] = FileList.list();
				
				// 전체 파일
				for(int i = 0; i < fileList.length; i++){
					// 파일명 조회
					String delFileName = fileList[i];
					
					// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
					if(delFileName.equals(detail4)){
						File deleteFile = new File(absolutePath + "\\" + delFileName);
						String s = deleteFile.getName();
						
						Thread.sleep(50); // 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
						deleteFile.delete();
						break;
					}
				}
			}
		}
		
		if(pstmt!=null)	pstmt.close();
		
		sql = "DELETE FROM product WHERE p_id = ? ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		pstmt.executeUpdate();
		
		
%>	
		<script type="text/javascript">
			alert('삭제 성공했습니다.');
			location.href= "productList.jsp?pg="+<%=pg%>;
		</script>
<%		
	}catch (Exception e){
		e.printStackTrace();
		out.print(e.getMessage());
	}finally{
		if(pstmt!=null)pstmt.close();
		if(conn!=null)conn.close();
	}
%>
</body>
</html>