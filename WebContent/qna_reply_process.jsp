<%@page import="java.util.Enumeration"%>
<%@page import="java.net.InetAddress"%>
<%@page import="java.io.File"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
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
	<%@include file="./include/dbconn.jsp"%>
	<%
		try {
		request.setCharacterEncoding("utf-8");
		
		String ipAddress = request.getRemoteAddr(); // 프록시서버, 클라우드, 방화벽 등의 이유로 제대로 IP 값이 나오지 않음
		if (ipAddress.equalsIgnoreCase("0:0:0:0:0:0:0:1")) { // 대소문자 구분없이 비교
			InetAddress inetAddress = InetAddress.getLocalHost(); //  InetAddress: IP 주소를 표현한 클래스(InetAddress 클래스의 생성자는 하나만 존재하지만, 특이하게 기본 생성자의 접근 제한자 default이기 때문에 new 연산자 객체를 생성할 수 없습니다. 따라서 InetAddress 클래스는 객체를 생성해 줄 수 있는 5개의 static 메서드를 제공하고 있습니다.)
			ipAddress = inetAddress.getHostAddress(); // 5가지 메서드 중 하나인 getLocalHost 사용하여 로컬 호스트의 IP 주소 반환
		}
		String absolutePath = getServletContext().getRealPath("/"); //servlet상의 절대 경로
		String encType = "utf-8";
		int maxSize = 10 * 1024 * 1024;

		MultipartRequest multi = new MultipartRequest(request, absolutePath, maxSize, encType, new DefaultFileRenamePolicy());

		File file = null;
		
		int pg = Integer.parseInt(request.getParameter("pg"));
		int num = Integer.parseInt(request.getParameter("num"));
		String subject = multi.getParameter("subject");
		String id = multi.getParameter("name");
		String name = multi.getParameter("name");
		String content = multi.getParameter("content");
		String dateNow = multi.getParameter("dateNow");
		String reply_ipAddr = ipAddress;

		Enumeration files = multi.getFileNames();

		String file1 = (String) files.nextElement();
		String thumbnail = multi.getFilesystemName(file1);
		
		int ref = 0; // 부모의 글번호를 저장하는 필드
		int ref2 = 0; // 번호 정렬 시의 구분을 위해 가족번호로 묶는 필드 (변하지 않는 상수)
		int indent = 0; // 원글의 답글인지 답글의 답글인지를 구분하는 들여쓰기 필드
		int step = 0; // 답글끼리의 출력 순서 필드
		
		String sql = "SELECT ref, ref2, indent, step FROM board WHERE num = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		rs = pstmt.executeQuery();
		if (rs.next()) {
			ref = rs.getInt(1);
			ref2 = rs.getInt(2);
			indent = rs.getInt(3);
			step = rs.getInt(4);
		}
		pstmt.close();
		
		// 원글 삭제 시, 리스트 형태 보존을 위한 parent 설정
		sql = "UPDATE board SET parent = 1 where num = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
		sql = "UPDATE board SET step = step+1 where ref = ? and step > ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, ref);
		pstmt.setInt(2, step);
		pstmt.executeUpdate();
		
			sql = "INSERT INTO board(subject, id, name, regist_day, content, thumbnail, ip, REF, REF2, INDENT, STEP)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, subject);
				pstmt.setString(2, id);
				pstmt.setString(3, name);
				pstmt.setString(4, dateNow);
				pstmt.setString(5, content);
				pstmt.setString(6, thumbnail);
				pstmt.setString(7, reply_ipAddr);
				pstmt.setInt(8, ref);
				pstmt.setInt(9, ref2);
				pstmt.setInt(10, indent + 1);
				pstmt.setInt(11, step + 1);
				pstmt.executeUpdate();
				pstmt.close();
	%>
		<script type="text/javascript">
			alert("답글을 성공적으로 작성했습니다!");
			location.href = "qna.jsp?pg=<%=pg%>";
		</script>
	<%
		
	} catch (Exception e) {
		e.printStackTrace();
		out.println(e.getMessage());
	} finally {
		if (pstmt != null)
			pstmt.close();
		if (stmt != null)
			stmt.close();
		if (rs != null)
			rs.close();
		if (conn != null)
			conn.close();
	}
	%>
	<!-- <script type="text/javascript">
   self.window.alert("입력한 글을 저장하였습니다.");
   location.href="qna.jsp";
</script> -->
</body>
</html>