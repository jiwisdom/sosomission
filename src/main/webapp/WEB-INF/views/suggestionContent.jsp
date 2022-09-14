<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	text-align: center;
}

h1 {
	background-color: lightblue;
}

#tbl {
	margin: auto;
}

textarea {
	border: 3px solid lightblue;
	width: 500px;
	height: 400px;
	overflow: auto;
	font-size: 20px
}

#title {
	width: 500px;
	font-size: 20px;
}
a {
	text-decoration: none;
	color: black;
}
button {
	border: 1px solid lightblue;
	border-radius: 3px;
	background-color: transParent;
	margin: 0px;
	height: 24px;
}

button:hover{
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}
</style>
</head>
<script src='js/jquery.js'></script>
<script>
	
$(function(){
	
	let admin = sessionStorage.getItem("admin");
	let id =    sessionStorage.getItem("id");
	let state = '${requestScope.state}';
	let writer = '${requestScope.id}';
	sessionStorage.setItem("popUp","no");

	if(admin =="yes"){
		if(state == "확인"){
			$("#btn").append("<td><button id='examine'>검토</button> <button id='withhold'>보류</button></td>");
		}else if(state=='검토'){
			$("#btn").append("<td><button id='insert'>개발 등록</button></td>");
		}
		
	}else if(id ==writer && state =='미확인'){
		$("#btn").append("<td><button id='update'>수정</button> <button id='delete'>삭제</button></td>");
	}
	
	if(state == '개발'){
		$("#btn").append("<td><button><a href='showDevelopmentContent?suggest_num=${requestScope.suggest_num }&title=${requestScope.title}'>개발 진행 상황 보기</a></td>");
	}
	
	$("#examine").click(function(){
		$.ajax({
			url : "examine",	
			type : "get",
			data : {num : $("#tbl").data("value")},
			dataType : "text",
			success : function(data){
				alert(data);
				location.reload();
			}
		})
	})
	
	$("#withhold").click(function(){
		$.ajax({
			url : "withhold",	
			type : "post",
			data : {num : $("#tbl").data("value")},
			dataType : "text",
			success : function(data){
				alert(data);
				location.reload();
			}
		})
	})
	
	$("#update").click(function(){
		$("#info").html("");
		$("#info").append("<th><input type='text' id='title' value='"+$("#info").data("value")+"'></th>");
		$("#contents").removeAttr("disabled");
		$("#btn").html("");
		$("#btn").append("<td><button id='realUpdate'>수정</button></td>");
	})
	
	$(document).on("click","#realUpdate",function(){
		let suggest_num = $("#tbl").data("value");
		let title = $("#title").val();
		let contents = $("#contents").val();
		
		$.ajax({
			url : "updateSuggestion",
			type :"get",
			data : {
				suggest_num : suggest_num,
				title : title,
				contents : contents				
			},
			dataType :"text",
			success : function(data){
				alert(data);
				location.reload();
			}
		})
	})
	
	$(document).on("click","#delete",function(){
		let suggest_num = $("#tbl").data("value");
		
		$.ajax({
			url : "deleteSuggestion",
			type :"post",
			data : {suggest_num : suggest_num},
			dataType :"text",
			success : function(data){
				alert(data);
				$(location).attr("href","showMySuggestion");
			}
		})
	})
	
	$("#insert").click(function(){
		sessionStorage.setItem("popUp","yes");
		window.open("developmentInsert","개발 미션 등록"," top=200px, left=650px,width=700px,height=500px");
	})
})
	
</script>
<body>
<c:if test="${requestScope.admin =='admin'}">
	<jsp:include page="adminHeader.jsp"/>
</c:if>
<c:if test="${requestScope.admin !='admin'}">
	<jsp:include page="userHeader.jsp"/>
</c:if>

<table id='tbl' data-value='${requestScope.suggest_num }'>
	<tr id='info' data-value='${requestScope.title }'>
		<th >번호 ${requestScope.suggest_num } | 제목 ${requestScope.title } | 작성자 ${requestScope.id } | 작성날짜 ${requestScope.date }</th>
	</tr>
	
	<tr>
		<th><textarea id='contents' disabled>${requestScope.mission }</textarea></th>
	</tr>
	
	<tr>
		<th><hr></th>
	</tr>
	
	<tr id='btn'></tr>
	
	<tr>
		<th>${requestScope.reply }</th>
	</tr>
</table>
</body>
</html>