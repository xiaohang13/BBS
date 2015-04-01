<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

    
<%
	request.setCharacterEncoding("UTF-8");

	String strid = request.getParameter("id");
	String strrootid = request.getParameter("rootid");
	int id = Integer.parseInt(strid);
	int rootid = Integer.parseInt(strrootid);
%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Reply</title>
</head>
<body>

<form method="post" action="ReplyOk.jsp" autocomplete="off">
	<input name="id" type="hidden" value="<%=id %>" />
	<input name="rootid" type="hidden" value="<%=rootid %>" />
	<table border="0">
		<tr>
			<td>标题：<input name="title" type="text" size="52" id="title" /></td>
		</tr>
		<tr>
			<td>内容：<textarea name="cont" rows="5" cols="40"></textarea></td>
		</tr>
		<tr>
			<td><input name="sub" type="submit" value="提交" /></td>
		</tr>
	</table>
</form>

</body>
</html>