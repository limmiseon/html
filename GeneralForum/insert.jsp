<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
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
      fm.action = "write.jsp";
      fm.submit();
    }
  </script>
  <%
	  Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		Date nowTime = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
  %>
  <form method="post" name="fm">
    <table width="650" border="1" cellspacing="0" cellspacing="5">
      <tr>
        <td><b>번호</b></td>
        <td>신규(insert) <input type="hidden" name="id" value="INSERT"></td>
      </tr>
      <tr>
        <td><b>제목</b></td>
        <td><input type="text" name="title" size="70" maxlength="70" required></td>
      </tr>
      <tr>
        <td><b>일자</b></td>
        <td><%= sf.format(nowTime) %></td>
      </tr>
      <tr>
        <td>내용</td>
        <td><textarea name="content" cols="70" rows="60"></textarea></td>
      </tr>
    </table>
    <table width=650>
      <tr>
      <td width=600></td>
      <td><input type="button" value="취소" OnClick="window.location='list.jsp'"></td>
      <td><input type="button" value="쓰기" OnClick="submitForm('write')"></td>
      </tr>
    </table>
  </form>
</body>
</html>