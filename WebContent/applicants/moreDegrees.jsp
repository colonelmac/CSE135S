<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.text.DateFormat"%>
<%@page import="org.apache.tomcat.util.http.fileupload.MultipartStream"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="CSE135S.*, support.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>More Degrees</title>
<link type="text/css" rel="stylesheet" href="../styles/stylesheet.css" />

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

<h3>Verify degrees:</h3>

<%
	if( session.getAttribute("degrees") == null )
	{
		session.setAttribute("degrees", new ArrayList<Degree>());
	}

	ArrayList<Degree> degrees = (ArrayList<Degree>)session.getAttribute("degrees");
	degrees.add( new Degree(request.getParameter("value"), Integer.parseInt(request.getParameter("graduationMonth")), 
			Integer.parseInt(request.getParameter("graduationYear")), request.getParameter("degreeTitle"), (String)session.getAttribute("universityName")));
	
	if( !request.getParameter("degreeTitle").equals("BS") && !request.getParameter("degreeTitle").equals("BA") ) {
		
		degrees.get(degrees.size()-1).specialization = request.getParameter("degreeSpecialization");
	}
	
	session.setAttribute("degrees", degrees);
%>

<form method="post" action="verifyApplication.jsp">
<div>
	<h4>Your degrees:</h4>
	<ul>
		<%
			for(Degree d : degrees) {
				
				out.println(d.toHTMLString());
			}
		%>
	</ul>
</div>

<input type="button" value="Add another Degree" onclick="redirect()" />
<input type="submit" value="Continue with Application" />
</form>

<script type="text/javascript">

	function redirect() {
		
		window.location = '/CSE135S/provideDegreesLocations.jsp';
	}

</script>
</body>
</html>