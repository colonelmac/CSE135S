<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
<body>

<% 
	try
	{
		
		Class.forName("org.postgresql.Driver");
	
		Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
		
		connection.setAutoCommit(false);
		
		PreparedStatement verifyEmail = connection.prepareStatement("SELECT COUNT(*) FROM users WHERE email = ?");
		
		verifyEmail.setString(1, (String)request.getParameter("email"));
		
		ResultSet results = verifyEmail.executeQuery();
		
		results.next();
		
		if( results.getInt(1) == 0 )
		{
			PreparedStatement createUser = connection.prepareStatement("INSERT INTO users (user_name, password, email) VALUES (?, md5(?), ?)", Statement.RETURN_GENERATED_KEYS);
			
			createUser.setString(1, (String)request.getParameter("username"));
			createUser.setString(2, (String)request.getParameter("password"));
			createUser.setString(3, (String)request.getParameter("email"));
			
			createUser.execute();
			
			results = createUser.getGeneratedKeys();
			
			results.next();
			
			createUser = connection.prepareStatement("INSERT INTO user_roles (user_ref, user_name, role) VALUES (?, ?, ?)");
			
			createUser.setInt(1, results.getInt(1));
			createUser.setString(2, (String)request.getParameter("username"));
			createUser.setString(3, "applicant");
			
			createUser.execute();
			
			out.write("true");
		}
		else
		{
			out.write("This email address has already been registered to an account.");
		}
		
		connection.commit();
		connection.close();
	}
	catch(SQLException ex)
	{
		
	}
%>

</body>
</html>