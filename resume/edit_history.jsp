<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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

	request.setCharacterEncoding("utf-8"); 
	String idx = request.getParameter("idx");
	String title = request.getParameter("title");
	String term = request.getParameter("term");
	String subtitle = request.getParameter("subtitle");
	String contents = request.getParameter("summary");
	
	stmt.executeUpdate("UPDATE history SET title='"+title+"', term='"+term+"', subtitle='"+subtitle+"', contents='"+contents+"' WHERE idx='"+idx+"';"); 
	response.sendRedirect("main.jsp");
%>

