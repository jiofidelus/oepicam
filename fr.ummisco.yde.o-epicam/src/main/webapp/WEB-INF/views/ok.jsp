<%@page import="fr.ummisco.oepicam.model.UserAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>That is OK for us</h1>
	
	<%	UserAuth user = (UserAuth)session.getAttribute("user");
		%>
		<h1>Informations on user are : </h1><br />
		<%=user.getLogin() %>	<br />
		<%=user.getLevel() %>	<br />
		<%=user.getPasswd() %>


<script type="text/javascript">

	<%%>
	
</script>
</body>
</html>