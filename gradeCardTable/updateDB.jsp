<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<style>
	a:link{text-decoration: none; color : black;}
	a:visited{color : black;}
	a:hover{text-decoration: underline;}
</style>
</head>
<body>
<h1><center>레코드 수정</center></h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	String cTmp = request.getParameter("name");
	String cTmpHan = new String(cTmp.getBytes("8859_1"), "utf-8");
	
	String sql = "update examtable set " +
	"name = '" + cTmpHan + "', " +
	"kor = " + request.getParameter("korean") + ", " +
	"eng = " + request.getParameter("english") + ", " +
	"mat = " + request.getParameter("mathmatic") +
	" where studentid = " + request.getParameter("studentid");
	
	stmt.executeUpdate(sql);
	ResultSet rset = stmt.executeQuery("select *, kor+eng+mat, round((kor+eng+mat)/3,1), (select count(*)+1 from examtable as b where (b.kor+b.eng+b.mat) > (a.kor+a.eng+a.mat)) from examtable as a;");
%>
	<table cellspacing=1 width=600 border=1 align=center>
	<tr>
		<td width=50><p align=center>이름</p></td>
		<td width=50><p align=center>학번</p></td>
		<td width=50><p align=center>국어</p></td>
		<td width=50><p align=center>영어</p></td>
		<td width=50><p align=center>수학</p></td>
		<td width=50><p align=center>총점</p></td>
		<td width=50><p align=center>평균</p></td>
		<td width=50><p align=center>등수</p></td>
	</tr>
	</tr>
<%
	while (rset.next()) {
		if (request.getParameter("studentid").equals(Integer.toString(rset.getInt(2)))) {
			out.println("<tr bgcolor = '#ffff00'>");
			out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + rset.getString(1) +
			"'> " + rset.getString(1) + "</a></p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("<td width=50><p align=center>" + rset.getInt(6)+"</p></td>");
			out.println("<td width=50><p align=center>" + rset.getDouble(7)+"</p></td>");
			out.println("<td width=50><p align=center>" + rset.getInt(8)+"</p></td>");
			out.println("</tr>");
		} else {
			out.println("<tr>");
			out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + rset.getString(1) +
			"'> " + rset.getString(1) + "</a></p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(2)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(3)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(4)) + "</p></td>");
			out.println("<td width=50><p align=center>" + Integer.toString(rset.getInt(5)) + "</p></td>");
			out.println("<td width=50><p align=center>" + rset.getInt(6)+"</p></td>");
			out.println("<td width=50><p align=center>" + rset.getDouble(7)+"</p></td>");
			out.println("<td width=50><p align=center>" + rset.getInt(8)+"</p></td>");
			out.println("</tr>");
		}
	}
    rset.close();
    stmt.close();
    conn.close();
%>
</table>
</body>
</html>