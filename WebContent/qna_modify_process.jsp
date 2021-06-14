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
		InetAddress inetAddress = InetAddress.getLocalHost();	//  InetAddress: IP 주소를 표현한 클래스(InetAddress 클래스의 생성자는 하나만 존재하지만, 특이하게 기본 생성자의 접근 제한자 default이기 때문에 new 연산자 객체를 생성할 수 없음. 따라서 InetAddress 클래스는 객체를 생성해 줄 수 있는 5개의 static 메서드를 제공
		ipAddress = inetAddress.getHostAddress();	// 5가지 메서드 중 하나인 getLocalHost 사용하여 로컬 호스트의 IP 주소 반환
	}
	
	try{
	String realFolder = "C:\\Project\\MyWeb\\WebContent\\image\\qna";
	String encType = "utf-8";
	int maxSize = 10 * 1024 * 1024; 
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String qid = "";
	String qcontent = "";
	
	File file = null;
		
	String subject = multi.getParameter("subject");
	String dateNow = multi.getParameter("dateNow");
	String thumbnail = multi.getFilesystemName("thumbnail1");	// 업로드된 파일명
	String thumbnail2 = multi.getParameter("thumbnail2");		// input class="upload-name"의 value(기존 이미지에서 변경하지않을 때의 로직을 위한 코드)
	%>
	<script type="text/javascript">
		alert(<%=thumbnail2%>);
	</script>
	<%
	String imgOrigin = multi.getParameter("imgOrigin");			// 이미지의 경로 및 파일명(현재 저장된 db값)
	String content = multi.getParameter("content");
	String imgOriginSub = multi.getParameter("imgOriginSub");	// 기존 이미지의 순수 파일명(db값에서 경로만 substring한 파일명)
	int num = Integer.parseInt(request.getParameter("num"));

	/*
		1.업로드 파일이 없을 경우 
		 - 1-1 기존 게시물 그대로 사용할 경우 => no touch
		 - 1-2 기존 게시물이 없을 경우  => no touch
		 - 1-3 기존 게시물은 있었는데 없애는 경우 => 제거
		2. 업로드 파일 있을 경우 체크박스 상관없이 그리고 기존 파일 상관 없이 무조건 업로드
	*/
	
	// 썸네일 null or 변경하지 않을 시에는 update 적용 x
	String sql = "UPDATE board SET modified_day=?, content=?, ip=?, subject=? where num = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, dateNow);
	pstmt.setString(2, content);
	pstmt.setString(3, ipAddress);
	pstmt.setString(4, subject);
	pstmt.setInt(5, num);
	pstmt.executeUpdate();
	pstmt.close();
	
	// 2. 업로드 파일 있을 경우 체크박스 상관없이 그리고 기존 파일 상관 없이 무조건 업로드
	if(thumbnail != null && thumbnail != ""){	
		String imgPath = "./image/qna/";
		String realThumb = imgPath+thumbnail;
		String sql2 = "UPDATE board SET thumbnail = ? where num = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setString(1, realThumb);
		pstmt.setInt(2, num);
		pstmt.executeUpdate();
		
	//1-3 기존 게시물은 있었는데 없애는 경우
	}else if(thumbnail == null && imgOrigin != null && imgOrigin != "" && thumbnail2.equals("")){	
		String sql2 = "UPDATE board SET thumbnail = null where num = ?";
		pstmt = conn.prepareStatement(sql2);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
	}
	if(imgOriginSub!=null || imgOriginSub!=""){	// 기존 이미지가 있어야하고, 
		File FileList = new File(realFolder);

		// 해당 폴더의 전체 파일 배열화
		String fileList[] = FileList.list();

		// 전체 파일
		for (int i = 0; i < fileList.length; i++) {
			// 파일명 조회
			String fileName = fileList[i];
			
			// 바꾸기 전 이미지명과 일치한 이미지를 찾아 삭제
			if (fileName.equals(imgOriginSub)) {
				File deleteFile = new File(realFolder + "\\" + fileName);
				String s = deleteFile.getName();
			
	            Thread.sleep(50);	// 파일을 삭제하려고 하니 파일은 존재하는데 파일 디스크립터를 이미 사용 중이여서 삭제 불가능으로 추정.. 해서 스레드 일시중단 시키고 삭제 진행
				deleteFile.delete();
				break;
			}
		}
	}
	%>
	<script type="text/javascript">
		alert("게시글 변경에 성공했습니다.");
		location.href = "qna.jsp?pg=<%=pg%>";
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