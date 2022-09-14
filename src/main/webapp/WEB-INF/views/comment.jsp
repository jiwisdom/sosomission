<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#tbl{
	border : 3px solid lightblue;
}
textarea{
	background: white;
	font-weight:bold;
	text-align :center;
}
</style>
<body>
<table id='tbl' >
<c:forEach var='list' items='${list }' varStatus = 'status'>
	<tr>
		<th>날짜</th>
		<th>${list.startDate }</th>
	</tr>
	<tr>
		<th>미션</th>
		<th>${status.count }</th>
	</tr>
	<tr>
		<th>시간</th>
		<th>${list.startTime }</th>
	</tr>
	<tr>
		<th>미션 이름</th>
		<th>${list.mission_name }</th>
	</tr>
	<tr>
		<th>후기</th>
		<th><textarea disabled>${list.comments }</textarea></th>
	</tr>
</c:forEach>	
</table>
</body>
</html>