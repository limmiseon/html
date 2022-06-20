<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<%
	  Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		String id = request.getParameter("id");
		stmt.execute("DELETE FROM gongji WHERE ID = " + id + ";");

		stmt.close();
		conn.close();
		response.sendRedirect("list.jsp");
		%>

</body>
</html>