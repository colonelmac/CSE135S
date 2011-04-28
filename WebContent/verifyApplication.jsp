<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, CSE135S.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Verify Application</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>


	<%		
		String countryCode = "";
		if(session.getAttribute("countrycode") != null) 
		{
			countryCode = session.getAttribute("countrycode").toString();
		}
	%>
	
	<h4>Hello <%= session.getAttribute("firstName") + " " + session.getAttribute("lastName") + ", " %></h4>
	
	<div id="progress">
		<ul>
			<li>Citizen of: <%= session.getAttribute("citizenship") %></li>
			<li>Resident of: <%= session.getAttribute("residence") %></li>
			<li><%= session.getAttribute("address") %></li>
			<li><%= session.getAttribute("city") + " " + session.getAttribute("state") + " " + session.getAttribute("zipcode") %></li>
			<li><%= countryCode + " " + session.getAttribute("areacode") + " " + session.getAttribute("phoneNumber") %></li>
		</ul>
	</div>

<h3>Submit Application:</h3>

<%
	ArrayList<Degree> degrees = (ArrayList<Degree>)session.getAttribute("degrees");
%>

<form method="post" action="submitApplication.jsp">
<div>
	<h4>Please Verify your Information Before Submitting your Application:</h4>
	<ul>
		<%
			out.println("<li>Domestic Applicant: " + session.getAttribute("domesticApplicant") + "</li><br />");
		
			for(Degree d : degrees) {
				
				int date = d.graduationDate.getYear() + 1900;
				out.println("<li>" + d.title + " " + d.major);
				if(d.specialization != null ) {
					
					out.println(" <em>with a specialization in</em> " + d.specialization + " ");
				}
				out.println(" <em>from</em> " + d.university + " <em>class of</em> " + date + "</li>");
			}
		%>
	</ul>
</div>

<input type="button" value="Cancel Application" />
<input type="submit" value="Submit Application" />
</form>

</body>
</html>