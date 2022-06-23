<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>delete</title>
</head>
<body>
	<style>
	  .container {
      border: 1px black solid;
      width: 700px;
      height: 500px;
    }

		#header {
    	border-bottom: 1px black solid;
    	padding: 20px;
    	text-align: center;
    	font-size: 30px;
    }
        
		.alter {
			margin-top: 150px;
			text-align: center;
		}
	</style>
	<%
	  Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
		Statement stmt = conn.createStatement();
		
		String id = request.getParameter("key");
		String title = "";
		String imgFileName = "";
		
		ResultSet rs = stmt.executeQuery("SELECT * FROM InventoryStatus WHERE id = " + id);
		while (rs.next()) {
			title = rs.getString("p_name");
			imgFileName = rs.getString("p_imagePath");
		}
		stmt.execute("DELETE FROM InventoryStatus WHERE id = " + id);
		
		String absolutePath = request.getSession().getServletContext().getRealPath("/imgFiles"); // 이미지 경로
		String filePath  = absolutePath + "\\" + imgFileName; // 시스템상의 절대경로를 포함한 파일명
		File deleteImg = new File(filePath); // 삭제할 파일 객체 생성
		
		if (deleteImg.exists()) {
			deleteImg.delete(); // 파일이 존재한다면 삭제
		}
	%>	
</body>
	<div class="container">
	    <div id="header">
	      <b>(주)트와이스 재고 현황 - 상품 삭제</b>
	    </div>
	    <div class="alter">
				<h1>[<%= title %>] 상품이 삭제되었습니다.</h1><br>
				<input type="button" value="재고 현황" OnClick="window.location='allView.jsp'">
			</div>
		</div>
</html>