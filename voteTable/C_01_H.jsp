<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<html>
<head>
<style>
	a:link{
		color : black;
	}
	
	a:visited {
	  color : black;
	}
</style>
</head>
<body>
<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=100><a href="A_01_H.jsp" style="text-decoration: none">후보등록</a></td>
		<td width=100><a href="B_01_H.jsp" style="text-decoration: none">투표</a></td>
		<td width=100 bgcolor="#00ffff"><a href="C_01_H.jsp" style="text-decoration: none">개표결과</a></td>
	</tr>
</table>
<h1>후보 별 득표율</h1>
<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		String sql = "select count(*) from tupyo_table;";
		ResultSet rset = stmt.executeQuery(sql);
		int isNull = 0;
		while (rset.next()) {
		isNull = rset.getInt(1);
		}
		
		if (isNull == 0) {
			response.sendRedirect("C_03_H.jsp");
		}
		sql = "select a.id, a.name, (select count(b.id) from tupyo_table as b where a.id=b.id), (select count(b.id) from tupyo_table as b where a.id=b.id)/(select count(*) from tupyo_table) from hubo_table as a order by a.id;";
		rset = stmt.executeQuery(sql);
%>
<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=75><p align=center>이름</p></td>
		<td width=500><p align=center>득표율</p></td>
	</tr>
<%
	int wid = 0;
	while (rset.next()) {
		double printRate = Math.round((rset.getDouble(4)*100)*100)/100.0;
		if (printRate == 100) {
			wid = 600;
		} else if (printRate > 90) {
			wid = 540;
		} else if (printRate > 80) {
			wid = 480;
		} else if (printRate > 70) {
			wid = 420;
		} else if (printRate > 60) {
			wid = 380;
		} else if (printRate > 50) {
			wid = 320;
		} else if (printRate > 40) {
			wid = 260;
		} else if (printRate > 30) {
			wid = 220;
		} else if (printRate > 20) {
			wid = 160;
		} else if (printRate > 10) {
			wid = 120;
		} else if (printRate > 5) {
			wid = 60;
		} else if (printRate > 3) {
			wid = 30;
		} else {
			wid = 0;
		}
		
		out.println("<tr>");
		out.println("<td width=90><p align=center><a href='C_02_H.jsp?key=" + rset.getInt(1) + "'>" + rset.getInt(1) + " " + rset.getString(2) + "</p></a></td>");
		out.println("<td><p align=left><img src='bar.jpg' width=" + wid + " height=20>&ensp;" + rset.getInt(3) +
			"(" + printRate + "%)</p></td>");
		out.println("</tr>");
	}
%>
</table>
</body>
</html>