<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="CSE135S.*, support.*, java.util.*, java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Insert title here</title>
</head>
<body>

<h3>Loading Countries...</h3>


<ul>

<%
	support sp = new support();
	Exception sql = null;

	String path = config.getServletContext().getRealPath("/data/specializations.txt");
	Vector<String> specializations = sp.getSpecializations(path);

	Class.forName("org.postgresql.Driver");
	
	Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" +
				"user=postgres&password=");
	
	Statement statement = connection.createStatement();
	
	ResultSet results = null; 
	
	for(String s : specializations) 
	{	
		PreparedStatement ps = connection.prepareStatement("INSERT INTO specializations (name) VALUES (?)");
		
		ps.setString(1, s);
		
		try 
		{
			ps.execute();
			
			out.println("<li>" + s + " successfully inserted. </li>");
		}
		catch(SQLException ex)
		{
			String jsError = "alert(" + ex.getMessage() + ");";	
		}	
	}
	
	statement.close();
	connection.close();	

%>

SQLException: <%= sql %>

</ul>

</body>
</html>