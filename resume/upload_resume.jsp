<%@ page contentType="text/html;charset=utf-8" session="true" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,
                   com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                   java.io.File" %>
<html>
<body>                  
<% 
	session.setAttribute("login_id", "godong9");
	session.setAttribute("login_name", "고동현");
	session.setAttribute("login_nickname", "godong9");
	
	session.setAttribute("page_status", "resume");

	String savePath=application.getRealPath("/picture");
	int sizeLimit = 10 * 1024 * 1024 ; 
	
	String id = (String)session.getAttribute("login_id");
	System.out.println(id);

	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());  

	File file = multi.getFile("image_file"); 
	String fileName=file.getName(); 
	out.println(fileName);

	String realFileName = id + fileName.substring(fileName.lastIndexOf(".")); 
	File oldFile = new File(savePath +"/"+ fileName);
	File newFile = new File(savePath +"/"+ realFileName); 
	if( newFile.exists() ) 
		newFile.delete();
	oldFile.renameTo(newFile); // 파일명 변경

	response.sendRedirect("main.jsp");
%>
</body>
</html>
