<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
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
		String sql = "select count(*) from hubo_table;";
		ResultSet rset = stmt.executeQuery(sql);
		int isNull = 0;
		while (rset.next()) {
		isNull = rset.getInt(1);
		}
		
		if (isNull == 0) {
			response.sendRedirect("B_03_H.jsp");
		}
		
		sql = "select * from hubo_table order by id;";
		rset = stmt.executeQuery(sql);
%>

<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=100><a href="A_01_H.jsp">후보등록</a></td>
		<td width=100 bgcolor="#00ffff"><a href="B_01_H.jsp">투표</a></td>
		<td width=100><a href="C_01_H.jsp">개표결과</a></td>
	</tr>
</table>
<br>
<table cellspacing=3 width=800 border=1>
	<tr>
	<form method="post" action="B_02_H.jsp">
		<td width=200><p align=center><select name=choiceName>
<%
	while (rset.next()) {
		out.println("<option value=" + rset.getInt(1) +">" + rset.getInt(1) + "번 " +  rset.getString(2));
	}
	out.println("</select></p></td>");

    rset.close();
    stmt.close();
    conn.close();
%>
		<td width=200><p align=center><select name=choiceAge>
			<option value=1>10대
			<option value=2>20대
			<option value=3>30대
			<option value=4>40대
			<option value=5>50대
			<option value=6>60대
			<option value=7>70대
			<option value=8>80대
			<option value=9>90대
		</select></p></td>
		<td><p align=center>
		<input type=submit value="투표하기">
		</td>
	</form>
	</tr>
</table>	
</body>
</html>