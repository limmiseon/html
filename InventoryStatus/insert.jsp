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
    
    #preview {
    	width: 300px;
    	height: 200px;
    }
  </style>
  <script>
  	function submitForm(mode) {
      fm.action = "write.jsp";
      fm.submit();
    }
  	
  	function readURL(input) {
  	  if (input.files && input.files[0]) {
  	    var reader = new FileReader();
  	    reader.onload = function(e) {
  	      document.getElementById('preview').src = e.target.result;
  	    };
  	    reader.readAsDataURL(input.files[0]);
  	  } else {
  	    document.getElementById('preview').src = "";
  	  }
  	}
  </script>
	<%
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
	%>
  <div class="container">
		<div id=header>
			<b>(주)트와이스 재고 현황 - 상품 등록</b>
		</div>
		<div>
			<form method="post" name="fm" enctype="multipart/form-data">
				<table class="productTable">
					<tr>
						<td width=200>상품 번호</td>
						<td><input type="text" name="id" size="20"></td>
					</tr>
					<tr>
						<td>상품명</td>
						<td><input type="text" name="name" size="20"></td>
					</tr>
					<tr>
						<td>재고 현황</td>
						<td><input type="number" name="inStock" size="20"></td>
					</tr>
					<tr>
						<td>상품 등록일</td>
						<td><%= sf.format(nowTime) %></td>
					</tr>
					<tr>
						<td>재고 등록일</td>
						<td><%= sf.format(nowTime) %></td>
					</tr>
					<tr>
						<td>상품 설명</td>
						<td><input type="text" name="content" size="60" maxlength="50"></td>
					</tr>
					<tr>
						<td class=imgText>상품 사진</td>
						<td>
							<img id="preview"/>
							<input type="file" accept="image/*" name="imgFile" onchange="readURL(this);" />
						</td>
					</tr>
				</table>
			</form>
		</div>
		<div>
			<table class="regButton">
				<tr>
				<td width=550></td>
				<td><input type="button" value="완료" OnClick="submitForm('write')"></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>