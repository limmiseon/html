<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view</title>
</head>
<body>
  <form method="post" name="fm">
    <table width=650 border=1 cellspacing=0 cellspacing=5>
      <%
      Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
	  	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
  		Statement stmt = conn.createStatement();
  		
  		String id = request.getParameter("key");
  		ResultSet rs = stmt.executeQuery("SELECT * FROM gongji WHERE id = " + id);
  		while (rs.next()) {
  			out.println("<tr>");
  			out.println("<td><b>번호</b></td>");
  			out.println("<td>" + rs.getInt(1) + "</td>");
  			out.println("</tr>");
  			
  			out.println("<tr>");
  			out.println("<td><b>제목</b></td>");
  			out.println("<td>" + rs.getString(2) + "</td>");
  			out.println("</tr>");
  			
  			out.println("<tr>");
  			out.println("<td><b>일자</b></td>");
  			out.println("<td>" + rs.getString(3) + "</td>");
  			out.println("</tr>");
  			
  			out.println("<tr>");
  			out.println("<td><b>내용</b></td>");
  			out.println("<td>" + rs.getString(4) + "</td>");
  			out.println("</tr>");
  		}
      %>
    </table>
    <table width=650>
      <tr>
        <td width=600></td>
        <td><input type="button" value="목록" OnClick="window.location='list.jsp'"></td>
        <%
        out.println("<td><input type='button' value='수정' OnClick=\"window.location='modify.jsp?key=" + id + "'\"></td>");
        %>
      </tr>
    </table>
  </form>


</body>
</html>