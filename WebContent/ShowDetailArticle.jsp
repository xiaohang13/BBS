<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.sql.*" %>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	Connection conn = null;
	Statement stmt = null;
	ResultSet res = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/bbs?user=root&password=root");
		stmt = conn.createStatement();
		String sql = "select * from article where id=" + id;
		/* out.println(sql); */
		res = stmt.executeQuery(sql);
	} catch(ClassNotFoundException e) {
		e.printStackTrace();
	} catch(SQLException e) {
		e.printStackTrace();
	}
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShowDetailArticle</title>
</head>
<body>

<%
if(res.next()) {
%>


<table border="1">
	<tr>
		<td><%=res.getInt("id") %></td>
	</tr>
	<tr>
		<td><%=res.getString("title") %></td>
	</tr>
	<tr>
		<td><%=res.getString("cont") %></td>
	</tr>
</table>
<a href="Reply.jsp?id=<%=res.getInt("id") %>&rootid=<%=res.getInt("rootid") %>">回复</a>

<%
res.close();
stmt.close();
conn.close();
}
%>
</body>
</html>