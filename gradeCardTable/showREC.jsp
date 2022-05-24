<meta charset="utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*, javax.sql.*, java.io.*, java.net.*" %>
<%@ page errorPage="error.jsp" %>
<html>
<head>
<script>
function submitForm(mode) {
	if(mode == "update") {
		fr.action = 'updateDB.jsp';
		fr.submit();
	} else if(mode == "delete") {
		fr.action = 'deleteDB.jsp';
		fr.submit();
	}
}

function check(mode) {
	var num1 = fr.korean.value;
	var num2 = fr.english.value;
	var num3 = fr.mathmatic.value;
	var charArr = fr.name.value.split('');
	
	if (charArr.length == 0) {
		alert("이름을 입력해주세요.");
		return;
	}
	
	if (String(num1) == "" || String(num2) == "" || String(num3) == "") {
		alert("점수를 입력해주세요.");
		return;
	}
	
	if (charArr.length > 6) {
		alert("이름은 6글자까지만 가능합니다.");
		return;
	}
	
	for (var i=0; i<charArr.length; i++) {
		if (charArr[i] >= 'A' && charArr[i] <= 'z') { // 인덱스값이 영어이면
				continue;
			} else if (charArr[i] >= '\uAC00' && charArr[i] <= '\uD7A3') { // 인덱스값이 한글이면
				continue;
			} else {
				alert("이름은 한글과 영어만 입력 가능합니다.");
				return;
			}
	}
	
	if (num1 > 100 || num1 < 0) {
		alert("점수는 0~100까지만 가능합니다.");
		fr.korean.focus();
		return;
	} else if (num2 > 100 || num2 < 0) {
		alert("점수는 0~100까지만 가능합니다.");
		fr.english.focus();
		return;
	} else if (num3 > 100 || num3 < 0) {
		alert("점수는 0~100까지만 가능합니다.");
		fr.mathmatic.focus();
		return;
	} else {
		submitForm(mode);
	}
}
</script>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/kopoctc", "root", "kopo34");
	Statement stmt = conn.createStatement();
	
	String name="", studentid="", kor="", eng="", mat="";
	
	String ctmp=request.getParameter("searchid");
	String digit = "[0-9]+";
	if (ctmp.length() == 0 || !ctmp.matches(digit)) {
		ctmp="0";
	}
	
	ResultSet rset = stmt.executeQuery("select * from examtable where studentid = " + ctmp + ";");
	
	name="해당학번없음";
	while (rset.next()) {
		name=rset.getString(1);
		studentid=Integer.toString(rset.getInt(2));
		kor=Integer.toString(rset.getInt(3));
		eng=Integer.toString(rset.getInt(4));
		mat=Integer.toString(rset.getInt(5));
	}

    rset.close();
    stmt.close();
    conn.close();
%>
<h1><p align=center>성적 조회후 정정 / 삭제</p></h1>
	<form method='post' action='showREC.jsp'>
		<table cellspacing=1 width=400 border=0 align=center>
		<tr>
			<td width=100><p align=center>조회할 학번</p></td>
			<td width=250><p align=center>&emsp;&emsp;&ensp;<input type='number' name='searchid' value='' required></p></td>
			<td width=40><input type='submit' value='조회'></td>
		</tr>
		</table>
	</form>
	
	<form method='post' form name="fr">
		<table cellspacing=1 width=400 border=1 align=center>
		<tr>
			<td width=100><p align=center>이름</p></td>
			<td width=300><p align=center>
			<input type='text' name='name' value='<%=name%>'></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>학번</p></td>
			<td width=300><p align=center>
			<input type='number' name='studentid' value='<%=studentid%>' readonly></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>국어</p></td>
			<td width=300><p align=center>
			<input type='number' name='korean' value='<%=kor%>'></p></td>
		</tr>
		<tr>
			<td width=100><p align=center>영어</p></td>
			<td width=300><p align=center>
			<input type='number' name='english' value='<%=eng%>'></p></td>
		</tr>	
		<tr>
			<td width=100><p align=center>수학</p></td>
			<td width=300><p align=center>
			<input type='number' name='mathmatic' value='<%=mat%>'></p></td>
		</tr>
		</table>
<%
	if (studentid.length() != 0) {
		out.println("<table cellspacing=1 width=400 border=0 align=center>");
		out.println("<tr>");
		out.println("<td width=200></td>");
		out.println("<td width=150><p align=right><input type=button value=\"수정\" onClick=\"check('update')\"</p></td>");
		out.println("<td width=50><p align=right><input type=button value=\"삭제\" onClick=\"submitForm('delete')\"</p></td>");
		out.println("</tr>");
		out.println("</table>");
	}
%>
</form>
</body>
</html>