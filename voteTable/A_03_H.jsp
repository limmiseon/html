<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<style>
	a:link{
		color : black;
		text-decoration: none;
	}
</style>
<script>
function check() {
	var charArr = fr.name.value.split('');
	
	if (charArr.length == 0) {
		alert("이름을 입력해주세요.");
		return false;
	}
	
	if (charArr.length > 5) {
		alert("이름은 5글자까지만 가능합니다.");
		return false;
	}
	
	for (var i=0; i<charArr.length; i++) {
		if (charArr[i] >= 'A' && charArr[i] <= 'z') { // 인덱스값이 영어이면
				continue;
			} else if (charArr[i] >= '\uAC00' && charArr[i] <= '\uD7A3') { // 인덱스값이 한글이면
				continue;
			} else {
				alert("이름은 한글과 영어만 입력 가능합니다.");
				return false;
			}
		return true;
	}
}
alert("후보가 등록되었습니다.");
</script>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	String cTmp = request.getParameter("name");
	String cTmpHan = new String(cTmp.getBytes("8859_1"),"utf-8");
	
	stmt.execute("insert into hubo_table(id, name) values(" +
	request.getParameter("id") + ", '" +
	cTmpHan + "');");
	
	int gihoMax=0;
		int giho = 0;
		int cnt = 0;
		
		String sql = "select max(id) from hubo_table;";
		ResultSet rset = stmt.executeQuery(sql);
		while (rset.next()) {
			gihoMax = rset.getInt(1);
		}
		
		if (gihoMax == 0) {
			giho = 1;
		} else {
			for (int i = 1; i <= (gihoMax+1); i++) {
				rset = stmt.executeQuery("select count(*) from hubo_table where id = " + i + ";");
				while (rset.next()) {
				cnt = rset.getInt(1);
				}
				if (cnt == 0) {
					giho = i;
					break;
				}
			}
		}
		
		sql = "select * from hubo_table order by id;";
		rset = stmt.executeQuery(sql);
%>
<table cellspacing=3 width=800 border=1>
	<tr>
		<td width=100 bgcolor="#00ffff"><a href="A_01_H.jsp">후보등록</a></td>
		<td width=100><a href="B_01_H.jsp">투표</a></td>
		<td width=100><a href="C_01_H.jsp">개표결과</a></td>
	</tr>
</table>
<br>
<table cellspacing=3 width=800 border=1>
<%
	while (rset.next()) {
		out.println("<tr><td>");
		out.println("<form method='post' action='A_02_H.jsp'>");
		out.println("&ensp;기호: <input type='text' name='id' value='" + rset.getInt(1) + "' readonly>&emsp;&emsp;이름 : <input type='text' name='name' value='" + rset.getString(2) + "' readonly>&ensp;<input type='submit' value='삭제'>");
		out.println("</form></td></tr>");
	}
	
	out.println("<tr><td>");
	out.println("<form method='post' action='A_03_H.jsp' form name='fr' onsubmit='return check();'>");
	out.println("&ensp;기호: <input type='text' name='id' value='" + giho +"' readonly>&emsp;&emsp;이름 : <input type='text' name='name' value=''>&ensp;<input type='submit' value='추가'>");
	out.println("</form></td></tr>");
	
    rset.close();
    stmt.close();
    conn.close();
%>
</body>
</html>