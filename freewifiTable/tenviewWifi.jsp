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
		String ckey = request.getParameter("key");
		
		int calc_key = Integer.parseInt(ckey);
		if (calc_key < 0) {
			calc_key = 0;
		}
		ResultSet rset = stmt.executeQuery("select * from freewifi_html limit " + calc_key + ", 10;");
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
		
		int cnt=0, total_pages=0, posts_perPage=10, current_page=0;
		double page_mod=0;
		rset = stmt.executeQuery("select count(*) from freewifi_html;");
		while (rset.next()) {
			cnt=rset.getInt(1);
		}
		page_mod = (cnt / posts_perPage);
		
		if (page_mod == 0) {
			total_pages = (int) page_mod;
		} else {
			total_pages = (int) (page_mod + 1);
		}

      rset.close();
      stmt.close();
      conn.close();
 %>
 </table>
 <br><br>
 <%
	int maxKeyValue = (cnt/10)*10;
	if (calc_key > maxKeyValue) {
		calc_key = maxKeyValue;
	}
	int key_value = (calc_key/100)*100;
	int key_page = (key_value/100)*10;
	current_page = (calc_key/10)+1;
	
	out.println("<a href='tenviewWifi.jsp?key=" + 0 + "'><font size='6'><b>&lt;&lt;</b></font></a>");
	out.println("<a href='tenviewWifi.jsp?key=" + (key_value-10) + "'><font size='6'><b>&lt;</b></font></a>");

	
	for (int i=1; i<11; i++) {
		if ((key_page+i) > total_pages) {
			break;
		}
		
		if ((key_page+i) == (current_page)) {
			out.println("<a href='tenviewWifi.jsp?key=" + key_value + "'><font size='7'><b>" + (key_page+i) +"</b></font></a>");
		} else {
			out.println("<a href='tenviewWifi.jsp?key=" + key_value + "'><font size='6'><b>" + (key_page+i) +"</b></font></a>");
		}
		key_value += 10;
	}
	
	if (key_value >= maxKeyValue) {
		out.println("<a href='tenviewWifi.jsp?key=" + maxKeyValue + "'><font size='6'><b>&gt;</b></font></a>");
	} else {
		out.println("<a href='tenviewWifi.jsp?key=" + (key_value) + "'><font size='6'><b>&gt;</b></font></a>");
	}
	
	out.println("<a href='tenviewWifi.jsp?key=" + maxKeyValue + "'><font size='6'><b>&gt;&gt;</b></font></a>");
%>
</body>
</html>