package CSE135S;

import java.io.File;
import java.text.DateFormat;
import java.text.spi.DateFormatProvider;
import java.util.Date;

public class Degree {

	public String title;
	public String major;
	public String specialization;
	public String university;
	public Date graduationDate;
	public int gpa; 
	public File transcript;
	
	public Degree() {
		
		
	}
	
	public Degree(String major, int month, int year, String title, String university) {
		
		this.title = title;
		this.major = major;
		this.university = university;
		this.graduationDate = new Date(month+"/1/"+year);
	}
	                 
}
