<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상세 화면</title>
</head>
<body>
  <style>
    .container {
      border: 1px black solid;
      width: 700px;
    }

    .productTable {
    	border: 1px black solid;
      cellpadding: 2px;
      width: 600px;
      border-collapse:collapse;
      margin-top: 20px;
      margin-bottom: 10px;
      margin-left:auto; 
    	margin-right:auto;
    }
    
    .productTable tr td {
    	border: 1px black solid;
			padding: 7px;
    }
    
    .regButton {
    	width: 600px;
    	margin-bottom: 50px;
      margin-left:auto; 
    	margin-right:auto;
    }

    #header {
    	border-bottom: 1px black solid;
    	padding: 20px;
    	text-align: center;
    	font-size: 30px;
    }
    
    .imgText {
    	height: 200px;
      /* 글자 상하 지정 */
    	vertical-align: top;
    }

    .imgAlign {
      align: center;
    }
    
    .imgFile {
    	width: 300px;
    	height: 200px;
    }
  </style>
  <div class="container">
    <div id=header>
      <b>(주)트와이스 재고 현황 - 상품 상세</b>
    </div>
    <div>
      <table class="productTable">
      <%
        Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
        Statement stmt = conn.createStatement();
        
        String id = request.getParameter("key");
        ResultSet rs = stmt.executeQuery("SELECT * FROM InventoryStatus WHERE id = " + id);
       	String title = "";
        while (rs.next()) {
        	title = rs.getString(2);
          out.println("<tr>");
          out.println("<td width=150>상품 번호</td>");
          out.println("<td>" + rs.getInt(1) + "</td>");
          out.println("</tr>");

          out.println("<tr>");
          out.println("<td width=150>상품명</td>");
          out.println("<td>" + rs.getString(2) + "</td>");
          out.println("</tr>");

          out.println("<tr>");
          out.println("<td width=150>재고 현황</td>");
          out.println("<td>" + rs.getInt(3) + "</td>");
          out.println("</tr>");

          out.println("<tr>");
          out.println("<td width=150>상품 등록일</td>");
          out.println("<td>" + rs.getString(4) + "</td>");
          out.println("</tr>");

          out.println("<tr>");
          out.println("<td width=150>재고 등록일</td>");
          out.println("<td>" + rs.getString(5) + "</td>");
          out.println("</tr>");

          out.println("<tr>");
          out.println("<td width=150>상품 설명</td>");
          out.println("<td>" + rs.getString(6) + "</td>");
          out.println("</tr>");
          out.println("<tr>");
          out.println("<td class=imgText>상품 사진</td>");
          out.println("<td><img class='imgFile' src='/InventoryStatus/imgFiles/" +
          rs.getString(7) + "' onerror=\"this.style.display='none';\"/></td>");
          out.println("</tr>");
          
        }
      %>
    </table>
    <table class="regButton">
    	<tr>
    		<td width=430></td>
    		<td><input type="button" value="상품 삭제" OnClick="window.location='delete.jsp?key=<%=id%>'"></td>
    		<td><input type="button" value="재고 수정" OnClick="window.location='modify.jsp?key=<%=id%>'"></td>
    	</tr>
    </table>
</body>
</html>