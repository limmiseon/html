<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
<style>
	a:link{
		color : black;
		text-decoration: none;
	}
</style>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	String ckey = request.getParameter("key");
	String huboName = "";
	ResultSet rset = stmt.executeQuery("select name from hubo_table where id = " + ckey);
	while (rset.next()) {
		huboName = rset.getString(1);
	}
	
	rset = stmt.executeQuery("select a.age, ifnull((select count(*) from tupyo_table as t where t.age=a.age and t.id = " + 
	ckey +" group by t.age), 0) as cnt, ifnull((select count(*) from tupyo_table as t where t.age=a.age and t.id = " + 
	ckey + " group by t.age), 0)/(select count(*) from tupyo_table where id=" + 
	ckey +") as rate from tupyo_table_calc as a group by age;");
%>
<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=100><a href="A_01_H.jsp">후보등록</a></td>
		<td width=100><a href="B_01_H.jsp">투표</a></td>
		<td width=100 bgcolor="#00ffff"><a href="C_01_H.jsp">개표결과</a></td>
	</tr>
</table>
<h1><%=ckey%>번 <%=huboName%> 후보 득표 성향</h1>
<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=75><p align=center>연령대</p></td>
		<td width=500><p align=center>득표율</p></td>
	</tr>
<%
	int wid = 0;
	while (rset.next()) {
		double printRate = Math.round((rset.getDouble(3)*100)*100)/100.0;
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
		out.println("<td width=90><p align=center>" + rset.getInt(1)*10 + "대</p></a></td>");
		out.println("<td><p align=left><img src='bar.jpg' width=" + wid + " height=20>" + rset.getInt(2) +
			"(" + printRate + "%)</p></td>");
		out.println("</tr>");
	}
%>
</table>
</body>
</html>