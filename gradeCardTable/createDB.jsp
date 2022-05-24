<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
</head>
<body>
<h1><p align=center>테이블만들기 OK</p></h1>
 <%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		stmt.execute("create table examtable("+
			"name varchar(20),"+
			"studentid int not null primary key,"+
			"kor int,"+
			"eng int,"+
			"mat int);");
			
      stmt.close();
      conn.close();
  %>	
</body>
</html>