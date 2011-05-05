<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Application Canceled</title>
<link type="text/css" rel="stylesheet" href="../styles/stylesheet.css" />
</head>
<body>

<%
	Enumeration attr = session.getAttributeNames();

	while(attr.hasMoreElements())
	{
		//session.removeAttribute((String)attr.nextElement());
		
		out.println(attr.nextElement());
	}
%>

<h2>Application Canceled</h2>

<p>
	None of your information has been logged. Please start over to submit an application.
</p>

<a href="name.jsp">Start Over</a>

</body>
</html>