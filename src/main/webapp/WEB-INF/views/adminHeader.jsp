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
a{
	cursor :pointer;
}
.a {
	text-decoration: none;
	color: black;
}
.a:hover {
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
<script src='js/jquery.js'></script>
<script>
$(function(){
	var name = sessionStorage.getItem("name");
	$("#name").append(""+name + "님 안녕");

	//개발 등록 팝업창과 페이지 구분하기 위함
	$(".a").click(function(){
		sessionStorage.setItem("popUp","no");
	})

	$("#logout").click(function(){
		sessionStorage.clear();
		location.href="logout";
	})

})
</script>

<body>
	
	<header>
		<div id='menu'>
		<ul>
			<li><a class ='a' id='name'></a></li>
			<li><a class ='a'>회원 관리</a>
				<ul>
					<li><a class ='a'href='memberList'>회원 정보</a>
					<li><a class ='a' href='memberDeleteList'>탈퇴 회원 정보</a>
				</ul></li>
				
			<li><a class ='a'>미션</a>
				<ul>
					<li><a class ='a' href='missionList'>미션 목록</a>
					<li><a class ='a' href='suggestionList'>미션 제안서 목록</a>
					<li><a class ='a' href='developmentList'>개발 목록</a>
					<li><a class ='a' href='developmentInsert'>개발 미션 등록</a>
				</ul></li>
			<li><a class ='a' href='adminMain'>MAIN</a></li>
			<li><a class ='a' id='logout'>로그아웃</a></li>
		</ul>

	</div>
	</header>
</body>
