<%@page import="javax.servlet.annotation.WebServlet"%>
<%@page import="java.io.IOException"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
	@WebServlet("/files/*")
	public class FileServlet extends HttpServlet {
	 
	    @Override
	    protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException
	    {
	        String filename = URLDecoder.decode(request.getPathInfo().substring(1), "UTF-8");
	        File file = new File("/path/to/files", filename);
	        response.setHeader("Content-Type", getServletContext().getMimeType(filename));
	        response.setHeader("Content-Length", String.valueOf(file.length()));
	        response.setHeader("Content-Disposition", "inline; filename=\"" + file.getName() + "\"");
	        Files.copy(file.toPath(), response.getOutputStream());
	    }
	 
	}
</body>
</html>