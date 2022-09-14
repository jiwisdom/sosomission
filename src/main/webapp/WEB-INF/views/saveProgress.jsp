<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#move{float:right;}
</style>
<script src='js/jquery.js'></script>
<script>
$(function(){

	let url = window.location.pathname; //현재 페이지 이름
	let pathName = url.split("/");

	$("#move").click(function(){
		$(location).attr("href","showDevelopmentContent?url="+pathName[1]+"");
	})
	
})
</script>
</head>
<body>
<button id='move'>진행 상황 저장</button>
</body>
