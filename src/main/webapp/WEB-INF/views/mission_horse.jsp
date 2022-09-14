<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<style>
* {
	text-align: center;
}
body{
	background-image : url('/pictures/background_img/field.jpg');
	background-size : cover ;
}

header {
	height: 90px;
	width: 100%;
	position: absolute;
}
#selDiv{
	margin-top : 100px;
	font-size : large;
}
#sel{
	width : 180px;
	font-size : large;
	border : 3px solid lightblue;
	outline : lightblue;
}
#selBtn{
	background-color : lightblue;
	color :white;
	border : none;
	width : 50px;
	height : 30px;
	border-radius : 5px;
}
#selBtn:hover{
	background-color : orange;
}
#wrap {
	float: left;
	padding:0px;
}

img {
	width: 380px;
	heifht: 320px;
}

@keyframes box-ani {
	from { transform:translate(0,0);}
	to {transform: translate(1000px, 0px);}
}
#endLine {
	float: right;
	border-left: thick solid #000;
	height: 600px;
	right: 30%;
	position: absolute;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {

// 		alert(parseInt(sessionStorage.getItem("fail")));
		
		let list = horse();
		$("#selBtn").click(function(){
			let afterRide = ride(list,$("#sel").val());
			 setTimeout(()=>{
				 if(list[0] == $("#sel").val()) {
	 		 			alert("정답");

	 		 			document.getElementById("exit").remove();
						window.open("setComment","코멘트창","top=200px, left=650px,width=700px,height=500px");
						sessionStorage.setItem("exit_game",'no');
	 	 			} else {
	 	 				let fail = parseInt(sessionStorage.getItem("fail"));
	 	 				sessionStorage.setItem("fail",fail+1);
						
	 	 				let check =confirm("베팅 실패! 다시 하시겠나요?");
	 	 				if(check){
	 	 					location.reload();

		 	 			} else {
							sessionStorage.setItem("exit_game", 'exit');
							sessionStorage.setItem("again_game",window.location.href);
							location.href =  "userMain";
						}

	 			 	}	
			  },3000);
			
		})

	})

	function horse() {
		let list;
		$.ajax({
			url : "batting",
			type : "get",
			async : false,
			dataType : "text",
			success : function(data) {
				list = data;
			}
		})
		return list;
	}

	function ride(list,num){
		if (list[0] == 1) {
			$("#first").css("animation", "box-ani 1s linear forwards");
		} else if (list[0] == 2) {
			$("#second").css("animation", "box-ani 1s linear forwards");
		} else if (list[0] == 3) {
			$("#third").css("animation", "box-ani 1s linear forwards");
		}

		if (list[1] == 1) {
			$("#first").css("animation", "box-ani 2s linear forwards");
		} else if (list[1] == 2) {
			$("#second").css("animation", "box-ani 2s linear forwards");
		} else if (list[1] == 3) {
			$("#third").css("animation", "box-ani 2s linear forwards");
		}

		if (list[2] == 1) {
			$("#first").css("animation", "box-ani 3s linear forwards");
		} else if (list[2] == 2) {
			$("#second").css("animation", "box-ani 3s linear forwards");
		} else if (list[2] == 3) {
			$("#third").css("animation", "box-ani 3s linear forwards");
		}

		return 0;		
	}
	
</script>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<header>
		<jsp:include page="exit.jsp" /><br>
		<h1>경주</h1>
	</header>
	<br>
	<div id='selDiv'>
		<h3>1,2,3,번 말 중 몇 번 말이 우승할까요?</h3>
		<input type='text' id='sel' placeholder='숫자만 입력하세요~'>
		<button id='selBtn'>선택</button>
	</div>
	<div id='wrap'>
		<div id='first'>
			<img src='pictures/horse/경주말.png'>
		</div>
		<div id='second'>
			<img src='pictures/horse/경주말.png'>
		</div>
		<div id='third'>
			<img src='pictures/horse/경주말.png'>
		</div>
	</div>
	<br>
	<br>
	<div id='endLine'></div>

</body>
</html>