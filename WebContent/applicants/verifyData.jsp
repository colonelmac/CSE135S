<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="CSE135S.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
</head>
<body>

<%

	String targetTable = request.getParameter("targetTable");
	String value = request.getParameter("value");

	if( !SQL.checkData(targetTable, value) )
	{
		if(targetTable.equalsIgnoreCase("universities"))
		{	
			SQL.insertUniversity(value, (String)session.getAttribute("universityLocation"));
		}
		
		if(targetTable.equalsIgnoreCase("majors"))
		{
			SQL.insertMajor(value);
		}
	}
%>

</body>
</html>