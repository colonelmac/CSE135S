<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="support.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title></title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>
	<h4>Hello <%= request.getParameter("firstName") + " " + request.getParameter("lastName") + "," %></h4>
	
	<div id="progress">
		<ul>
			<li>Citizen of: <%= request.getParameter("citizenship") %></li>
			<li>Resident of: <%= request.getParameter("residence") %></li>
		</ul>
	</div>
	
	<h3>Enter your address :</h3>
	
	<% 
		String first = request.getParameter("firstName");
		String last = request.getParameter("lastName");
		String middle = request.getParameter("middleInitial");
		String citizenship = request.getParameter("citizenship");
		String residence = request.getParameter("residence");
		
		if(residence.equalsIgnoreCase("united states"))
		{
			session.setAttribute("domesticApplicant", true);
		}
	%>
	
	
	<form id="form1" name="form1" method="post" action="">
		
		<ul>
			<li><input type="hidden" id="firstName" name="firstName" value="<%= first %>" /></li>
			<li><input type="hidden" id="lastName" name="lastName" value="<%= last %>" /></li>
			<li><input type="hidden" id="middleInitial" name="middleInitial" value="<%= middle %>" /></li>
			<li><input type="hidden" id="citizenship" name="citizenship" value="<%= citizenship %>" /></li>
			<li><input type="hidden" id="residence" name="residence" value="<%= residence %>" /></li>
			<li><label for="address">Address</label><br /><input type="text" id="address" name="address" /></li>
			<li><label for="city">City</label><br /><input type="text" id="city" name="city" /></li>
			<% if(residence.equalsIgnoreCase("united states")) { out.println("<li><label for='state'>State</label><br /><input type='text' id='state' name='state' /></li>"); } %>
			<li><label for="zip">ZipCode</label><br /><input type="text" id="zipcode" name="zipcode" /></li>
			<li><label for="phone">Phone</label><br />
				<% if(!residence.equalsIgnoreCase("united states")) { out.println("<input type='text' size='2' maxlength='2' id='countrycode' name='countrycode' />"); } %>
				<input type="text" size="3" maxlength="3" id="areacode" name="areacode" />
				<input type="text" size="7" maxlength="7" id="phoneNumber" name="phoneNumber" />
			</li>
			<li><br /><input type="button" id="button" value="Submit" /></li>
		</ul>
	
	</form>
	<script type="text/javascript" src="http://yui.yahooapis.com/combo?3.3.0/build/yui/yui-min.js"></script>
	<script type="text/javascript">
	
		YUI().use('node', function(Y) {
			
			Y.one('#button').on('click', function(e) {
				
				var citizen = document.getElementById('citizenship').value;
				var form = document.forms['form1'];
				
				if( citizen === 'United States' ) {
					
					form.action = 'provideDegreesLocations.jsp';
				}
				else {
				
					form.action = 'verifyResidence.jsp';
				}
				
				form.submit();
			});
		});
	
	</script>
</body>
</html>