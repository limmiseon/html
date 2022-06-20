<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
</head>
<body>
  <table cellspacing=1 width=600 border=1>
    <tr>
      <td width=50><p align=center>번호</p></td>
      <td width=50><p align=center>제목</p></td>
      <td width=50><p align=center>등록일</p></td>
    </tr>
    <%
    String sql = "SELECT * FROM gongji ORDER BY id DESC";
    Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
    try (Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
			Statement stmt = conn.createStatement()) {
    	
    	// id값 정리
    	stmt.execute("ALTER TABLE gongji AUTO_INCREMENT = 1;");
    	stmt.execute("set @count = 0;");
    	stmt.execute("update gongji set id = @count:=@count+1;");
    	
    	ResultSet rs = stmt.executeQuery(sql);
    	
			while (rs.next()) {
				out.println("<tr>");
				out.println("<td width=50><p align=center>" + rs.getInt(1) + "</p></td>");
				out.println("<td width=500><p align=center><a href='view.jsp?key=" + rs.getInt(1) + "'>" + rs.getString(2) + "</a></p></td>");
				out.println("<td width=100><p align=center>" + rs.getString(3) + "</p></td>");
				out.println("</tr>");
			}
			stmt.close();
			}
    %>
  </table>
  <table width=650>
    <tr>
      <td width=550></td>
      <td><input type="button" value="신규" OnClick="window.location='insert.jsp'"></td>
    </tr>
  </table>
</body>
</html>