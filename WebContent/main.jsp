<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>GARMENTDYING OFFICIAL SITE</title>
<link rel="stylesheet" type="text/css" href="./stylesheet/all.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/header.css?after">
<link rel="stylesheet" type="text/css" href="./stylesheet/main.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/imageSlide.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/footer.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/header_cate.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/header_cate2.css">
<link rel="stylesheet" type="text/css" href="./stylesheet/popUp.css">
<script type="text/javascript" src="./include/jquery-1.9.0.js"></script>
</head>
<script>
    //쿠키설정    
    function setCookie( name, value, expiredays ) {
    var todayDate = new Date();
    todayDate.setDate( todayDate.getDate() + expiredays );
    document.cookie = name + '=' + escape( value ) + '; path=/; expires=' + todayDate.toGMTString() + ';'
    }

    //쿠키 불러오기
    function getCookie(name) 
    { 
        var obj = name + "="; 
        var x = 0; 
        while ( x <= document.cookie.length ) 
        { 
            var y = (x+obj.length); 
            if ( document.cookie.substring( x, y ) == obj ) 
            { 
                if ((endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                    endOfCookie = document.cookie.length;
                return unescape( document.cookie.substring( y, endOfCookie ) ); 
            } 
            x = document.cookie.indexOf( " ", x ) + 1; 
            
            if ( x == 0 ) break; 
        } 
        return ""; 
    }

    //닫기 버튼 클릭시
    function closeWin(key)
    {
        if($("#todaycloseyn").prop("checked"))
        {
            setCookie('divpop'+key, 'Y' , 1 );
        }
        $("#divpop"+key+"").hide();
    }
  
    $(function(){    
        if(getCookie("divpop1") !="Y"){
            $("#divpop1").show();
        }
    });
</script>
<body>
	<%@ include file="include/dbconn.jsp"%>
	 <form name="notice_form">
      <div id="divpop1" class="divpop">    
          <div class="title_area">
          	JSP / Mysql / Tomcat 으로 프로젝트 진행했고, Amazon Web Service 로 호스팅하여 서버 운영 중입니다.
          	<br>
          	<br>
          	현재 로그인/회원가입/회원탈퇴, 상품페이지, 관리자 전용 상품등록/수정, 장바구니, QnA게시판까지 구현 완료했습니다.
          	<br>
          	<br>관리자ID: admin <br> Password: admin 
          </div>
           <div class="button_area">
               <input type='checkbox' name='chkbox' id='todaycloseyn' value='Y'>오늘 하루 이 창을 열지 않음    
               <a href='#' onclick="javascript:closeWin(1);"><B>[닫기]</B></a>
           </div>
      </div>
  	</form>
	<div class="total-wrapper">
		<%@ include file="include/header.jsp"%>
		<div class="main-contents">
			<div id="content">
			<div class="slideshow-container">
				<div class="mySlides fade">
					<a href=""><img src="./image/main/main1.jpg"></a>
				</div>
				<div class="mySlides fade">
					<a href=""><img src="./image/main/main2.jpg"></a>
				</div>
				<div class="mySlides fade">
					<a href=""><img src="./image/main/main3.jpg"></a>
				</div>
				<a class="prev" onclick="plusSlides(-1)">&#10094;</a> <a
					class="next" onclick="plusSlides(1)">&#10095;</a>
			</div>
			<br>
			<div style="text-align: center">
				<span class="dot" onclick="currentSlide(1)"></span> <span
					class="dot" onclick="currentSlide(2)"></span> <span class="dot"
					onclick="currentSlide(3)"></span>
			</div>

			<script type="text/javascript" src="./js/imageSlide.js"></script>
			<!-- 이미지 슬라이드 스크립트 -->

			<div id="main">
				<div id="main_1200">
					<ul class="main_bn">
						<li><a href="shop_outer.jsp"><img alt=""
								src="./image/main_bn/outer.jpg"></a></li>
						<li><a href="shop_top.jsp"><img alt=""
								src="./image/main_bn/2.jpg"></a></li>
						<li><a href=""><img alt=""
								src="./image/main_bn/bottom.jpg"></a></li>
					</ul>
					<div class="item-wrap">
						<div class="item-list">
							<table>
								<!-- 상품 정보 가져오는 로직 -->
								<%
									request.setCharacterEncoding("utf-8");

								try {
									String sql = "SELECT * FROM product WHERE p_condition = ?";

									pstmt = conn.prepareStatement(sql);
									pstmt.setString(1, "new");
									rs = pstmt.executeQuery();

									int i = 0;

									while (rs.next()) {
										if (i % 4 == 0)
									out.print("<tr>");
										String p_id = rs.getString("p_id");
										String thumb = rs.getString("p_thumbnail");
										String price = rs.getString("p_unitPrice");
										String name = rs.getString("p_name");
										String desciption = rs.getString("p_description");
								%>
								<td>																		
									<ul class="item" style="font-size: 10pt;">
										<div class="box unfocused">
											<li>
												<div class="thumb">
													<a href="shop_details.jsp?p_id=<%=p_id%>"><img src="<%=thumb%>"></a>
												</div>
											</li>
											<a href="shop_details.jsp?p_id=<%=p_id%>">
											 	<li class="prd-desc"><span class="MK-product-icons"></span></li>
												<li class="prd-brand"><%=name%></li>
												<li class="prd-name"><%=desciption%></li>
												<li class="prd-price"><%=price%>원</li>
											</a>
										</div>
									</ul>
								</td>

								<%
									i++;
								if (i % 4 == 0)
									out.print("</tr>");
								}

								} catch (Exception e) {
								out.println(e.getMessage());
								} finally {
								if (rs != null)
								rs.close();
								if (pstmt != null)
								pstmt.close();
								if (conn != null)
								conn.close();
								}
								%>
							</table>
						</div>
					</div>
				</div>
				<!-- main_1200 -->
			</div>
			</div>
			<!-- main_contents -->
		</div>
	</div>
	<%@include file="include/footer.jsp"%>
</body>
</html>