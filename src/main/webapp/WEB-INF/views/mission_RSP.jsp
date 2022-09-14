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
	cursor :pointer;
}
body{
	background-image : url('/pictures/background_img/RSP.jpg');
	background-size : cover;
}
header{
	height:90px;
	width : 100%;
	position :absolute;
}

#wrap{
	margin-top : 80px;
}
#btns {
	margin-top: 10px;
}

#btns>button {
	width: 50px;
	height: 50px;
	margin: 10px;
	background-color: lightblue;
	border-radius : 10%;
	border : none;
}

#game {
	width: 100px;
	height: 30px;
	background-color: lightblue;
	border-radius : 10%;
	border : none;
}

#btns>button:hover,#game:hover {
	background-color: grey;
}

#showBox{ position : relative;}

#one {
	border: 5px solid lightblue;
	width: 300px;
	height: 360px;
	position: absolute;
	left: 25%;
	top: 30%;
}

#two {
	border: 5px solid lightblue;
	width: 300px;
	height: 360px;
	position: absolute;
	left: 55%;
	top: 30%;
}

#result{
	border: 5px solid lightblue;
	width : 100px;
	position: absolute;
	left: 47%;
	top: 50%;	
}
.win_lose{
	font-size : xx-large;	

}
</style>
<script>
	
	document.addEventListener("DOMContentLoaded", function(){
		let fail=0;
		
		let meResult = 0;
		let systemResult = 0;
		let win = 0;
		let lose = 0;
		let chance = 10;
		
		document.querySelector("#chance").innerHTML  = "기회 : "+chance;
		let s = '<img src="img/math_img_1.jpg">';
		let r = '<img src="img/math_img_2.jpg">';
		let p = '<img src="img/math_img_3.jpg">';

		me();
		document.querySelector("#game").addEventListener("click",function(){
			system();
			chance--;
			
			if (meResult == systemResult) {
				document.querySelector("#result").innerHTML = "비겼습니다.";
			} else if (meResult == 's' && systemResult == 'r') {
				document.querySelector("#result").innerHTML = "졌습니다";
				lose = lose + 1;
			} else if (meResult == 's' && systemResult == 'p') {
				document.querySelector("#result").innerHTML = "이겼습니다";
				win = win + 1;
			} else if (meResult == 'r' && systemResult == 'p') {
				document.querySelector("#result").innerHTML = "졌습니다";
				lose = lose + 1;
			} else if (meResult == 'r' && systemResult == 's') {
				document.querySelector("#result").innerHTML = "이겼습니다";
				win = win + 1;
			} else if (meResult == 'p' && systemResult == 's') {
				document.querySelector("#result").innerHTML = "졌습니다";
				lose = lose + 1;
			} else if (meResult == 'p' && systemResult == 'r') {
				document.querySelector("#result").innerHTML = "이겼습니다";
				win = win + 1;
			}
			document.querySelector("#win").innerHTML  = win;
			document.querySelector("#lose").innerHTML  = lose;
			document.querySelector("#chance").innerHTML  = "기회 : "+chance;
			
			if(chance==0){
				fail++;
				sessionStorage.setItem("fail",fail);
				
				let check = confirm("기회 소진...다시 하시겠습니까?");
				
				if(check){
					chance=3;
					document.querySelector("#chance").innerHTML  = "기회 : "+chance;
					document.querySelector("#me").innerHTML  = "";
					document.querySelector("#system").innerHTML  = "";
					win = win;
					lose = lost;
				}else{
					sessionStorage.setItem("exit_game",'exit');
					sessionStorage.setItem("again_game",window.location.href);
					location.href="userMain";
				}
			}
			
			if (win >= 3) {
				alert("게임 위너!!");
				sessionStorage.setItem("exit_game",'no');
				document.querySelector("#exit").remove();
				window.open("setComment","코멘트창","top=200px, left=1500px,width=600px,height=500px");
			}

		});
		
		function me() {
			document.querySelector("#s").addEventListener("click",function(){
				document.querySelector("#me").innerHTML  = '<img src="img/math_img_1.jpg">';
				document.querySelector("#system").innerHTML  = "";
				document.querySelector("#result").innerHTML = "결과";
				meResult = 's';
			});

			document.querySelector("#r").addEventListener("click",function(){
				document.querySelector("#me").innerHTML  = '<img src="img/math_img_2.jpg">';
				document.querySelector("#system").innerHTML  = "";
				document.querySelector("#result").innerHTML = "결과";
				meResult = 'r';
			});

			document.querySelector("#p").addEventListener("click",function(){
				document.querySelector("#me").innerHTML  = '<img src="img/math_img_3.jpg">';
				document.querySelector("#system").innerHTML  = "";
				document.querySelector("#result").innerHTML = "결과";
				meResult = 'p';
			});
		}

		function system() {
			let num = Math.floor(Math.random() * 3) + 1

			if (num == 1) {
				document.querySelector("#system").innerHTML  ='<img src="img/math_img_1.jpg">';
				systemResult = 's';
			} else if (num == 2) {
				document.querySelector("#system").innerHTML  ='<img src="img/math_img_2.jpg">';
				systemResult = 'r';
			} else if (num == 3) {
				document.querySelector("#system").innerHTML  ='<img src="img/math_img_3.jpg">';
				systemResult = 'p';
			}
		}
		
	});
</script>

<body>
	<header>
		<jsp:include page="exit.jsp" />
		<h1>가위바위보 3번 이기기~</h1>
	</header>

	<br>
	<div id='wrap'>
		<p id='chance'></p>
		<span class='win_lose' id='win'>0</span> <span> : </span> <span
			class='win_lose' id='lose'>0</span> <br>
		<div id="btns">
			<button id="s" value="가위">가위</button>
			<button id="r" value="바위">바위</button>
			<button id="p" value="보">보</button>
		</div>


		<button id="game">가위바위보</button>


		<div id='showBox'>
			<div id="one">
				<h3>나</h3>
				<div id="me"></div>
			</div>

			<div id="two">
				<h3>상대</h3>
				<div id="system"></div>
			</div>
		</div>
		<div id="result">결과~</div>
	</div>
</body>
</html>