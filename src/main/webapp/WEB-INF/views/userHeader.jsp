<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
* {
	margin: 0;
	padding: 0;
}

ul li {
	list-style: none;
}

a {
	cursor : pointer;
	text-decoration: none;
	color: black;
}

header{
	width:100%;
	height: 50px;
	background: lightblue;
	color: black;
	line-height: 50px;
	 display: flex;
  	justify-content : center;
}

#menu>ul>li {
	float: left;
	width: 140px;
	position: relative;
}

#menu>ul>li>ul {
	width: 130px;
	display: none;
	position: absolute;
	font-size: 14px;
	background: skyblue;
}

#menu>ul>li:hover>ul {
	display: block;
}

#menu>ul>li>ul>li:hover {
	background: orange;
}
</style>
<script src='js/jquery.js'></script>﻿
<script>
	$(function() {
		
		let exit = sessionStorage.getItem("exit_game");
		let again = sessionStorage.getItem("again_game");

		//로그아웃
		$("#logout").click(function(){
			sessionStorage.clear();
			location.href="logout";
		
		})
		
		//미션 나가기 or 다시 안했을 때 
		if (exit == 'exit') {
			document.getElementById("mission").innerHTML = "미션 다시하기";
			document.getElementById("mission").setAttribute("id", "reStart");
			document.getElementById("reStart").style.color ="red";
			document.getElementById("reStart").addEventListener("click",function(){
				sessionStorage.setItem("fail",0);
				let today = new Date();
				let year = today.getFullYear();

				let month = ('0' + (today.getMonth() + 1)).slice(-2);
				let day = ('0' + (today.getDate())).slice(-2);

				let hours = ('0' + (today.getHours())).slice(-2);
				let minutes = ('0' + (today.getMinutes())).slice(-2);

				let date = year + '-' + month + '-' + day;
				let time = hours + ':' + minutes;

				sessionStorage.setItem("startDate", date);
				sessionStorage.setItem("startTime", time);
				location.href =again;
			})
		} else if (exit == 'no') {
			document.getElementById("mission").innerHTML = "미션 하기";
			document.getElementById("mission").setAttribute("id", "mission");
		}

		//사용자 이름 표시해 주기
		let myName = sessionStorage.getItem("name");
		$("#myName").append("" + myName + "님 안녕");

		//미션 하기
		document.getElementById("mission").addEventListener("click",function(){
			sessionStorage.setItem("fail",0);
			let today = new Date();
			let year = today.getFullYear();

			let month = ('0' + (today.getMonth() + 1)).slice(-2);
			let day = ('0' + (today.getDate())).slice(-2);

			let hours = ('0' + (today.getHours())).slice(-2);
			let minutes = ('0' + (today.getMinutes())).slice(-2);

			let date = year + '-' + month + '-' + day;
			let time = hours + ':' + minutes;

			sessionStorage.setItem("startDate", date);
			sessionStorage.setItem("startTime", time);

			console.log("안녕");
			$.ajax({
				url : "getMission",
				type : "get",
				dataType : "text",
				success : function(data) {
					location.href = data;
				}
			})
		})

		//포인트 주기
		let point = getPoint();
		document.getElementById("point").innerHTML = "포인트 "+point;
		sessionStorage.setItem("point",point);
	});
	
	function getPoint(){
		let point=0;
		$.ajax({
			url:"getPoint",
			type :"get",
			async : false,
			dataType :"text",
			success : function(data){
				point = data;
			}
		})
		return point;
	}

</script>

<body>
	
	<header>
		<div id='menu'>
		<ul>
			<li><a id='myName'></a></li>
			<li><a id="mission" href='#' >미션수행하기</a></li>
			<li><a href='myPage' id='my page'>my page</a>
				<ul>
					<li><a href='myInfo'>개인 정보</a>
					<li><a href='deleteMember' >탈퇴하기</a>
				</ul></li>
			<li><a >미션제안</a>
				<ul>
					<li><a href='showMySuggestion'>미션 제안 결과</a>
					<li><a href='missionSuggest' >미션제안</a>
				</ul></li>
			<li><a href='userMain'>MENU</a></li>
			<li id='point' ></li>
			<li><a id='logout'>로그아웃</a></li>
		</ul>
	</div>
	</header>
	
</body>
