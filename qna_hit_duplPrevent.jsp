<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	request.setCharacterEncoding("utf-8");
	// 쿠키 없을 때, 로그인 후에 아무 게시글에나 접속하면 조회수 증가 및 중복 증가 x. 문제는 다른 게시글에도 한 번은 찍혀야하는데 안찍힘
	// 조회수 증가 및 중복 확인 
	String num2 = request.getParameter("num");
	Cookie viewCookie=null;
	Cookie[] cookies=request.getCookies();

	System.out.println("cookie : "+cookies);


	if(cookies !=null) {

		for (int i = 0; i < cookies.length; i++) {
			//System.out.println("쿠키 이름 : "+cookies[i].getName());
	        
	        //만들어진 쿠키들을 확인하며, 만약 들어온 적 있다면 생성되었을 쿠키가 있는지 확인
			if(cookies[i].getName().equals("|"+id+"|")) {
				System.out.println("if문 쿠키 이름 : "+cookies[i].getName());
			
	        	//찾은 쿠키를 변수에 저장
				viewCookie=cookies[i];
			}
		}
		
	}else {
		System.out.println("cookies 확인 로직 : 쿠키가 없습니다.");
	}


	//만들어진 쿠키가 없음을 확인
	if(viewCookie==null) {

	  	System.out.println("viewCookie 확인 로직 : 쿠키 없당");
		
	    try {
	    
	    	//이 페이지에 왔다는 증거용(?) 쿠키 생성
			Cookie newCookie=new Cookie("|"+id+"|","readCount");
			response.addCookie(newCookie);
	        
	        //쿠키가 없으니 증가 로직 진행
			String sql = "Update board set hit=hit+1 where num = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num2);
			pstmt.executeUpdate();
	        
		} catch (Exception e) {
			System.out.println("쿠키 넣을때 오류 나나? : "+e.getMessage());
			e.getStackTrace();

		}

	//만들어진 쿠키가 있으면 증가로직 진행하지 않음
	}else {
		System.out.println("viewCookie 확인 로직 : 쿠키 있당");
		String value=viewCookie.getValue();
		System.out.println("viewCookie 확인 로직 : 쿠키 value : "+value);
	}
	//
	%>

</body>
</html>