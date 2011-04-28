<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Enter name</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>

	<h3>Enter name:</h3>

	<form method="post" action="countryOfCitizenship.jsp">
	
		<ul>
			<li><label for="firstName">First name:</label><br /><input type="text" id="firstName" name="firstName" /></li>
			<li><label for="lastName">Last name:</label><br /><input type="text" id="lastName" name="lastName" /></li>
			<li><label for="middleInitial">Middle initial:</label><br /><input type="text" size="1" maxlength="1" id="middleInitial" name="middleInitial" /></li>
			<li><br /><input type="button" id="submitButton" value="Submit" /></li>
			<li id="feedback"></li>
		</ul>
		
	</form>

	<script type="text/javascript" src="http://yui.yahooapis.com/combo?3.3.0/build/yui/yui-min.js"></script>
	<script type="text/javascript">
	
		YUI().use('node', function(Y) {
			
			var elements = [ ];
			
			for(var i = 0; i < document.forms[0].elements.length; i++) {
				
				if(Y.one(document.forms[0].elements[i]).get('type') === 'text')
				{
					elements.push(document.forms[0].elements[i]); 
				}
			}
			
			Y.one('#submitButton').on('click', function() { 
						
				var isValid = false;
				
				for(var i = 0; i < elements.length; i++) {
				
					if( Y.one(elements[i]).get('value') === '' ) 
					{  
						if(Y.one('#feedback').getContent() === '')
						{
							var message = Y.Node.create('<strong><em>All fields are required.</strong></em>');
							Y.one('#feedback').appendChild(message);
						}
						
						isValid = false;
					}
					else
					{
						isValid = true;
					}
				}
				
				if(isValid)
				{
					document.forms[0].submit();
				}
			});
		});
		
	</script>
</body>
</html>