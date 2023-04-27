<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// RESET ANSI CODE -> \u001B[0m
    /*
    RED -> \u001B[31m
    GREEN -> \u001B[32m
    
    RED_BACKGROUND -> \u001B[41m
    GREEN_BACKGROUND -> \u001B[42m
    */
    
    String red = "\u001B[31m";
    String bgRed = "\u001B[41m";
    String resetAnsi = "\u001B[0m";

	// font color
	System.out.println(red + "hello" + resetAnsi);
	System.out.println("\u001B[31m hello \u001B[0m");
    System.out.println("hello");
    System.out.println("\u001B[32m hello \u001B[0m");
	
	// background color
	System.out.println("\u001B[41m hello \u001B[0m");
	System.out.println("hello");
	System.out.println("\u001B[42m hello \u001B[0m");
%>