package CSE135S;

import java.sql.*;
import java.util.*;

public class SQL {

	
	public static Vector<String> getCountries() throws SQLException
	{
		
		Vector<String> countries = new Vector<String>();
		
		try
		{
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=derrick25");
			
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

	public static Vector<String> getStates() throws SQLException
	{
		Vector<String> states = new Vector<String>();
		
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=derrick25");
			
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

	public static Vector<String> getMajors() throws SQLException
	{
		Vector<String> majors = new Vector<String>();
		
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=derrick25");
			
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
		try
		{	
			Class.forName("org.postgresql.Driver");
			
			Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=derrick25");
			
			Statement statement = connection.createStatement();
			
			ResultSet results = statement.executeQuery("SELECT id FROM " + table + " where name='" + name + "'");
			
			return results.getInt(0);
		}
		catch(SQLException ex)
		{
			//do something?	
		}
		catch (ClassNotFoundException e)
		{
			//do something?	
		}
		
		return 0; 
	}
}
