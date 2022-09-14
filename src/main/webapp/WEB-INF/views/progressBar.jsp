<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
input[type=text]{width : 30px;}
</style>
</head>
<body>
<div id='progressBar'>
<table>
	<tr><th>${requestScope.title }</th></tr>
	<tr>
		<th>html <progress id='htmlPro' value='${requestScope.html }' max ='100'></progress> </th>
		<th>${requestScope.html }% </th>
	</tr>
	<tr>
		<th>css  <progress id='cssPro' value='${requestScope.css }' max ='100'></progress></th>
		<th> ${requestScope.css }%</th>
	</tr>
	<tr>
		<th>js <progress id='jsPro' value='${requestScope.js }' max ='100'></progress></th>
		<th> ${requestScope.js }%</th>
	</tr>
	<tr>
		<th>java <progress id='javaPro' value='${requestScope.java }' max ='100'></progress></th>
		<th> ${requestScope.java }%</th>
	</tr>
</table>
</div>
</body>
</html>