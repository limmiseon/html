<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>update</title>
</head>
<body>
	<%
	  Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
   	Date nowTime = new Date();
   	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
   	
		String id = request.getParameter("id");
		String inStock = request.getParameter("inStock");
		String modifyDate = sf.format(nowTime);
		
		stmt.executeUpdate("UPDATE InventoryStatus SET p_inStock = " + inStock + 
				", p_stockReg = '" + modifyDate + "' WHERE ID = " + id);
		
		response.sendRedirect("oneView.jsp?key=" + id);
	%>
</body>
</html>