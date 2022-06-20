<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify</title>
</head>
<body>
  <style>
    textarea {
      width: 500px;
      height: 250px;
    }
  </style>
  <script>
    function submitForm(mode) {
      if (mode == "update") {
        fm.action = "update.jsp";
      } else if (mode == "delete") {
        fm.action = "delete.jsp";
      }
      fm.submit();
    }
  </script>
  <%
	  Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		String id = request.getParameter("key");
  	ResultSet rs = stmt.executeQuery("SELECT * FROM gongji WHERE id = " + id);
  	rs.next();
  %>
  <form method="post" name="fm">
    <table width="650" border="1" cellspacing="0" cellspacing="5">
      <tr>
        <td><b>번호</b></td>
        <td><input type="hidden" name="id" value="<%= rs.getInt(1) %>" ><%= rs.getInt(1) %></td>
      </tr>
      <tr>
        <td><b>제목</b></td>
        <td><input type="text" name="title" size="70" maxlength="70" value="<%= rs.getString(2) %>"></td>
      </tr>
      <tr>
        <td><b>일자</b></td>
        <td><%= rs.getString(3) %></td>
      </tr>
      <tr>
        <td>내용</td>
        <td><textarea name="content" cols="70" rows="60"><%= rs.getString(4) %></textarea></td>
      </tr>
    </table>
    <table width=650>
      <tr>
      <td width=600></td>
      <td><input type="button" value="취소" OnClick="window.location='list.jsp'"></td>
      <td><input type="button" value="쓰기" OnClick="submitForm('update')"></td>
      <td><input type="button" value="삭제" OnClick="submitForm('delete')"></td>
      </tr>
    </table>
  </form>

</body>
</html>