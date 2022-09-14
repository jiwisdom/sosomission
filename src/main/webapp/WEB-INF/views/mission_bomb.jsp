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

body {
	background-image: url('/pictures/background_img/construction.jpg');
	background-size: 100% 900px;
}

header {
	height: 90px;
	width: 100%;
	position: absolute;
}

#startGame {
	margin: auto;
	font-size: large;
	width: 100px;
	height: 35px;
	border-radius: 10%;
	border: 3px solid lightblue;
	background-color: white;
	width: 100px;
}

#startGame:hover {
	background-color: lightblue;
	color: white;
	outline: none;
}

#bombTbl {
	margin: auto;
}

.div {
	width: 100px;
	height: 130px;
	border: 3px solid black;
}

p {
	font-size: x-large;
	font-weight: bold;
}

img {
	width: 100px;
	height: 130px;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function(){

		let rdNum = Math.floor(Math.random()*25)+1;
		let time = 10;
		let fail =0;
		console.log(rdNum);
		$("#bombTbl").hide();
		
		$("#startGame").click(function(){
			$("#bombTbl").show();
			$("#startGame").hide();
			$("#timer").html("제한 시간 :"+time);

			let countdown = setInterval(function() {

				$("#timer").html("제한 시간 :"+time);

				$(".div").click(function(){
					 $(this).hide();
					 setTimeout(()=>{
						 if($(this).parent().attr("id")==rdNum){
							 $(this).hide();
							 $("#"+rdNum).html("<img src='/pictures/bomb/bomb.png'/>");
							 setTimeout(()=>{
								 alert("정답입니다~");
								 	//카운트 멈추기
								 	clearInterval(countdown);
									$("#exit").remove();
									sessionStorage.setItem("exit_game",'no');
									window.open("setComment","코멘트창","top=200px, left=1500px,width=600px,height=500px");
							 },100);
						}else {
							 $(this).show();
							 $(this).css("background-color","beige");
						}
					  },200);
					  
				})

				if(time==0){
					let check = confirm("시간 끝! 폭탄 제거 실패...다시 도전할래요?");
					if (check) {
						fail++;
						sessionStorage.setItem("fail",fail);
						time = 6;

					} else {
						sessionStorage.setItem("exit_game", 'exit');
						sessionStorage.setItem("again_game",
								window.location.href);
						location.href = "userMain";
					}
				}
				time--;
			}, 1000);

		})
	})
		
</script>
<body>
	<header>
		<jsp:include page="exit.jsp" />
		<br>
		<h1>폭탄 찾기</h1>
	</header>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	<button id='startGame'>폭탄 찾기!</button>
	<p id='timer'></p>
	<table id='bombTbl'>
		<tr>
			<th id='1'><div class='div'></div></th>
			<th id='2'><div class='div'></div></th>
			<th id='3'><div class='div'></div></th>
			<th id='4'><div class='div'></div></th>
			<th id='5'><div class='div'></div></th>
		</tr>
		<tr>
			<th id='6'><div class='div'></div></th>
			<th id='7'><div class='div'></div></th>
			<th id='8'><div class='div'></div></th>
			<th id='9'><div class='div'></div></th>
			<th id='10'><div class='div'></div></th>
		</tr>
		<tr>
			<th id='11'><div class='div'></div></th>
			<th id='12'><div class='div'></div></th>
			<th id='13'><div class='div'></div></th>
			<th id='14'><div class='div'></div></th>
			<th id='15'><div class='div'></div></th>
		</tr>
		<tr>
			<th id='16'><div class='div'></div></th>
			<th id='17'><div class='div'></div></th>
			<th id='18'><div class='div'></div></th>
			<th id='19'><div class='div'></div></th>
			<th id='20'><div class='div'></div></th>
		</tr>
		<tr>
			<th id='21'><div class='div'></div></th>
			<th id='22'><div class='div'></div></th>
			<th id='23'><div class='div'></div></th>
			<th id='24'><div class='div'></div></th>
			<th id='25'><div class='div'></div></th>
		</tr>

	</table>
</body>

</html>