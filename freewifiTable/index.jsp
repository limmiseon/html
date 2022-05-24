<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*" %>
<html>
<head>
<style>
	a:link{text-decoration: none;}
	a:hover{text-decoration: underline;}
</style>
</head>
<body link="#000000" vlink="#000000" align=center>
<h1 align = left>와이파이</h1>
<%
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		ResultSet rset = stmt.executeQuery("select * from freewifi_html limit 0, 10;");
%>
   <table cellspacing=1 width=1000 border=1 align=center>
   <tr>
		<td width=50><p align=center>번호</p></td>
		<td width=50><p align=center>주소</p></td>
		<td width=50><p align=center>위도</p></td>
		<td width=50><p align=center>경도</p></td>
		<td width=50><p align=center>거리</p></td>
	</tr>
<%
		while (rset.next()) {
			out.println("<tr>");
			out.println("<td><p align=center>" + rset.getInt(1) + "</p></td>");
			out.println("<td width=600><p align=center>" + rset.getString(2) + "</p></td>");
			out.println("<td width=100><p align=center>" + rset.getDouble(3)+"</p></td>");
			out.println("<td width=100><p align=center>" + rset.getDouble(4)+"</p></td>");
			out.println("<td width=200><p align=center>" + rset.getDouble(5)+"</p></td>");
			out.println("</tr>");
		}
		
      rset.close();
      stmt.close();
      conn.close();
   %>
   </table>
	<!-- 각 페이지 숫자별로 key를 다르게 전달한다 -->
    <br><br>
	<a href='tenviewWifi.jsp?key=0'><font size='6'><b>&lt;&lt;</b></font></a>
	<a href="tenviewWifi.jsp?key=0"><font size="6"><b>&lt;</b></font></a>
	<a href="tenviewWifi.jsp?key=0"><font size="7"><b>1</b></font></a>
	<a href="tenviewWifi.jsp?key=10"><font size="6"><b>2</b></font></a>
	<a href="tenviewWifi.jsp?key=20"><font size="6"><b>3</b></font></a>
	<a href="tenviewWifi.jsp?key=30"><font size="6"><b>4</b></font></a>
	<a href="tenviewWifi.jsp?key=40"><font size="6"><b>5</b></font></a>
	<a href="tenviewWifi.jsp?key=50"><font size="6"><b>6</b></font></a>
	<a href="tenviewWifi.jsp?key=60"><font size="6"><b>7</b></font></a>
	<a href="tenviewWifi.jsp?key=70"><font size="6"><b>8</b></font></a>
	<a href="tenviewWifi.jsp?key=80"><font size="6"><b>9</b></font></a>
	<a href="tenviewWifi.jsp?key=90"><font size="6"><b>10</b></font></a>
	<a href="tenviewWifi.jsp?key=100"><font size="6"><b>&gt;</b></font></a>
	<a href='tenviewWifi.jsp?key=2720'><font size='6'><b>&gt;&gt;</b></font></a>
</body>
</html>