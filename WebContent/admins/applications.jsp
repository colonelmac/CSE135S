<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.sql.*, CSE135S.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Applications</title>
<link type="text/css" rel="stylesheet" href="../styles/stylesheet.css" />

</head>
<body>

<h2>Applications</h2>

<%
	String majorid = null;
	
	if( request.getParameter("majorid") != null )
	{
		majorid = request.getParameter("majorid");	
	}
%>

<table>
	<thead>
		<th>FirstName</th>
		<th>LastName</th>
		<!--  
		<th>CountryCode</th>
		<th>AreaCode</th>
		<th>PhoneNumber</th>
		<th>Citizenship</th>
		<th>Residence</th>
		<th>Address</th>
		<th>City</th>
		<th>State</th>
		<th>ZipCode</th>
		<th>Status</th>
		-->
	</thead>
	<tbody>
	<%
		Class.forName("org.postgresql.Driver");
		
		Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
		"user=postgres&password=postgrespass");
		
		Statement statement = connection.createStatement();
		
		ResultSet results;
		
		if(majorid != null)
		{
			results = statement.executeQuery("SELECT firstname, lastname FROM applicants WHERE ID " + 
					"IN(SELECT applicantid FROM degrees WHERE majorid = " + majorid + ")");
		}
		else
		{
			results = statement.executeQuery("SELECT * FROM applicants");	
		}
		
		while(results.next())
		{
			out.println("<tr>");
			out.println("<td>" + results.getString("firstname") + "</td>");
			out.println("<td>" + results.getString("lastname") + "</td>");
			/*
			out.println("<td>" + results.getInt("countrycode") + "</td>");
			out.println("<td>" + results.getInt("areacode") + "</td>");
			out.println("<td>" + results.getInt("phonenumber") + "</td>");
			out.println("<td>" + results.getInt("citizenshipid") + "</td>");
			out.println("<td>" + results.getInt("residenceid") + "</td>");
			out.println("<td>" + results.getString("address") + "</td>");
			out.println("<td>" + results.getString("city") + "</td>");
			out.println("<td>" + results.getString("state") + "</td>");
			out.println("<td>" + results.getInt("zipcode") + "</td>");
			out.println("<td>" + results.getInt("statusid") + "</td>");
			out.println("</tr>");
			*/
		}
	%>
	</tbody>
</table>


</body>
</html>