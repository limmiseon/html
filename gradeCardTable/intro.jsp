<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*, java.net.*" %>
<html>
<head>
</head>
<body>
	<h1><center>JSP Database 실습 1</center></h1>
<%
	String data;
	int cnt = 0;
	FileReader fl = new FileReader("/home/cnt.txt");
	StringBuffer sb = new StringBuffer();
	int ch = 0;
	while ((ch = fl.read()) != -1) {
		sb.append((char)ch);
	}
	data=sb.toString().trim().replace("\n","");
	fl.close();
	
	cnt = Integer.parseInt(data);
	cnt++;
	data = Integer.toString(cnt);
	out.println("<p align=center><br><br>현재 홈페이지 방문조회수는 [" + data + "] 입니다</br></p>");
	
	FileWriter fl2 = new FileWriter("/home/cnt.txt", false);
	fl2.write(data);
	fl2.close();
%>
</body>
</html>