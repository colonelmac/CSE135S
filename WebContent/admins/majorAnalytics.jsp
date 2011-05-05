<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="CSE135S.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Major Analytics</title>
<link type="text/css" rel="stylesheet" href="../styles/stylesheet.css" />

</head>
<body>

<h2>Major Analytics</h2>

<div>

<table>
	<thead>
		<th>Degree Discipline</th>
		<th>Applicant Count</th>
	</thead>
	<tbody>
	<%
		Class.forName("org.postgresql.Driver");
		
		Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
		"user=postgres&password=postgrespass");
		
		Statement statement = connection.createStatement();
		
		ResultSet results = statement.executeQuery("SELECT id, name, applicantcount FROM majors");
		
		while(results.next())
		{
			out.println("<tr>");
			out.println("<td><a href='applications.jsp?majorid=" + results.getInt("id") + "' >" + results.getString("name") + "</a></td>");
			out.println("<td>" + results.getInt("applicantcount") + "</td>");
			out.println("</tr>");
		}
	%>
	</tbody>
</table>

</div>

</body>
</html>