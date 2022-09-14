<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
* {
	text-align: center;
}

* {
	text-align: center;
}

h1 {
	background-color: lightblue;
}

#tbl {
	margin: auto;
}

#title {
	border: 3px solid lightblue;
	width: 500px;
	font-size: 20px;
	outline: lightblue;
}

textarea {
	border: 3px solid lightblue;
	width: 500px;
	height: 400px;
	overflow: auto;
	font-size: 20px;
	outline: lightblue;
}

input[type=text] {
	width: 500px;
	font-size: 20px;
}

button {
	background-color: transParent;
	width: 100px;
	height: 50px;
	border: 2px solid lightblue;
	border-radius: 20px;
	font-size: large;
}

button:hover {
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		$("#suggest").click(function() {
			$.ajax({
				url : "suggestMission",
				type : "get",
				data : {
					title : $("#title").val(),
					mission : $("#suggest_mission").val()
				},
				datType : "text",
				success : function(data) {
					alert(data);
					$(location).attr("href", "showMySuggestion");

				}
			})
		})
	})
</script>
<body>

	<jsp:include page="userHeader.jsp" />
	<h1>미션 제안서</h1>
	<br>
	<table id='tbl'>
		<tr>
			<th><input type='text' id='title' placeholder='제목을 입력하세요.'></th>
		</tr>
		<tr>
			<th><textarea id='suggest_mission'></textarea></th>
		</tr>
		<tr>
			<th><button id='suggest'>전송</button></th>
		</tr>
	</table>
</body>
</html>