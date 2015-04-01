<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="java.sql.*" %>

<%!
	String str="";
	private void tree(Connection conn, int id, int level) {
		Statement stmt = null;
		ResultSet res = null;
		String preStr = "";
		
		for(int i=0; i<level; i++) {
			preStr += "--------";
		}
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from article where pid = " + id;
			res = stmt.executeQuery(sql);
			while (res.next()) {
				str += "<tr><td>" + res.getInt("id") + "</td><td>" + preStr +
						"<a href='ShowDetailArticle.jsp?id=" + res.getInt("id") + "'>" + res.getString("title") + "</a></td></tr>";
				if(res.getInt("isleaf") != 0) {
					tree(conn, res.getInt("id"), level + 1);
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (res != null) {
					res.close();
					res = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
%>

<%
	Connection conn = null;
	PreparedStatement p = null;
	ResultSet res = null;
	// 连接数据库
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://127.0.0.1:3306/bbs?user=root&password=root";
		conn = DriverManager.getConnection(url);
		String sql = "select * from article where pid = 0";
		p = conn.prepareStatement(sql);
		res = p.executeQuery();
		while(res.next()) {
			str = "<tr><td>" + res.getInt("id") + "</td><td>" + "<a href='ShowDetailArticle.jsp?id=" + 
					res.getInt("id") + "'>" + res.getString("title") + "</a></td></tr>";
			if(res.getInt("isleaf") != 0) {
				tree(conn, res.getInt("id"), 1);
			}
		}
		/* out.println(res); */
	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	}
%>

<%
	p.close();
	res.close();
	conn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShowArticleTree</title>
</head>
<body>
<table border="1">
<%= str %>
</table>

</body>
</html>

