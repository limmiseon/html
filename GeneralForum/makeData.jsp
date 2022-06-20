<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.93:3308/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	try {
		stmt.execute("drop table gongji");
		out.println("drop table gongji OK<br>");
	} catch (Exception e) {
		out.println("drop table gongji NOT OK<br>");
		out.println(e.getLocalizedMessage());
	}
	
	stmt.execute("create table gongji (id int not null primary key auto_increment, title varchar(70), date date, content text) DEFAULT CHARSET=utf8");
	String sql = "";
	sql="insert into gongji (title, date, content) values('공지사항1', date(now()), '공지사항내용1')";
	stmt.execute(sql);
	sql="insert into gongji (title, date, content) values('공지사항2', date(now()), '공지사항내용2')";
	stmt.execute(sql);
	sql="insert into gongji (title, date, content) values('공지사항3', date(now()), '공지사항내용3')";
	stmt.execute(sql);
	sql="insert into gongji (title, date, content) values('공지사항4', date(now()), '공지사항내용4')";
	stmt.execute(sql);
	sql="insert into gongji (title, date, content) values('공지사항5', date(now()), '공지사항내용5')";
	stmt.execute(sql);

	stmt.close();
	conn.close();
	%>
</body>
</html>