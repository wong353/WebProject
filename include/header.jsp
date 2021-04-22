<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div id="header_top">
	<div id="header">
		<div id="logo">
			<a href="main.jsp"><img src='./image/main_bn/logo.png' alt="logo"></a>
		</div>
		<div id="cateline">
			<nav id="topMenu">
				<ul>
					<li class="topMenuLi"><a class="menuLink" href="brand.jsp">BRAND</a></li>
					<li class="topMenuLi"><a class="menuLink" href="shop.jsp">SHOP</a>
						<ul class="submenu">
							<li><a href="shop_top.jsp" class="submenuLink">TOP</a></li>
							<li><a href="shop_bottom.jsp" class="submenuLink">BOTTOM</a></li>
							<li><a href="shop_acc.jsp" class="submenuLink">ACC.</a></li>
						</ul></li>
					<li class="topMenuLi"><a class="menuLink" href="lookbook.jsp">LOOKBOOK</a>
						<ul class="submenu"></ul></li>
					<li class="topMenuLi"><a class="menuLink" href="qna.jsp">QnA</a></li>
				</ul>
			</nav>
		</div>
		<!-- cateline -->
		<div id="logmenu">
			<nav id="topMenu2">
				<ul>
					<%
						String id = "";
					String userno = "";
					if (session.getAttribute("id") != null) {
						id = (String) session.getAttribute("id");
						userno = (String) session.getAttribute("userno");
					}
					/* 관리자 ID */
					if (id.equals("admin")) {
					%>
					<li class="topMenuUser"><b><font color="red">관리자</font> 님</b></li>
					<li class="topMenuLi2"><a class="menuLink2"
						href="userlist.jsp">USERLIST</a></li>
					<li class="topMenuLi2"><a class="menuLink2"
						href="productList.jsp">PRODUCT</a>
						<ul class="submenu2">
							<li><a href="productList.jsp" class="submenuLink2">LIST</a></li>
							<li><a href="addProduct.jsp" class="submenuLink2">ADD</a></li>
						</ul></li>
					<li class="topMenuLi2"><a class="menuLink2" href="logout.jsp">LOGOUT</a></li>

					<%
						}
					/* 일반사용자 */
					else if (!id.equals("")) {
					%>
					<li class="topMenuUser"><b><font color="red"><%=id%></font>
							님</b></li>
					<li class="topMenuLi2"><a class="menuLink2" href="logout.jsp">LOGOUT</a></li>
					<li class="topMenuLi2"><a class="menuLink2"
						href="mypage.jsp?userno=<%=userno%>">MYPAGE</a></li>
					<li class="topMenuLi2"><a class="menuLink2" href="cart.jsp">CART</a>
						<ul class="submenu"></ul></li>
					<%
						}
					/* 비회원 */
					else {
					%>
					<li class="topMenuLi2"><a class="menuLink2" href="login.jsp">LOGIN/JOIN</a></li>
					<li class="topMenuLi2"><a class="menuLink2" href="mypage.jsp">MYPAGE</a></li>
					<li class="topMenuLi2"><a class="menuLink2" href="cart.jsp">CART</a>
						<ul class="submenu"></ul></li>
					<%
						}
					%>
				</ul>
			</nav>
		</div>
		<!-- logmenu -->
	</div>
</div>
<!-- header_top -->
<div id="header_space"></div>
<!-- header_space -->
<!-- </div> center-->
