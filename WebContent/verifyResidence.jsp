<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Verify Residence Type</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>
	<% 
		String first = request.getParameter("firstName");
		String last = request.getParameter("lastName");
		String middle = request.getParameter("middleInitial");
		String citizenship = request.getParameter("citizenship");
		String residence = request.getParameter("residence");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String zipcode = request.getParameter("zipcode");
		String areacode = request.getParameter("areacode");
		String phoneNumber = request.getParameter("phoneNumber");
		String state = "", countrycode = "";
		
		if( request.getParameter("state") != null )
		{
			state = request.getParameter("state");
			countrycode = request.getParameter("countrycode");
		}
	%>
	
	<h4>Hello <%= first + " " + last + "," %></h4>
	
	<div id="progress">
		<ul>
			<li>Citizen of: <%= citizenship %></li>
			<li>Resident of: <%= residence %></li>
			<li><%= address %></li>
			<li><%= city + " " + state + " " + zipcode %></li>
			<li><%= countrycode + " " + areacode + " " + phoneNumber %></li>
		</ul>
	</div>
	
	<h3>Verify Residence Type:</h3>

	<form id="form1" name="form1" method="post" action="provideDegreesLocations.jsp">
		
		<ul>
			<li><input type="hidden" id="firstName" name="firstName" value="<%= first %>" /></li>
			<li><input type="hidden" id="lastName" name="lastName" value="<%= last %>" /></li>
			<li><input type="hidden" id="middleInitial" name="middleInitial" value="<%= middle %>" /></li>
			<li><input type="hidden" id="citizenship" name="citizenship" value="<%= citizenship %>" /></li>
			<li><input type="hidden" id="residence" name="residence" value="<%= residence %>" /></li>
			<li><input type="hidden" id="address" name="address" value="<%= address %>" /></li>
			<li><input type="hidden" id="city" name="city" value="<%= city %>" /></li>
			<li><input type="hidden" id="zipcode" name="zipcode" value="<%= zipcode %>" /></li>
			<li><input type="hidden" id="state" name="state" value="<%= state %>" /></li>
			<li><input type="hidden" id="countrycode" name="countrycode" value="<%= countrycode %>" /></li>
			<li><input type="hidden" id="areacode" name="areacode" value="<%= areacode %>" /></li>
			<li><input type="hidden" id="phoneNumber" name="phoneNumber" value="<%= phoneNumber %>" /></li>
			<li><label>I am a...</label><br />
				<input type="radio" id="nametrue" name="domesticApplicant" value="true" /><label for="nametrue">US Permanent Resident</label>
				<input type="radio" id="namefalse" name="domesticApplicant" value="false" checked="false" /><label for="namefalse">Non-Resident</label>
			</li>
			<li><br /><input type="submit" value="Submit" /></li>
		</ul>
	</form>

</body>
</html>