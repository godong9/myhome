<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	String jdbcUrl = "jdbc:mysql://localhost:3306/resume";
	String dbId = "root";
	String dbPw = "dmdtka";
	Class.forName("org.mariadb.jdbc.Driver");

	Connection conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
	Statement stmt = conn.createStatement();

	request.setCharacterEncoding("utf-8"); 
	String id  = request.getParameter("id");
	String pw = request.getParameter("pw");

	String login_result = "";
	ResultSet rs = stmt.executeQuery("SELECT * FROM user WHERE id='"+id+"';");
	while(rs.next()){
		String tmp_pw = rs.getString("pw");
		String tmp_name = rs.getString("name");
		String tmp_nickname = rs.getString("nickname");
		if(tmp_pw.equals(pw)){
			login_result = "success";
			session.setAttribute("login_id", id);
			session.setAttribute("login_name", tmp_name);
			session.setAttribute("login_nickname", tmp_nickname);
			session.setAttribute("page_status", "resume");
		}
		else{
			login_result = "fail";
		}
	}
	out.print(login_result);
%>
