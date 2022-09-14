<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#exitDiv{
	position :absolute;
	width : 100%;
}

#exit {
	float : right;
	width: 100px;
	height: 35px;
	top : 0%;
	border-radius : 10%;
	border : 3px solid lightblue;
	background-color : white;
}
#exit:hover{
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}

</style>
<script src='js/jquery.js'></script>
<script>
$(function(){
	document.getElementById("exit").addEventListener("click",function(){
		sessionStorage.setItem("exit_game",'exit');
		sessionStorage.setItem("again_game",window.location.href);
		$(location).attr("href","userMain");
	})
})
	
</script>
<body>
<div id='exitDiv'><button id='exit'>나중에 하기</button></div>
</body>
</html>