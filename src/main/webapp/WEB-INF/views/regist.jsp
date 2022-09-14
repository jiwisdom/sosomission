<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
#wrapper {
	border: 2px solid lightblue;
	border-radius: 5px;;
	width: 400px;
	height: 400px;
	margin: auto;
}

.title {
	text-align: center;
	font-size: 20px;
	font-weight: bold;
	color: black;
	margin: 20px 0px 20px 0px;
}

label {
	width: 95px;
	display: inline-block;
	text-align: right;
	font-size: 13px;
}

input {
	margin: 3px 5px;
	border-radius: 3px;
	border: 1px solid lightblue;
	height: 20px;
}

#signup {
	text-align: center;
	margin: 5px;
}

input[type=button] {
	border: 1px solid lightblue;
	border-radius: 3px;
	background-color: transParent;
	margin: 0px;
	height: 24px;
}

input[type=button]:hover{
	background-color: lightblue;
	color: white;
	outline: none;
}

div[id$=check] {
	font-size: 14px;
	text-align: center;
	color: red;
}
</style>
<script src='js/jquery.js'></script>﻿
<script>
	$(function() {
		let believe_id =0;
		let believe_pw = 0;
		
		//비밀번호 일치 + 중복 체크 무조건 하게 하기~~
		document.getElementById("id").addEventListener("input",function(){
			let id =  document.getElementById("id").value;
			believe_id =0;
			
			let regex = /^[a-z|A-Z]{4,12}$/;
			let result = regex.exec(id);
			
			if (result != null) {
				document.getElementById("id_check").innerHTML = "";
			} else {
				document.getElementById("id_check").innerHTML = "영어 대/소문자 4-12자리";
				
			}
		})
		
		document.getElementById("dupleCheck").addEventListener("click",function(){
			let id = document.getElementById("id").value;
			
			let regex = /^[a-z|A-Z]{4,12}$/;
			let result = regex.exec(id);

			if (result != null) {
				document.getElementById("id_check").innerHTML = "";
				$.ajax({
					url : "idCheck",
					type : "get",
					data : {id : id},
					dataType: "text",
					success : function(data){
						document.getElementById("id_check").innerHTML = data;

						if(data.includes("이미 사용 중인 아이디입니다.")){
							believe_id = 0;
						}else {
							believe_id = 1;
						}
					}
				})
			
			} 

		})
		document.getElementById("pw").addEventListener("input",function(){
			believe_pw= 0;
			document.getElementById("pw_check").innerHTML = "";
			let regex = /^[0-9]{4,12}$/;
			let result = regex.exec(document.getElementById("pw").value)

			if (result != null) {
				document.getElementById("pw_check").innerHTML = "";
			} else {
				document.getElementById("pw_check").innerHTML ="숫자 4-12자리";
				
			}
		});

		document.getElementById("repw").addEventListener("keyup",function(){   
			
			if (document.getElementById("pw").value == document.getElementById("repw").value) {
				document.getElementById("repw_check").innerHTML = "비밀번호가 일치합니다";
				believe_pw =1;
				
			} else {
				document.getElementById("repw_check").innerHTML = "비밀번호가 일치하지않습니다";
				believe_pw =0;
				

			}
		})
		document.getElementById("name").addEventListener("input",function(){
			let regex =/^[가-힣]{2,}$/;
			let result = regex.exec(document.getElementById("name").value);

			if (result != null) {
				document.getElementById("name_check").innerHTML ="";
			} else {
				document.getElementById("name_check").innerHTML = "한글만 입력 가능합니다.";

			}

		})

		document.getElementById("tel").addEventListener("input",function(){
			let regex = /^01([0-1]|[6-9])\d{3,4}\d{4}$/;
			let result = regex.exec(document.getElementById("tel").value);

			if (result != null) {
				document.getElementById("tel_check").innerHTML = "";
			} else {
				document.getElementById("tel_check").innerHTML = "번호 숫자 10-11자리 입력하세요";
			}

		})

		document.getElementById("email").addEventListener("input",function(){
			let regex = /.+@[a-z]+(\.[a-z]+){1,2}$/;
			let result = regex.exec(document.getElementById("email").value);

			if (result != null) {
				document.getElementById("email_check").innerHTML= "";

			} else {
				document.getElementById("email_check").innerHTML="올바른 이메일이 아닙니다";
			}
		})
		
		document.getElementById("signupbtn").addEventListener("click",function(){
			let id = document.getElementById("id").value;
			let pw = document.getElementById("pw").value;
			let name =  document.getElementById("name").value;
			let tel =  document.getElementById("tel").value;
			let email =  document.getElementById("email").value;

			let idregex = /^[a-z|A-Z]{4,12}$/;
			let pwregex = /^[0-9]{4,12}$/;
			let nameregex = /^[가-힣]{2,}$/;
			let telregex =  /^01([0-1]|[6-9])\d{3,4}\d{4}$/;
			let emailregex = /.+@[a-z]+(\.[a-z]+){1,2}$/;

			idregex = idregex.exec(id);
			pwregex = pwregex.exec(pw);
			nameregex = nameregex.exec(name);
			telregex = telregex.exec(tel);
			emailregex = emailregex.exec(email);

			
			if (idregex != null && pwregex != null && nameregex != null && telregex != null && emailregex != null 
					&& believe_id == 1 && believe_pw == 1 ) {
						
				$.ajax({
					url : "reigst.do",
					type : "post",
					data : {id : id,
							pw : pw,
							name : name,
							tel : tel,
							email : email
							},
					dataType : "text",
					success : function(data) {
						alert(data);
						location.href= "login";
					}
				})
			}
			
			if (idregex == null) {
				alert("아이디를 확인해주세요");
				document.getElementById("id").focus();
				return;
				
			}else if(id !="" && believe_id == 0){
				document.getElementById("id_check").innerHTML = "id 중복 확인을 하세요";
				return;
				
			}else if (pwregex == null) {
				alert("비밀번호를 확인해주세요");
				document.getElementById("pw").focus();
				return;
				
			}else if(believe_pw ==0){
				document.getElementById("repw_check").innerHTML= "패스워드 재확인을 하세요";
				document.getElementById("repw").focus();
				return;
				
			} else if (nameregex == null) {
				alert("이름을 확인해주세요");
				document.getElementById("name").focus();
				return;
			} else if (telregex == null) {
				alert("번호를 확인해주세요");
				document.getElementById("tel").focus();
				return;
			} else if (emailregex == null) {
				alert("이메일을 확인해주세요");
				document.getElementById("email").focus();
				return;
			}
			
		})
				
		document.getElementById("resetnbtn").addEventListener("click",function(){		
			document.getElementById("id").value = "";
			document.getElementById("pw").value = "";
			document.getElementById("repw").value = "";
			document.getElementById("name").value = "";
			document.getElementById("tel").value = "";
			document.getElementById("email").value = "";

			document.getElementById("id_check").innerHTML = "";
			document.getElementById("pw_check").innerHTML = "";
			document.getElementById("repw_check").innerHTML = "";
			document.getElementById("name_check").innerHTML = "";
			document.getElementById("tel_check").innerHTML = "";
			document.getElementById("email_check").innerHTML = "";
			
			document.getElementById("id").focus();
		})	
	})
</script>
<body>


	<div id='wrapper'>
		<div class='title'>회원 가입</div>

		<label>아이디 : </label><input type='text' name='id' id='id'> <input
			type='button' value='중복확인' id='dupleCheck'>
		<div id='id_check'></div>

		<label>패스워드 : </label><input type='password' name='pw' id='pw'><br>
		<div id='pw_check'></div>

		<label>패스워드 확인 :</label><input type='password' name='repw' id='repw'><br>
		<div id='repw_check'></div>

		<label>이름 : </label><input type='text' name='name' id='name'><br>
		<div id='name_check'></div>

		<label>전화번호 : </label><input type='text' name='tel' id='tel'><br>
		<div id='tel_check'></div>

		<label>이메일 : </label><input type='text' name='email' id='email'><br>
		<div id='email_check'></div>

		<div id='signup'>
			<input type='button' name='signup' value='회원가입' id='signupbtn'> 
			<input type='button' value='다시 입력' id='resetnbtn'>
		</div>

	</div>

</body>
</html>