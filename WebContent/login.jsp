<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Login</title>
</head>
<body>

		<form name="login" method="post" action="j_security_check">
			<table>
				<th>
					Please Login
				</th>
				<tr>
					<td>Username</td>
					<td>
						<input maxlength="20" size="12" name="j_username" type="text"/>
					</td>
				</tr>
				<tr>
					<td>Password</td>
					<td>
						<input maxlength="20" size="12" name="j_password" type="password"/>
					</td>
				</tr>
			</table>
			<input type="submit" value="Login"/>
		</form>

</body>
</html>