<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
</head>
<body>
<h1><center>실습데이터 입력</center></h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('나연',209901,95,100,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('정연',209902,95,95,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('모모',209903,100,100,100);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('사나',209904,100,95,90);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('지효',209905,80,100,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('미나',209906,100,100,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('다현',209907,70,70,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('채영',209908,80,75,72);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('쯔위',209909,78,79,82);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('나연',209910,80,100,100);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('나연',209911,50,75,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('모모',209912,65,80,55);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('채영',209913,100,60,75);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('다현',209914,60,80,80);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('쯔위',209915,75,80,95);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('정연',209916,45,95,100);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('지효',209917,80,100,60);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('사나',209918,90,95,80);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('다현',209919,80,60,90);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('채영',209920,100,60,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('나연',209921,65,80,70);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('모모',209922,90,60,80);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('쯔위',209923,75,70,80);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('다현',209924,85,90,85);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('사나',209925,80,80,65);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('정연',209926,70,95,100);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('채영',209927,95,70,60);");
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('지효',209928,70,80,90);");
	
	
    stmt.close();
    conn.close();
 %>	
</body>
</html>