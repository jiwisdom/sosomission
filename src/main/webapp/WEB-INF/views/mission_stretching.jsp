<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<style>
* {
	text-align: center;
	
}
body{
	background-image : url('/pictures/background_img/forest.jpg');
	backgroung-size :cover;
}

header {
	position: absolute;
	height: 90px;
	width: 100%;
	position: absolute;
	margin-top: 0px;
}

#stretching {
	margin-top: 150px;
}
</style>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://www.youtube.com/iframe_api"></script> 
<script>
	let player;
	function onYouTubeIframeAPIReady() {
		player = new YT.Player('stretching', {
			events: {
				'onStateChange': onPlayerStateChange
			}
	  })
	}
	//종료되면 data ==0
	function onPlayerStateChange(event) {
		if(event.data==0){
			alert("스트레칭을 습관화합시다~");
			document.getElementById("exit").remove();
			window.open("setComment","코멘트창","top=200px,left=650px,width=700px,height=500px");
			sessionStorage.setItem("exit_game",'no');
		}
	}	
</script>
</head>
<body>
	<header>
		<jsp:include page="exit.jsp" /><br>
		<h1>스트레칭</h1>
		<h3>스트레칭으로 몸을 풀어줍시다~</h3>
	</header>
	<p align='center'>
		<iframe id='stretching' width="850" height="550"
			src="https://www.youtube.com/embed/
			uPOWvBj7nFY?start=13&end=370&rel=0
			&amp;enablejsapi=1&amp;version=3&amp;playerapiid=ytplayer">
		</iframe>
	</p>
</body>
</html>