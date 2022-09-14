<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
* {
	text-align: center;
}
body{
	background-image : url('/pictures/background_img/study.jpg');
	background-size : cover;
}

header {
	height: 90px;
	width: 100%;
	position: absolute;
}
#remember{
	color : white;
}

#numbers {
	color : white;
	font-size: xx-large;
}

.num {
	font-size: x-large;
	width: 50px;
	border : 2px solid lightblue;
	outline : lightblue;
}
#chance{
	font-size : x-large;
	font-weight : bold;
}

button {
	width: 70px;
	height: 35px;
	border-radius: 10%;
	border: 3px solid lightblue;
	background-color: white;
}

button:hover {
	background-color: lightblue;
	color: white;
	outline: none;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src='js/jquery.js'></script>
<script>
	$(function(){
		$("#numbers").hide();
		$("#remember").hide();
		let list = hashSet();
		let chance = 3;
// 		sessionStorage.setItem("fail",0);
// 		alert(sessionStorage.getItem("fail"));

		$("#chance").html("기회 : "+chance);
		$("#start").click(function(){
			$("#numbers").show();

			 setTimeout(()=>{
				 $("#numbers").hide();
			  },3000);
				$("#start").hide();
			  setTimeout(()=>{
					 $("#remember").show();
			  },3000);
		})
		
		$("#hint").click(function(){
			$("#remember").hide();
			$("#numbers").show();
			 setTimeout(()=>{
				 $("#numbers").hide();
			  },1000);
			 setTimeout(()=>{
				 $("#remember").show();
		  	},1000);

			$("#hint").hide();
			
		})
		$("#check").click(function(){
			let first = $("#first").val();
			let second = $("#second").val();
			let third = $("#third").val();
			let fourth = $("#fourth").val();
			let fifth = $("#fifth").val();

			
			if(first==list[0] && second==list[1]&& 
			third==list[2]&&fourth==list[3] && fifth==list[4]){
				alert("정답!");
				document.getElementById("exit").remove();
				window.open("setComment","코멘트창","top=200px, left=650px,width=700px,height=500px");
				sessionStorage.setItem("exit_game",'no');
			}else{
				chance--;
				$("#chance").html("기회 : "+chance);
				alert("땡!");
				if(chance==0){
					let again = confirm("다시 할래요?")
					let fail = parseInt(sessionStorage.getItem("fail"));
					sessionStorage.setItem("fail",fail+1);
					if(again){
						chance=1;
						$("#chance").html("기회 : "+chance);
					}else{
						sessionStorage.setItem("exit_game",'exit');
						sessionStorage.setItem("again_game",window.location.href);
						location.href="userMain";
					}

				}
			}
		})
	})
	
	function hashSet(){
		let set = []; 
		$.ajax({
			url :"hashSet",
			type :"get",
			async : false,
			dataType :"text",
			success : function(data){
				let list = JSON.parse(data);
				
				for(let i=0;i<list.length;i++){
					set[i] = list[i].num;
					console.log(list[i].num+" ");
					$("#numbers").append(list[i].num+" ");
				}				
			}
		})
		return set;
	}
</script>
</head>
<body>
	<header>
		<jsp:include page="exit.jsp" />
		<h1>암기왕</h1>
	</header>
	<br><br><br><br><br>
	<div id='chance'></div>
	<button id='start'>시작!</button>
	<button id='hint'>힌트!</button>
	<div id='numbers'></div>
	<br><br><br>
	<div id='remember'>
		1번째 <input type='text' id='first' class='num'> 2번째 <input
			type='text' id='second' class='num'> 3번째 <input type='text'
			id='third' class='num'> 4번째 <input type='text' id='fourth'
			class='num'> 5번째 <input type='text' id='fifth' class='num'>
		<br> <br> <br>
		<button id='check'>확인</button>

	</div>

</body>
</html>