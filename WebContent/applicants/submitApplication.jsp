<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@page import="java.sql.Date"%>
<%@page import="org.apache.catalina.util.Enumerator"%>
<%@page import="com.sun.jmx.snmp.Enumerated, java.util.*, CSE135S.*, java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Insert title here</title>
</head>
<body>


<ul>
<%
	Hashtable<String, Object> sessionAttributes = new Hashtable<String, Object>();
	UUID uuid = UUID.randomUUID();
	Exception exception = null;
	Enumeration<String> sesh = session.getAttributeNames(); 

	while(sesh.hasMoreElements())
	{
		
		String s = sesh.nextElement();
			
		sessionAttributes.put(s, session.getAttribute(s));
	}

%>
</ul>

<%
	try
	{
		Class.forName("org.postgresql.Driver");
	
		Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost/CSE135S?" + 
									"user=postgres&password=postgrespass");
		
		PreparedStatement statement = connection.prepareStatement("INSERT INTO Applicants (firstname, lastname, middleinitial, countrycode, areacode, phonenumber, " +
																  "citizenshipid, residenceid, state, address, city, zipcode, uuid) " + 
															      "VALUES ( ?, ?, ?, ?, ?, ?, " + 
															      			"(select id from locations where name= ?), " +
															    		  	"(select id from locations where name= ?), " +
															    		  "?, ?, ?, ?, ? ); ", Statement.RETURN_GENERATED_KEYS);
		
		statement.setString(1, (String)sessionAttributes.get("firstName"));
		statement.setString(2, (String)sessionAttributes.get("lastName"));
		statement.setString(3, (String)sessionAttributes.get("middleInitial"));
		
		if( sessionAttributes.get("countrycode") != null )
		{
			if( !sessionAttributes.get("countrycode").toString().equals("null") )
				statement.setInt(4, Integer.parseInt(sessionAttributes.get("countrycode").toString()));
		}
		else
		{
			statement.setNull(4, Types.INTEGER);
		}
		
		statement.setInt(5, Integer.parseInt((String)sessionAttributes.get("areacode")));
		statement.setInt(6, Integer.parseInt((String)sessionAttributes.get("phoneNumber")));
		
		statement.setString(7, (String)sessionAttributes.get("citizenship"));
		statement.setString(8, (String)sessionAttributes.get("residence"));
		statement.setString(9, (String)sessionAttributes.get("state"));
		
		statement.setString(10, (String)sessionAttributes.get("address"));
		statement.setString(11, (String)sessionAttributes.get("city"));
		statement.setInt(12, Integer.parseInt((String)sessionAttributes.get("zipcode")));
		
		statement.setObject(13, uuid); 
		
		statement.execute();
		
		ResultSet results = statement.getGeneratedKeys();
		results.next();
		
		for(Degree d : (ArrayList<Degree>)sessionAttributes.get("degrees"))
		{
			statement = connection.prepareStatement("INSERT INTO degrees (applicantid, title, majorid, specializationid, universityid, graduationdate, gpa)" + 
													"VALUES (?, ?, ?, ?, ?, ?, ?)");
			
			statement.setInt(1, results.getInt(1));
			statement.setString(2, d.title);
			statement.setInt(3, d.getMajorID());
			
			int spec = d.getSpecializationID();
			if( spec == 0 )
				statement.setNull(4, Types.INTEGER);
			else
				statement.setInt(4, spec);
			
			statement.setInt(5, d.getUniversityID());
			statement.setDate(6, d.graduationDate);
			statement.setInt(7, d.gpa);
			
			statement.execute();
			
			SQL.incrementApplicantCount("specializations", d.specialization);
			SQL.incrementApplicantCount("majors", d.major);
		}
	}
	catch(ClassNotFoundException ex) { exception = ex; } 
	catch(SQLException ex) { exception = ex; }
%>

<%
	if(exception != null)
		out.println("<li><b>" + exception.getMessage() +"</b></li>"); 
%>

<h3>Your application id: <%= uuid %></h3>

</ul>

</body>
</html>