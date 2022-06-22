<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pageView</title>
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
    	border:1px red black;
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
    
    a:link{text-decoration: none; color : black;}
		a:visited{color : black;}
		a:hover{text-decoration: underline;}
		
  </style>
  <div class="container">
    <div id=header>
      <b>(주)트와이스 재고 현황 - 전체 현황</b>
    </div>
    <div>
      <table class="productTable">
        <tr>
          <td width=50>상품번호</td>
          <td width=70>상품명</td>
          <td width=70>현재 재고수</td>
          <td width=70>재고 파악일</td>
          <td width=70>상품 등록일</td>
        </tr>
        <%
        String ckey = request.getParameter("key");
				int calc_key = Integer.parseInt(ckey);
				if (calc_key < 0) {
					calc_key = 0;
				}
			    String sql = "SELECT * FROM InventoryStatus as a limit " + calc_key + ", 20;";
			    Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
			    Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
					Statement stmt = conn.createStatement();
    	
		    	ResultSet rs = stmt.executeQuery(sql);
		    	
					while (rs.next()) {
						out.println("<tr>");
						out.println("<td width=50><a href='oneView.jsp?key=" + rs.getInt(1) + "'>" + rs.getInt(1) + "</a></td>");
						out.println("<td width=70><a href='oneView.jsp?key=" + rs.getInt(1) + "'>" + rs.getString(2) + "</a></td>");
						out.println("<td width=70>" + rs.getInt(3) + "</td>");
						out.println("<td width=70>" + rs.getString(4) + "</td>");
						out.println("<td width=70>" + rs.getString(5) + "</td>");
						out.println("</tr>");
					}
		    %>
      </table>
      <table class="regButton">
		    <tr>
		      <td width=550>
		      <%
						int cnt=0, total_pages=0, posts_perPage=20, current_page=0;
						double page_mod=0; int page_quo=0;
						
						rs = stmt.executeQuery("select count(*) from InventoryStatus;");
						while (rs.next()) {
							cnt=rs.getInt(1);
						}
						
						rs.close();
						stmt.close();
						conn.close();
						
						page_quo = (cnt / posts_perPage);
						page_mod = (cnt % posts_perPage);
						
						int maxKeyValue = (cnt/posts_perPage) * posts_perPage;
						
						if (page_mod == 0) {
							total_pages = (int) page_quo;
							maxKeyValue -= posts_perPage;
						} else {
							total_pages = (int) (page_quo + 1);
						}

						if (calc_key > maxKeyValue) {
							calc_key = maxKeyValue;
						}
						
						int key_value = (calc_key/200) * 200;
						int key_page = (key_value/200) * 10;
						current_page = (calc_key/posts_perPage)+1;
						
						out.println("<p align=center><a href='pageView.jsp?key=" + (key_value-posts_perPage) + "'><font size='5'><b>&lt;</b></font></a>");
						
						if (cnt <= posts_perPage) {
							out.println("<a href='pageView.jsp?key=" + key_value + "'><font size='6'><b>" + 1 +"</b></font></a>");
						} else {
							for (int i=1; i<11; i++) {
								if ((key_page+i) > total_pages) {
									break;
								}
								
								if ((key_page+i) == (current_page)) {
									out.println("<a href='pageView.jsp?key=" + key_value + "'><font size='6'><b>" + (key_page+i) +"</b></font></a>");
								} else {
									out.println("<a href='pageView.jsp?key=" + key_value + "'><font size='5'><b>" + (key_page+i) +"</b></font></a>");
								}
								key_value += posts_perPage;
							}
						}
						
						if (key_value >= maxKeyValue) {
							out.println("<a href='pageView.jsp?key=" + maxKeyValue + "'><font size='5'><b>&gt;</b></font></a>");
						} else {
							out.println("<a href='pageView.jsp?key=" + (key_value) + "'><font size='5'><b>&gt;</b></font></a>");
						}
		      %>
		      </td>
		      <td><input type="button" value="신규 등록" OnClick="window.location='insert.jsp'"></td>
		    </tr>
		  </table>
    </div>
  </div>
</body>
</html>