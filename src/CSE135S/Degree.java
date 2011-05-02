package CSE135S;

import java.io.File;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.spi.DateFormatProvider;
import java.util.Date;

public class Degree {

	public String title;
	public String major;
	public String specialization;
	public String university;
	public java.sql.Date graduationDate;
	public int gpa; 
	public File transcript;
	
	public Degree() {
		
		
	}
	
	public Degree(String major, int month, int year, String title, String university) {
		
		this.title = title;
		this.major = major;
		this.university = university;
		this.graduationDate = new java.sql.Date(year-1900, month, 1);
	}
	 
	public int getMajorID()
	{
		return SQL.getID("majors", major);
	}
	
	public int getSpecializationID()
	{
		return SQL.getID("specializations", specialization);
	}
	
	public int getUniversityID()
	{
		return SQL.getID("universities", university);
	}
	
	public String toHTMLString()
	{
		StringBuilder sb = new StringBuilder(); 
		
		sb.append("<li>" + title + " " + major);
		
		if( specialization != null ) {
			
			sb.append(" <em>with a specialization in</em> " + specialization + " ");
		}
		
		sb.append(" <em>from</em> " + university + " <em>class of</em> " + (graduationDate.getYear() + 1900) + "</li>");
	
		return sb.toString();
	}
	
	public String toString()
	{
		StringBuilder sb = new StringBuilder(); 
		
		return sb.toString();
	}
}
