<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

button {
	background-color: transParent;
	height: 30px;
	border: 2px solid lightblue;
	border-radius: 10px;
	font-size: large;
}

button:hover {
	background-color: lightblue;
	color: white;
	transition-duration: 1s;
}

input[type=text] {
	width: 250px;
	heigth: 30px;
	font-size: 20px;
	margin: 2px;
}

#wrap {
	margin-top: 50px;
}

tr, th {
	padding: 10px;
}

#info {
	font-size: large;
}
</style>
</head>

<script src='js/jquery.js'></script>
<script>
	
	$(function() {
		
		if(sessionStorage.getItem("popUp")=="yes"){
			$("#noPopUp").remove();
		} else {
			sessionStorage.setItem("popUp","no");
		}
		let nameCheck_count=0;
		let urlCheck_count=0;
		
		$("#mission_name").on("input",function(){
			nameCheck_count=0;
			$("#mission_name_check").html("");
		})
		
		$("#mission_url").on("input",function(){
			mission_url_count=0;
			$("#mission_url_check").html("");
		})
		
		$("#nameCheck").click(function(){
			$.ajax({
				url : "developmentNameCheck",
				type :"get",	
				data :{mission_name : $("#mission_name").val()},
				dataType :"text",
				success : function(data){
					$("#mission_name_check").html(data);
					if(data.includes("사용 가능한 미션명입니다.")){
						nameCheck_count=1;
					}
				}
			})
		})
		
		$("#urlCheck").click(function(){
			$.ajax({
				url : "developmentUrlCheck",
				type :"post",	
				data :{mission_url : $("#mission_url").val()},
				dataType :"text",
				success : function(data){
					$("#mission_url_check").html(data);
					if(data.includes("사용 가능한 미션주소입니다.")){
						urlCheck_count=1;
					}
				}
			})
		})
		
		
		$("#insert").click(function() {
			
			if(urlCheck_count==1 && nameCheck_count==1){
				$.ajax({
					url : "insertDevelopment",
					type : "post",
					data : {
						suggest_num : $("#suggest_num").val(),
						title : $("#mission_name").val(),
						url : $("#mission_url").val()
					},
					dataType : "text",
					success : function(data) {
						let check = confirm(data);
						if(sessionStorage.getItem("popUp")=="yes" && check ==true){
							opener.location.href = "developmentList";
							window.close();
						}else{
							if(data.includes("등록되었습니다")){
								$(location).attr("href", "developmentList");
							}
						}
					}
				})
				
			}else if(nameCheck_count==0){
				$("#mission_name_check").html("미션명 중복 확인하세요!");
			}else if(urlCheck_count==0){
				$("#mission_url_check").html("미션 주소 중복 확인하세요!");
			}else {
				alert("다시 확인...");
			}
		})
	})
</script>
<body>
<div id='noPopUp'>
<jsp:include page="adminHeader.jsp"/>
</div>
<h1>개발 미션 등록</h1>
	<div id='wrap'>
		<table id='tbl'>
			<tr>
				<th><a id='info'>※사용자가 제시한 미션인 경우,미션 제안 번호를 적어주세요.</a></th>
			</tr>
			<tr>
				<th><input type='text' id='suggest_num'
					placeholder='미션 제안 번호를 입력' value='0'></th>
			</tr>
			<tr>
				<th><input type='text' id='mission_name'
					placeholder='미션 이름을 입력'><br><button id='nameCheck'>미션 이름 중복 확인</button>
					<br><div id='mission_name_check'></div></th>
			</tr>
			<tr>
				<th><input type='text' id='mission_url'
					placeholder='미션 페이지 명을 입력'><br><button id='urlCheck'>미션 주소 중복 확인</button>
					<br><div id='mission_url_check'></div></th>
			</tr>
			<tr>
				<th><button id='insert'>등록</button></th>
			</tr>
		</table>
	</div>
</body>
</html>