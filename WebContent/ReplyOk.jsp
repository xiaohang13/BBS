<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");

	String strid = request.getParameter("id");
	String strrootid = request.getParameter("rootid");
	String title = request.getParameter("title");
	String cont = request.getParameter("cont");
	cont = cont.replaceAll("\n", "<br>");
	int id = Integer.parseInt(strid);
	int rootid = Integer.parseInt(strrootid);
	
	out.println(strid + "   " + strrootid + "    " + title + "     " + cont);
%>

<%@page import="java.sql.*" %>
    
    
<%
	Connection conn = null;
	PreparedStatement ptmt = null;
	Statement stmt = null;
	ResultSet res = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/bbs?user=root&password=root");
		
		conn.setAutoCommit(false);
		
		// 新插入的回复总是为叶子节点 
		String sql = "insert into article values(null, ?, ?, ?, ?, now(), 0)";
		ptmt = conn.prepareStatement(sql);
		ptmt.setInt(1, id);
		ptmt.setInt(2, rootid);
		ptmt.setString(3, title);
		ptmt.setString(4, cont);
		ptmt.executeUpdate();
		
		// 考虑添加了某一条记录的回复后，其父节点不在是叶子节点，需要将isleaf字段置为1
		stmt = conn.createStatement();
		stmt.executeUpdate("update article set isleaf = 1 where id = " + id);
		
		conn.commit();
		conn.setAutoCommit(true);
		
	} catch(ClassNotFoundException e) {
		e.printStackTrace();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	
	stmt.close();
	ptmt.close();
	conn.close();
	
	response.sendRedirect("ShowArticleTree.jsp");
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ReplyOk</title>
</head>
<body>
<h3 color="blue">Submit OK!!!!</h3>
</body>
</html>