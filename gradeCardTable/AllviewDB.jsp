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
<h1><center>조회</center></h1>
<%

		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		String sql = "select *, kor+eng+mat, round((kor+eng+mat)/3,1), (select count(*)+1 from examtable as b where (b.kor+b.eng+b.mat) > (a.kor+a.eng+a.mat)) from examtable as a limit 0, 10;";
		ResultSet rset = stmt.executeQuery(sql);
		
		String ckey = "0";
		int calc_key = Integer.parseInt(ckey);
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
<%
	while (rset.next()) {
		out.println("<tr>");
		out.println("<td width=50><p align=center><a href='oneviewDB.jsp?key=" + rset.getString(1) + "'> " + rset.getString(1) + "</a></p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(2)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(3)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(4)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(5)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(6)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getDouble(7)+"</p></td>");
		out.println("<td width=50><p align=center>" + rset.getInt(8)+"</p></td>");
		out.println("</tr>");
		}
		
		int cnt=0, total_pages=0, posts_perPage=10, current_page=0;
		double page_mod=0; int page_quo=0;
		rset = stmt.executeQuery("select count(*) from examtable;");
		while (rset.next()) {
			cnt=rset.getInt(1);
		}
		page_quo = (cnt / posts_perPage);
		page_mod = (cnt % posts_perPage);
		int maxKeyValue = (cnt/10)*10;
		
		if (page_mod == 0) {
			total_pages = (int) page_quo;
			maxKeyValue -= 10;
		} else {
			total_pages = (int) (page_quo + 1);
		}
%>
	</table>
<%
    rset.close();
    stmt.close();
    conn.close();
	
	if (calc_key > maxKeyValue) {
		calc_key = maxKeyValue;
	}
	int key_value = (calc_key/100)*100;
	int key_page = (key_value/100)*10;
	current_page = (calc_key/10)+1;
	
	out.println("<p align=center><a href='tenviewDB.jsp?key=" + (key_value-10) + "'><font size='5'><b>&lt;</b></font></a>");
	
	if (cnt <= posts_perPage) {
		out.println("<a href='tenviewDB.jsp?key=" + key_value + "'><font size='6'><b>" + 1 +"</b></font></a>");
	} else {
		for (int i=1; i<11; i++) {
			if ((key_page+i) > total_pages) {
				break;
			}
			
			if ((key_page+i) == (current_page)) {
				out.println("<a href='tenviewDB.jsp?key=" + key_value + "'><font size='6'><b>" + (key_page+i) +"</b></font></a>");
			} else {
				out.println("<a href='tenviewDB.jsp?key=" + key_value + "'><font size='5'><b>" + (key_page+i) +"</b></font></a>");
			}
			key_value += 10;
		}
	}
	
	if (key_value >= maxKeyValue) {
		out.println("<a href='tenviewDB.jsp?key=" + maxKeyValue + "'><font size='5'><b>&gt;</b></font></a>");
	} else {
		out.println("<a href='tenviewDB.jsp?key=" + (key_value) + "'><font size='5'><b>&gt;</b></font></a>");
	}
	
%>
   </table>
</body>
</html>