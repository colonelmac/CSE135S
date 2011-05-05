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

	String path = config.getServletContext().getRealPath("/data/universities.txt");
	Vector<String> universities = sp.getUniversities(path);

	Class.forName("org.postgresql.Driver");
	
	Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" +
				"user=postgres&password=");
	
	Statement statement = connection.createStatement();
	
	ResultSet results = null; 
	
	for(Object v : universities) 
	{	
		Vector tuple = (Vector)v;
		String location = tuple.get(0).toString();
		Vector<String> localUniversities = (Vector<String>)tuple.get(1);
		int id = 0;
		
		try 
		{
			results = statement.executeQuery("SELECT ID FROM locations WHERE name = '" + location + "'");
			//statement.execute("INSERT INTO locations (name, isstate) VALUES ('" + s + "', '1')");
			
			results.next();
			id = results.getInt(1);
			out.println("<li>" + location + " has ID: " + id + ".</li>");
			out.println("<ul>");
		}
		catch(SQLException ex)
		{
			String jsError = "alert(" + ex.getMessage() + ");";	
		}
		
		for(String s : localUniversities)
		{
			PreparedStatement ps = connection.prepareStatement("INSERT INTO universities (locationid, name) VALUES (?, ?)");
			
			ps.setInt(1, id);
			ps.setString(2, s);
			
			try 
			{
				ps.execute();
				
				out.println("<li>" + s + " successfully inserted. </li>");
			}
			catch(SQLException ex)
			{
				String jsError = "alert(" + ex.getMessage() + ");";	
			}	
			finally
			{
				connection.close(); 
			}
		}
		
		out.println("</ul>");


	}
	
	statement.close();
	connection.close();	

%>

SQLException: <%= sql %>

</ul>

</body>
</html>