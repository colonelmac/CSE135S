<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="CSE135S.SQL"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*, support.*, CSE135S.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Provide Degrees</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>
	<%
		session.setAttribute("universityName", request.getParameter("value"));
		
		Vector<String> majors = SQL.getMajors();
		Vector<String> specializations = SQL.getSpecializations();
		
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

<h3>Add a discipline:</h3>

<form id="form1" method="post" action="">

<div class="radioButtonList">
	
	<h4>Majors</h4>
	<ul>
	<%
		for(String m : majors) {
			
			out.println("<li><input type='radio' id='" + m + "' name='value' value='" + m + "' /><label for='" + m + "' >" + m + "</li>");
		}
	%>
		<li id="addLinkli">Can't find your major? Add it: </li>
		<li>
			<input type="hidden" name="targetTable" value="majors" />
			<label for="addMajor">Major Name:</label><br />
			<input type="text" id="addMajor" name="value" />
		</li>
	</ul>
</div>

<div class="threeColumn">

	<h4>Degree Title</h4>
	<select id="degreeTitle" name="degreeTitle">
		<option>BS</option>
		<option>BA</option>
		<option>MS</option>
		<option>PhD</option>
	</select>
	
	<div id="degreeSpecializations" style="display: none">
		<h4>Specialization</h4>
		<select id="degreeSpecialization" name="degreeSpecialization">
		<%
			for(String s : specializations) {
				
				out.println("<option>" + s + "</option>");
			}
		%>
		</select>
	</div>
</div>

<div class="threeColumn">

	<h4>Graduation Date</h4>
	
    <select id="graduationMonth" name="graduationMonth">
           <option value="1">January</option>
           <option value="2">February</option>
           <option value="3">March</option>
           <option value="4">April</option>
           <option value="5">May</option>
           <option value="6">June</option>
           <option value="7">July</option>
           <option value="8">August</option>
           <option value="9">September</option>
           <option value="10">October</option>
           <option value="11">November</option>
           <option value="12">December</option>
    </select>
    <select id="graduationYear" name="graduationYear">
    	<%
    		for(int i = 1970; i < 2020; i++) {
    			
    			out.println("<option>" + i + "</option>");
    		}
    	%>
    </select>

</div>

<div class="threeColumn">

	<h4>Graduation GPA</h4>
	<select id="graduationGPA" name="graduationGPA">
		<option>4</option>
		<option>3.7</option>
		<option>3.3</option>
		<option>3</option>
		<option>2.7</option>
		<option>2.3</option>
		<option>2</option>
		<option>1.7</option>
	</select>
</div>

<div class="threeColumn">

	<h4>Transcript</h4>
	<input type="file" id="transcript" name="transcript" />
</div>

<div class="threeColumn">
	<input type="button" id="submitButton" value="Submit" />
</div>

</form>

<script type="text/javascript" src="http://yui.yahooapis.com/combo?3.3.0/build/yui/yui-min.js"></script>
<script type="text/javascript">

	YUI().use('node', function(Y) {
		
		var verify = function(e, nodeArg) {
			
			var selected = nodeArg.selectedIndex;
			var options = nodeArg.options; 
			var node = Y.one('#degreeSpecializations');
			
			if(options[selected].value !== 'BS' && options[selected].value !== 'BA') {
				
				node.show();
			}
			else {
				
				node.hide();
			}
			
		};
		
		Y.on('change', verify, '#degreeTitle', '', document.getElementById('degreeTitle'));
	});

		YUI().use('io-form', 'node', function(Y) {
			
			
			Y.one("#submitButton").on('click', function(e) {
				
				var node = Y.one("#addMajor");
				
				if(node.get('value') !== '')
				{
					var config = {
							
							method: 'POST',
							form: {
								id: 'form1',
								useDisabled: false
							}
					};
					
					Y.io('verifyData.jsp', config);
					Y.on('io:success', function() { alert('successfully posted to verifyUniversity.jsp'); }); 
				}
				
				var form = document.getElementById('form1');
				form.action = 'moreDegrees.jsp';
				form.submit();
			});
		});
	
	</script>
	
</script>
</body>
</html>