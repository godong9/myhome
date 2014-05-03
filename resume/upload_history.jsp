<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,
                   com.oreilly.servlet.multipart.DefaultFileRenamePolicy,
                   java.io.File" %>
<%@ page import="java.sql.*" %>
<html>
<body>                  
<%
	session.setAttribute("login_id", "godong9");
	session.setAttribute("login_name", "고동현");
	session.setAttribute("login_nickname", "godong9");
 
	session.setAttribute("page_status", "history");

	String jdbcUrl = "jdbc:mysql://localhost:3306/resume";
	String dbId = "root";
	String dbPw = "dmdtka";
	Class.forName("org.mariadb.jdbc.Driver");

	Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
	Statement stmt = conn.createStatement();

	String savePath=application.getRealPath("/file");
	int sizeLimit = 50 * 1024 * 1024 ; 
	
	String id = (String)session.getAttribute("login_id");
	
	MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());  
	
	String title = multi.getParameter("title");
	String term = multi.getParameter("term");
	String subtitle = multi.getParameter("subtitle");
	String summary = multi.getParameter("summary");
	
	String fileName1=null;
	String fileName2=null;
	String fileName3=null;
	if( multi.getFile("file1") != null) {
		File file1 =  multi.getFile("file1"); 
		fileName1=file1.getName();
		String realFileName1 = id+"_"+title+ "_1_" + fileName1; 
		File oldFile1 = new File(savePath +"/"+ fileName1);
		File newFile1 = new File(savePath +"/"+ realFileName1); 
		if( newFile1.exists() ) 
			newFile1.delete();
		oldFile1.renameTo(newFile1); // 파일명 변경
		//out.println(realFileName1);
	}
	
	if( multi.getFile("file2") != null) {
		File file2 = multi.getFile("file2"); 
		fileName2=file2.getName(); 
		String realFileName2 = id+"_"+title+ "_2_" + fileName2; 
		File oldFile2 = new File(savePath +"/"+ fileName2);
		File newFile2 = new File(savePath +"/"+ realFileName2); 
		if( newFile2.exists() ) 
			newFile2.delete();
		oldFile2.renameTo(newFile2); // 파일명 변경
		//out.println(realFileName2);
	}

	if( multi.getFile("file3") != null) {
		File file3 = multi.getFile("file3"); 
		fileName3=file3.getName(); 
		String realFileName3 = id+"_"+title+ "_3_" + fileName3; 
		File oldFile3 = new File(savePath +"/"+ fileName3);
		File newFile3 = new File(savePath +"/"+ realFileName3); 
		if( newFile3.exists() )
			newFile3.delete();
		oldFile3.renameTo(newFile3); // 파일명 변경
		//out.println(realFileName3);
	}

	stmt.executeUpdate("INSERT INTO history (id,title,subtitle,term,contents,file1,file2,file3) VALUES ('"+id+"','"+title+"','"+subtitle+"','"+term+"','"+summary+"','"+fileName1+"','"+fileName2+"','"+fileName3+"');");
	response.sendRedirect("main.jsp");
%>
</body>
</html>