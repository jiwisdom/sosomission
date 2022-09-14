<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

* {text-align: center;
	font-weight : bold;
}
body{
	background-image : url('/pictures/background_img/think.jpg');
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

#str {
	font-size: x-large;
}

#game {
	font-size: large;
}

#char {
	border : 3px solid lightblue;
	height: 30px;
	font-size:x-large;
}

#check {
	width: 50px;
	height: 30px;
	border : 3px solid lightblue;
	background-color : white;
	border-radius: 10%;
	
}

#check:hover {
	background-color: lightblue;
	color: white;
	outline: none;
}


#chance{font-size : large; font-weight:bold;}
</style>
</head>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		let chance = 15;
		let fail = 0;
		document.getElementById("chance").innerHTML = "기회 :"+chance;
		
		let questionList = [ 'Find', 'Inner peace', 'Potential', 'Love myself',
				'Cherish' ];

		let rdNum = Math.floor(Math.random() * questionList.length) + 0;

		let question = questionList[rdNum];

		let show = Array.from(question);
		let answer = show;

		for (let i = 0; i < show.length; i++) {
			if (show[i] == ' ') {

			} else {
				show[i] = '*';
			}
		}
		
		let span_now = document.createElement("span");
		span_now.setAttribute("id","now");
		span_now.innerHTML = show;
		document.getElementById("str").appendChild(span_now);
		
		document.getElementById("check").addEventListener("click",function(){

			if(document.getElementById("char").value!=""){
				chance--;
				document.getElementById("chance").innerHTML = "기회 :"+chance;
				
				if(chance==0){
					let check = confirm("게임 종료..다시 하시겠나요?");
					if(check){
						fail++;
						sessionStorage.setItem("fail",fail);
						chance=5;
						document.getElementById("chance").innerHTML = "기회 :"+chance;
					}else{
						sessionStorage.setItem("exit_game",'exit');
						sessionStorage.setItem("again_game",window.location.href);
						location.href="userMain";
					}
				}
				
				
				let alpha = document.getElementById("char").value;

				let LowerIndex = [];
				let UpperIndex = [];

				//입력한 알파벳이 몇 개 포함되는 지 말해줌
				LowerIndex.length = question.toLowerCase().split(alpha).length - 1;
				UpperIndex.length = question.toUpperCase().split(alpha).length - 1;
				
				// 단어를 대소문자로 각각 만들어서 몇 번 인덱스에 있는지 확인하고 배열에 집어넣음
				let flag = 0;
				let flag2 = 0;

				for (let i = 0; i < LowerIndex.length; i++) {
					let lowerNumber = question.toLowerCase().indexOf(alpha, flag);
					LowerIndex[i] = lowerNumber;
					flag = question.toLowerCase().indexOf(alpha,flag) + 1;
				}

				for (let i = 0; i < UpperIndex.length; i++) {
					let upperNumber = question.toUpperCase().indexOf(alpha, flag2);
					UpperIndex[i] = upperNumber;
					flag2 = question.toUpperCase().indexOf(alpha,flag2) + 1;
				}

				// 포함하고 있는 않으면 -1을 반환																			
				if (question.toLowerCase().indexOf(alpha) == -1
						&& question.toUpperCase().indexOf(alpha) == -1) {

					let span_wrong = document.createElement("span");
					span_wrong.innerHTML = alpha;
					document.getElementById("wrong").appendChild(span_wrong);
					

				} else if (LowerIndex.length != -1
						&& UpperIndex.length != -1) {
					document.getElementById("now").remove();

					for (let i = 0; i < LowerIndex.length; i++) {
						let num = LowerIndex[i];
						show[num] = question.charAt(num);
					}

					for (let i = 0; i < UpperIndex.length; i++) {
						let num = UpperIndex[i];
						show[num] = question.charAt(num);
					}

					let span_now = document.createElement("span");
					span_now.setAttribute("id","now");
					span_now.innerHTML = show;
					document.getElementById("str").appendChild(span_now);

					if (!show.includes("*")) {
						alert("정답입니다~");
						$("#exit").remove();
						sessionStorage.setItem("exit_game",'no');
						window.open("setComment","코멘트창","top=200px, left=1500px,width=600px,height=500px");
					}
				}
				document.getElementById("char").value = "";
				document.getElementById("char").focus();
			} else{
				alert("알파벳을 입력해주세요!");
				document.getElementById("char").focus();
			}
			

		});
			
	});
</script>

<body>
	<header>
		<jsp:include page="exit.jsp" />
		<h1>영어 문장 맞추기 게임</h1>
	</header><br>

	<div id='wrap'>
		<div id='chance' class='basic'></div>
		<br>
		<div id="str"></div>

		<div id='game'>
			<br> <input type="text" id="char" placeholder="알파벳을 입력하세요">
			<input type="button" id="check" value="확인"> <br> <br>
			<div id="wrong">틀린 알파벳 :</div>

		</div>
	</div>

</body>
</html>