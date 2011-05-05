<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Applicant Registration</title>
<link type="text/css" rel="stylesheet" href="styles/stylesheet.css" />

</head>
<body>

<h2>Applicant Registration</h2>

<p>
	Please register below:
</p>

<form id="form" method="" action="">
	
	<ul>
		<li><label for="username">Username</label><br />
			<input type="text" id="username" name="username" />
			<span id="usernameFeedback" style="margin-left: 5px; color: red"></span>
		</li>
		<li><label for="password">Password</label><br />
			<input type="password" id="password" name="password" />
		</li>
		<li><label for="vpassword">Verify Password</label><br />
			<input type="password" id="vpassword" name="vpassword" />
			<span id="passwordFeedback" style="margin-left: 5px; color: red"></span>
		</li>
		<li><label for="email">Email Address</label><br />
			<input type="text" id="email" name="email" />
		</li>
		<li><input type="submit" id="submit" value="submit" /></li>
		<li><span id="feedback" style="color: red"></span></li>
	</ul>
	
</form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.4/jquery.min.js"></script>
<script type="text/javascript">

	var verifyUsername = function(username) {
		
		return false;
	};
	
	var callback = function(responseText) {
		
		if(responseText.toLowerCase() !== 'true')
		{
			$('#feedback').html(responseText); 
			$('#submit').attr('disabled', false);
		}
		else
		{
			window.location = 'applicants/name.jsp';
		}
	};
	
	$('#username').change( function(e) {
		
		var result = verifyUsername(this.value);
		
		if(result === false)
		{
			$('#usernameFeedback').html('That username is unavailable.');
		}
	});

	$('#vpassword').change( function(e) {
				
		if( $('#vpassword').val() !== $('#password').val() )
		{
			$('#passwordFeedback').html('Your passwords don\'t match.');
		}
		else
		{
			$('#passwordFeedback').html('');
		}
	});
	
	$('form').submit( function(e){
		
		e.preventDefault();
		
		var isValid = true;
		
		$('input', this).each( function() {
			
			if( $(this).val() === '') 
			{
				if(isValid === true)
				{
					$('#feedback').html('All fields are required');
				}
				
				isValid = false; 
			}
		});
		
		if(isValid)
		{
			$('#feedback').html('<img src="images/loading.gif" />');
			
			$('#submit').attr('disabled', 'disabled');
			
			$.post('verifyRegistration.jsp', $(this).serialize(), callback, 'html');
		}
	});
	
</script>

</body>
</html>