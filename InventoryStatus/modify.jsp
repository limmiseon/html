<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
    
    #header {
    	border-bottom: 1px black solid;
    	padding: 20px;
    	text-align: center;
    	font-size: 30px;
    }
    
    .regButton {
    	width: 600px;
    	margin-bottom: 50px;
      margin-left:auto; 
    	margin-right:auto;
    }
    
    .imgText {
    	height: 200px;
      /* 글자 상하 지정 */
    	vertical-align: top;
    }
    
    .imgFile {
    	width: 300px;
    	height: 200px;
    }
 </style>
  <script>
  	function submitForm(mode) {
  		if (fm.inStock.value == "") {
  			alert("재고 수를 입력해주세요.");
  			return;
  		}
  		
      fm.action = "update.jsp";
      fm.submit();
    }
  </script>
 
  <div class="container">
    <div id=header>
      <b>(주)트와이스 재고 현황 - 재고 수정</b>
    </div>
    <div>
    <form method="post" name="fm">
    	<table class="productTable">
	      <%
	        Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
	        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
	        Statement stmt = conn.createStatement();
	        
	        String id = request.getParameter("key");
	        ResultSet rs = stmt.executeQuery("SELECT * FROM InventoryStatus WHERE id = " + id);
	        
		    	Date nowTime = new Date();
		    	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	       
	       	while (rs.next()) {
	          out.println("<tr>");
	          out.println("<td width=150>상품 번호</td>");
	          out.println("<td><input type=\"hidden\" name=\"id\" size=\"20\" value=\"" + rs.getInt(1) + "\">" + rs.getInt(1) + "</td>");
	          out.println("</tr>");
	
	          out.println("<tr>");
	          out.println("<td>상품명</td>");
	          out.println("<td>" + rs.getString(2) + "</td>");
	          out.println("</tr>");
	
	          out.println("<tr>");
	          out.println("<td>재고 현황</td>");
	          out.println("<td><input type=\"number\" name=\"inStock\" size=\"20\"></td>");
	          out.println("</tr>");
	
	          out.println("<tr>");
	          out.println("<td>상품 등록일</td>");
	          out.println("<td>" + rs.getString(4) + "</td>");
	          out.println("</tr>");
	
	          out.println("<tr>");
	          out.println("<td>재고 등록일</td>");
	          out.println("<td>" + sf.format(nowTime) + "</td>");
	          out.println("</tr>");
	
	          out.println("<tr>");
	          out.println("<td>상품 설명</td>");
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
    	</form>
			<table class="regButton">
				<tr>
					<td width=550></td>
					<td><input type="button" value="수정 완료" OnClick="submitForm('update')"></td>
				</tr>
			</table>
  	</div>
  </div>
</body>
</html>