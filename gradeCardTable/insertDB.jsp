<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	int stdIdMax=0;
	int newStdId=0;
	int cnt = 0;
	
	ResultSet rset = stmt.executeQuery("select max(studentid) from examtable;");
	while (rset.next()) {
		stdIdMax = rset.getInt(1);
	}
	
	if (stdIdMax == 0) {
		newStdId = 209901;
	} else {
		for (int i = 209901; i <= (stdIdMax+1); i++) {
			rset = stmt.executeQuery("select count(*) from examtable where studentid = " + i + ";");
			while (rset.next()) {
				cnt = rset.getInt(1);
			}
			if (cnt == 0) {
				newStdId = i;
				break;
			}
		}
	}
	
	
	String cTmp = request.getParameter("name");
	String cTmpHan = new String(cTmp.getBytes("8859_1"),"utf-8");
	
	stmt.execute("insert into examtable (name, studentid, kor, eng, mat) values('" +
	cTmpHan + "', " +
	newStdId + ", " +
	request.getParameter("korean") + ", " +
	request.getParameter("english") + ", " +
	request.getParameter("mathmatic") + ");");

    stmt.close();
    conn.close();
%>
<h1><p align=center>성적입력추가완료</p></h1>
	<form method='post' action='inputForm1.html'>
	<table cellspacing=1 width=400 border=0 align=center>
	<tr>
		<td width=100></td>
		<td width=300 align=right><input type='submit' value='뒤로가기'></td>
	</tr>
	</table>

	<table cellspacing=1 width=400 border=1 align=center>
	<tr>
		<td width=100><p align=center>이름</p></td>
		<td width=300><p align=center>
		<input type='text' name='name' value='<%=cTmpHan%>' readonly></p></td>
	</tr>
		<td width=100><p align=center>학번</p></td>
		<td width=300><p align=center>
		<input type='text' name='studentid' value='<%=Integer.toString(newStdId)%>' readonly></p></td>
	</tr>
		<td width=100><p align=center>국어</p></td>
		<td width=300><p align=center>
		<input type='text' name='korean' value='<%=request.getParameter("korean")%>' readonly></p></td>
	</tr>
		<td width=100><p align=center>영어</p></td>
		<td width=300><p align=center>
		<input type='text' name='english' value='<%=request.getParameter("english")%>' readonly></p></td>
	</tr>	
		<td width=100><p align=center>수학</p></td>
		<td width=300><p align=center>
		<input type='text' name='methmatic' value='<%=request.getParameter("mathmatic")%>' readonly></p></td>
	</tr>
	</table>
</form>
</body>
</html>