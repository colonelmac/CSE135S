<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, support.*, CSE135S.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Provide Degrees</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>

<%
	Enumeration params = request.getParameterNames();

	while(params.hasMoreElements()) {
		
		String name = (String)params.nextElement();
		session.setAttribute(name, request.getParameter(name));
	}

	Vector<String> countries = null;
	
	if(Boolean.parseBoolean(session.getAttribute("domesticApplicant").toString()))
	{
		countries = SQL.getStates();
	}
	else
	{
		countries = SQL.getCountries();
	}

	countries.remove("United States");
	countries.remove("United States Virgin Islands");
	
	int size = countries.size();	//grab the number of countries
	int approx = size / 3; 			//divide up the countries
	
	int iStart = 0; 
	int iEnd = approx; 
	int jStart = iEnd;
	int jEnd = approx * 2; 
	int kStart = jEnd; 
	int kEnd = size;
	
	char currentLetter = 0;
	
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

<h3>Add a degree:</h3>

<h4>Location of university:</h4>

<div id="locations" class="threeColumn">
	<ul id="column1">
	<%
	    for(; iStart < iEnd; iStart++) {
	    	
	    	if(currentLetter == 0 || countries.get(iStart).charAt(0) > currentLetter)
	    	{
	    		currentLetter = countries.get(iStart).charAt(0);
	    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
	    	}
	        out.println("<li><a href='provideDegreesUniversities.jsp?universityLocation=" + countries.get(iStart) + "'>" + countries.get(iStart) + "</a></li>");
	    }
	%>
	</ul>
	<ul id="column2">
	<%
	    for(; jStart < jEnd; jStart++) {
	    	
	    	if(currentLetter == 0 || countries.get(jStart).charAt(0) > currentLetter)
	    	{
	    		currentLetter = countries.get(jStart).charAt(0);
	    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
	    	}
	        out.println("<li><a href='provideDegreesUniversities.jsp?universityLocation=" + countries.get(jStart) + "'>" + countries.get(jStart) + "</a></li>");
	    }
	%>
	</ul>
	<ul id="column3">
	<%
	    for(; kStart < kEnd; kStart++) {
	    	
	    	if(currentLetter == 0 || countries.get(kStart).charAt(0) > currentLetter)
	    	{
	    		currentLetter = countries.get(kStart).charAt(0);
	    		out.println("<li class='index'><strong>" + currentLetter + "</strong></li>");
	    	}
	        out.println("<li><a href='provideDegreesUniversities.jsp?universityLocation=" + countries.get(kStart) + "'>" + countries.get(kStart) + "</a></li>");
	    }
	%>
	</ul>
</div>

<div id="universities" class="threeColumn" style="dipslay: none;">

</div>

<div id="disciplines" class="threeColumn" style="display: none;">

</div>

<script type="text/javascript" src="http://yui.yahooapis.com/combo?3.3.0/build/yui/yui-min.js"></script>
<script type="text/javascript">
	
	YUI().use('node', function() {
		
		//alert('I am the mighty YUI');
	});
</script>
</body>
</html>