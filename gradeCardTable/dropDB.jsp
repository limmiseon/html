<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
</head>
<body>
<h1><center>테이블지우기 OK</center></h1>
 <%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		stmt.execute("drop table examtable;");
			
      stmt.close();
      conn.close();
  %>	
</body>
</html>