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

a {
	text-decoration: none;
}

#tbl {
	margin-top: 150px;
	margin-left: auto;
	margin-right: auto;
}

input {
	width: 200px;
	height: 32px;
	font-size: 20px;
	border: 3px solid lightblue;
	border-radius: 10px;
	outline: none;
	padding-left: 10px;
	background-color: transparent;
}

.btn {
	width: 100px;
	height: 32px;
	margin: 5px;
	border-radius: 10px;
	border: 3px solid lightblue;
	background-color: transparent;
}

.btn:hover {
	background-color: lightblue;
	color: white;
	transition-duration: 1s;
}
</style>
<script src='js/jquery.js'></script>﻿
<script>
	$(function() {
		
		document.getElementById("login").addEventListener("click", function() {
			$.ajax({
				url : "login.do",
				type : "post",
				data : {
					id : document.getElementById("id").value,
					pw :document.getElementById("pw").value
				},
				dataType : "text",
				success : function(data) {
					alert(data);
					if (data.includes("관리자님 환영합니다.")) {

						sessionStorage.setItem("admin", "yes");
						location.href =  "adminMain";

						let name = getName();
						sessionStorage.setItem("name", name);

					} else if (data.includes("회원님 환영합니다.")) {
						
// 						location.href =  "myInfo";
						location.href =  "userMain";
						sessionStorage.setItem("id", document.getElementById("id").value);
						sessionStorage.setItem("alert","one");

						let name = getName();
						sessionStorage.setItem("name", name);

					} else if (data.includes("회원이 아닙니다. 회원 가입해주세요.")) {
						location.href =  "regist";
					}

				}
			});
		});
		document.getElementById("findId").addEventListener("click",function(){
				window.open("findId", "아이디"," top=200px, left=650px,width=300px,height=200px");

		})
		
		document.getElementById("findPw").addEventListener("click",function(){
				window.open("findPw", "비밀번호"," top=200px, left=650px,width=300px,height=200px");
		})

	})
	
	function getName() {
		let name;
		$.ajax({
			url : "getName",
			type : "get",
			async : false,
			data :{
				id :  document.getElementById("id").value,
				pw :  document.getElementById("pw").value
			},
			dataType : "text",
			success : function(data) {
				name = data;
			}

		})
		return name;
	}
</script>

<body>
	<div id='wrap'>

		<table id='tbl'>
			<tr>
				<th><input type="text" id="id" class="account" placeholder="Id"
					required></th>
				<th><button class='btn' id='findId'>ID 찾기</button></th>
			</tr>
			<tr>
				<th><input type="password" id="pw" class="account"
					placeholder="Password" required></th>
				<th><button class='btn' id='findPw'>PW 찾기</button></th>
			</tr>

			<tr>
				<th><button id="login" class="btn">Login</button> &nbsp;<a
					href="regist"><button class="btn">Regist</button></a></th>
			</tr>

		</table>
	</div>

</body>
</html>