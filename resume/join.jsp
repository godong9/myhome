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
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String nickname = request.getParameter("nickname");

	ResultSet rs = stmt.executeQuery("SELECT * FROM user WHERE id='"+id+"';");
	if(rs.next()){
		out.print("Email Overlapping!");
	}
	else{
		stmt.executeUpdate("INSERT INTO user (id,pw,name,nickname) VALUES ('"+id+"','"+pw+"','"+name+"','"+nickname+"');");
		out.print("success");
	}
%>
