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
	cursor: pointer;
}
body{
	background-image : url('/pictures/background_img/clean.jpg');
	background-size : 100% 900px;
}

header {
	height: 90px;
	width: 100%;
	position: absolute;
}

#wrap {
	margin-top: 120px;
}

#colorbox {
	border: 3px solid lightblue;
	border-radius: 10px;
}

.box {
	display: inline-block;
	width: 150px;
	height: 200px;
	margin: 10px;
}

#greenbox {
	background-color: green;
}

#yellowbox {
	background-color: yellow;
}

#redbox {
	background-color: red;
}

#bluebox {
	background-color: blue;
}

.circle, .circle2 {
	display: inline-block;
	width: 100px;
	height: 100px;
	border-radius: 50%;
	paddin: 5px;
	margin: 10px;
	font-size: large;
	font-weight: bold;
	line-height: 100px;
}

#chanceLimit {
	font-size: large;
	font-weight: bold;
}
</style>
<script src='js/jquery.js'></script>
<script>
	let fail=0;
	$(function() {
		$("#chanceLimit").html("기회 : 5");
		
		let colors = [ [ '빨강', 'red', 'green' ], [ '초록', 'green', 'yellow' ],
				[ '노랑', 'yellow', 'blue' ], [ '파랑', 'blue', 'red' ] ];

		$("#redCircle").html(colors[0][0]);
		$("#redCircle").css("background-color", colors[0][1]);
		$("#redCircle").css("color", colors[0][2]);

		$("#greenCircle").html(colors[1][0]);
		$("#greenCircle").css("background-color", colors[1][1]);
		$("#greenCircle").css("color", colors[1][2]);

		$("#yellowCircle").html(colors[2][0]);
		$("#yellowCircle").css("background-color", colors[2][1]);
		$("#yellowCircle").css("color", colors[2][2]);

		$("#blueCircle").html(colors[3][0]);
		$("#blueCircle").css("background-color", colors[3][1]);
		$("#blueCircle").css("color", colors[3][2]);

		$(".circle").attr("ondrop", "drop(event)");
		$(".circle").attr("ondragstart", "drag(event)");
		$(".circle").attr("ondragover", "dragEnter(event)");

		$(".box").attr("ondrop", "drop(event)");
		$(".box").attr("ondragover", "dragEnter(event)");
		

		$("#exit").click(function(){
			sessionStorage.setItem("exit_game",'exit');
			sessionStorage.setItem("again_game","mission_clean");
			$(location).attr("href","userMain.jsp");
		})
		
	})

	function dragEnter(e) {
		e.preventDefault();
	}

	function drag(e) {
		e.dataTransfer.setData("id", e.target.id);
	}
	
	let count =0;
	let chance = 5;
	
	$("#chanceLimit").html("기회 : "+chance);
	
	function drop(e) {
	
		e.preventDefault();
		let id = e.dataTransfer.getData("id"); 
		let backColor = $("#" + id).data("back");
		let color = $("#" + id).data("color");
		let value = $("#" + id).data("value");
		let box_id = $("#" + id).data("boxid");

		let e_id = e.target.id;
		
		if (box_id == e_id) {
			chance--;
			$("#" + box_id).append("<div class='circle' style='background-color :"
					+backColor+"; color:"
					+color+";'>"
					+ value + "</div>");
			
			if (box_id == 'bluebox') {
				$("#yellowCircle").remove();
				count++;
			} else if (box_id == 'yellowbox') {
				$("#greenCircle").remove();
				count++;
			} else if (box_id == 'redbox') {
				$("#blueCircle").remove();
				count++;
			} else if (box_id == 'greenbox') {
				$("#redCircle").remove();
				count++;
			}
			
		}else
			chance--;
			$("#chanceLimit").html("기회 : "+chance);

		if(count==4){
			alert("정답입니다");
			$("#exit").remove();
			window.open("setComment","코멘트창","top=200px, left=1500px,width=600px,height=500px");
			sessionStorage.setItem("exit_game",'no');
		}
		
		
		if(chance==0 && count<4){
			let check = confirm("게임 종료...다시 하시겠습니까?");
			if(check){
				chance=2;
				$("#chanceLimit").html("기회 : "+chance);
				fail++;
				sessionStorage.setItem("fail",fail);

			}else {
				sessionStorage.setItem("exit_game",'exit');
				sessionStorage.setItem("again_game",window.location.href);
				$(location).attr("href","userMain");
			}
		}
		
	}
	
</script>
<body>
<header>
	<jsp:include page="exit.jsp"/><br>
	<h1>공을 정리해봅시다~</h1>
</header>
<br>
	<div id='wrap'>
		<h3>※글자 색과 같은 상자에 공을 넣어주세요~</h3>
	<div id='chanceLimit'></div>
	<div id='colorbox'>
		<div class='box' id='greenbox'></div>
		<div class='box' id='yellowbox'></div>
		<div class='box' id='redbox'></div>
		<div class='box' id='bluebox'></div>
	</div>

	<div id='colorcircle'>
		<div class='circle' id='yellowCircle' draggable='true'data-color='blue' data-back='yellow' data-value='노랑' data-boxid='bluebox'></div>
		<div class='circle' id='greenCircle' draggable='true'data-color='yellow' data-back='green' data-value='초록' data-boxid='yellowbox'></div>
		<div class='circle' id='blueCircle' draggable='true' data-color='red' data-back='blue' data-value='파랑' data-boxid='redbox'></div>
		<div class='circle' id='redCircle' draggable='true' data-color='green' data-back='red' data-value='빨강' data-boxid='greenbox'></div>
	</div>
	
	
	</div>
	

</body>
</html>