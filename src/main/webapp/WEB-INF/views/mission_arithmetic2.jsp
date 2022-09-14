<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
* {text-align: center;
}
body{
	background-image : url('/pictures/background_img/board.jpg');
	background-size:100%  900px;
}
header{
	color : white;
	height:90px;
	width : 100%;
	position :absolute;
}
h2,p{
	color : white;
}
#wrap{
	margin-top : 80px;
}

#time{
	margin-top : 100px;
	font-size:xx-large;
}
#wrap>div {
	color : white;
	display: inline-block;
	font-size: xxx-large;
}
#check{
	width: 70px;
	height : 35px;
	border-radius : 10%;
	border : 3px solid lightblue;
	background-color : white;
}
#check:hover{
	background-color: lightblue;
	color: white;
	outline: none;
}

#challenge {
	width: 70px;
	height: 35px;
	font-size : x-large;
}

</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		let time = 10;
		let answer = 0;

		let rdNum1 = Math.floor(Math.random() * 10) + 1;
		let rdNum2 = Math.floor(Math.random() * 10) + 1;

		let arithmeticOp = [ 'X', '/', '+', '-' ];
		let rdNum3 = Math.floor(Math.random() * 3) + 0;

		document.getElementById("arithmeticOp").innerHTML = arithmeticOp[rdNum3];

		if (arithmeticOp[rdNum3] == 'X') {
			
			if(rdNum2<rdNum1){
				rdNum2 = rdNum1 + rdNum2;
			}
			if((rdNum2/rdNum1).toFixed(0)<1){
				rdNum1 = Math.floor(Math.random() * 100) + 1;
				rdNum2 = Math.floor(Math.random() * 100) + 1;
				answer = (rdNum1 / rdNum2).toFixed(1);
			}
			
			answer =(rdNum2/rdNum1).toFixed(0);
		
		} else if (arithmeticOp[rdNum3] == '/') {
			if (rdNum1 < rdNum2) {
				rdNum1 = rdNum1 + rdNum2;
			}
			if((rdNum1 / rdNum2).toFixed(0)<0 || (rdNum1 / rdNum2).toFixed(0) ==1.0){
				rdNum1 = Math.floor(Math.random() * 100) + 1;
				rdNum2 = Math.floor(Math.random() * 100) + 1;
				answer = (rdNum1 / rdNum2).toFixed(0);
			}else
			
			answer = (rdNum1 / rdNum2).toFixed(0);
			
		} else if (arithmeticOp[rdNum3] == '+') {
			if(rdNum2<rdNum1 || rdNum2 ==rdNum1){
				rdNum2 = rdNum2+rdNum1;
			}
			answer = rdNum2-rdNum1;
		} else if (arithmeticOp[rdNum3] == '-') {
			
			if(rdNum2 > rdNum1){
				rdNum1 = rdNum1+rdNum2;
			}
			
			answer = rdNum2+rdNum1;
		}
		gameCheck(time,answer);
		document.getElementById("firstNum").innerHTML = rdNum1;
		document.getElementById("secondNum").innerHTML = rdNum2;

	});
	
	let fail=0;
	function gameCheck(time,answer){
		
		let countdown = setInterval(function() {

			document.getElementById("time").innerHTML ="타이머 :"+ time;

			if (time == 0) {
				clearInterval(countdown);
				if (answer == document.getElementById("challenge").value) {
					alert("정답!");
					document.getElementById("exit").remove();
					window.open("setComment","코멘트창","top=200px, left=650px,width=700px,height=500px");
					sessionStorage.setItem("exit_game",'no');
				} else {
					let check=confirm("정답이 아닙니다. 다시 도전하시겠습니까?");
					if (check) {
						fail++;
						sessionStorage.setItem("fail",fail);
						
						document.getElementById("challenge").value = "";
						document.getElementById("challenge").focus();

						time=5;
						gameCheck(time,answer);
					} else {
						sessionStorage.setItem("exit_game", 'exit');
						sessionStorage.setItem("again_game",
								window.location.href);
						location.href = "userMain";
					}
				}
			}
			time--;
		}, 1000);
	}
	
</script>
<body>
	<br><br>
	<header>
		<jsp:include page="exit.jsp"/><br>
		<h1>사칙연산</h1>
	</header>
	<br>
	<h2 id='time'>타이머 : 10</h2>

	<div id='wrap'>
		<div id='firstNum'></div>
		<div id='arithmeticOp'></div>
		<div>
			<input type='text' id="challenge">
		</div>
		<div id='equals'>=</div>
		<div id='secondNum'></div>
	</div>
	<p>※정답이 실수인 경우, 정수로 반올림하며 소수 부분을 남기지 않습니다.※</p>
</body>
</html>