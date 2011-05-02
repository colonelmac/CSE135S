package CSE135S;

import java.sql.*;
import java.util.*;

public class SQL {

	public static boolean checkUniversity(String name)
	{	
		try
		{
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			PreparedStatement statement = connection.prepareStatement("SELECT id FROM universities WHERE LOWER(name) = ?");
			
			statement.setString(1, name.toLowerCase());
			 
			ResultSet results = statement.executeQuery();
			
			results.next();
			
			if( results.getInt(1) != 0 )
				return true; 
			
		}
		catch(SQLException ex)
		{
			//do something?
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return false; 
	}
	
	public static boolean insertUniversity(String name, String location)
	{
		int id = getID("locations", location);
		
		try
		{
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			PreparedStatement statement = connection.prepareStatement("INSERT INTO universities (name, locationid) VALUES (?, ?)");
			
			
			statement.setString(1, name);
			statement.setInt(2, id);
			 
			return statement.execute();			
		}
		catch(SQLException ex)
		{
			//do something?
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return false; 
	}
		
	public static Vector<String> getCountries()
	{
		
		Vector<String> countries = new Vector<String>();
		
		try
		{
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			ResultSet results = statement.executeQuery("SELECT name FROM locations WHERE isstate='0'");
			
			while(results.next())
			{
				countries.add(results.getString("name"));
			}
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return countries;
	}

	public static Vector<String> getStates()
	{
		Vector<String> states = new Vector<String>();
		
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			ResultSet results = statement.executeQuery("SELECT name FROM locations WHERE isstate='1'");
			
			while(results.next())
			{
				states.add(results.getString("name"));
			}
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return states;
	}

	public static Vector<String> getMajors()
	{
		Vector<String> majors = new Vector<String>();
		
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			ResultSet results = statement.executeQuery("SELECT name FROM majors");
			
			while(results.next())
			{
				majors.add(results.getString("name"));
			}
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return majors;	
	}
	
	public static int getID(String table, String name)
	{
		int id = 0; 
		
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			ResultSet results = statement.executeQuery("SELECT id FROM " + table + " WHERE name='" + name + "'");
			results.next(); 
			id = results.getInt(1);
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return id;
	}

	public static boolean incrementApplicantCount(String table, String name)
	{
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			int records = statement.executeUpdate("UPDATE " + table + " SET applicantcount = applicantcount+1 WHERE name='" + name + "'");
			
			if(records == 1)
				return true;
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return false; 
	}
	
	public static boolean derementApplicantCount(String table, String name)
	{
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
			
			Statement statement = connection.createStatement();
			
			int records = statement.executeUpdate("UPDATE " + table + " SET applicantcount = applicantcount-1 WHERE name='" + name + "'");
			
			if(records == 1)
				return true;
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return false;	
	}
}
