<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
* {text-align: center;
}

h1 {
	background-color: lightblue;
	margin-bottom: 50px;
}

button {
	border: 1px solid lightblue;
	border-radius: 3px;
	background-color: transParent;
	margin: 0px;
	width: 100px;
	height: 24px;
	font-size: large;
}

button:hover {
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}

#wrap {
	  display: flex;
      flex-wrap: wrap;
      flex-direction: column; 
      align-items: center;
      justify-content: center;
}

#tbl {
	margin: auto;
}

#tbl>tr, th {
	font-size :large;
	padding: 20px;
}

#tbl2>tr, th {
	font-size :large;
	padding: 10px;
}
#check_pw{
	width : 200px;
	height : 20px;
	margin : 5px;
}
#showInfo {
	border: 3px solid lightblue;
	border-radius: 5px;
}

.modal {
	display: none;
	width: 300px;
}
input{
	width : 200px;
	height : 20px;
	margin : 5px;
	font-size:large;
	outline: none;
	border : 2px solid lightblue;
	border-radius: 5px;
}
.warning{
	font-size : medium;
	color :red;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		
		document.getElementById("tbl2").style.visibility = "hidden";
		
		document.getElementById("update").addEventListener("click",function(){
			document.getElementsByClassName("modal")[0].style.display = 'block'; 
			document.getElementById("check_pw").focus();
			document.getElementById("update").remove();
		})
		document.getElementById("checkPw").addEventListener("click",function(){
			
			let pw =document.getElementById("check_pw").value;
			
			$.ajax({
				url : "CheckPw",
				type : "get",
				data : {pw : pw},
				dataType : "text",
				success : function(data){
						alert(data);
					if(data.includes("확인되었습니다")){
						let believe_pw =1;
						document.getElementById("tbl2").style.visibility = "visible";
						document.getElementById("showInfo").remove();
		 				document.getElementById("pwcheck").remove();

		 				document.getElementById("Myname").addEventListener("input",function(){
							let regex = /^[가-힣]{2,}$/;
							let result = regex.exec(document.getElementById("Myname").value);

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
						})

						document.getElementById("repw").addEventListener("keyup",function(){   
							
							if (document.getElementById("pw").value == document.getElementById("repw").value) {
								document.getElementById("repw_check").innerHTML = "비밀번호가 일치합니다";
								believe_pw =1;
								
							} else {
								document.getElementById("repw_check").innerHTML = "비밀번호가 일치하지않습니다";
								believe_pw =0;
							}
						})
						
						document.getElementById("realUpdate").addEventListener("click",function(){
							let pw = document.getElementById("pw").value;
							let Myname =  document.getElementById("Myname").value;
							let tel =  document.getElementById("tel").value;
							let email =  document.getElementById("email").value;

							let pwregex = /^[0-9]{4,12}$/;
							let Mynameregex = /^[가-힣]{2,}$/;
							let telregex =  /^01([0-1]|[6-9])\d{3,4}\d{4}$/;
							let emailregex = /.+@[a-z]+(\.[a-z]+){1,2}$/;

							pwregex = pwregex.exec(pw);
							Mynameregex = Mynameregex.exec(Myname);
							telregex = telregex.exec(tel);
							emailregex = emailregex.exec(email);

							
							if ( pwregex != null && Mynameregex != null && telregex != null && emailregex != null 
									&& believe_pw == 1 ) {
										
								$.ajax({
									url : "updateMyInfo",
									type : "post",
									data : {
											Myname : Myname,
											pw : pw,
											tel : tel,
											email : email
											},
									dataType : "text",
									success : function(data) {
										alert(data);
										if(data.includes("수정되었습니다")){
											location.reload();
										}
									}
								})
							}
							
							if (Mynameregex == null) {
								alert("이름을 확인해주세요");
								document.getElementById("Myname").focus();
								return;
								
							}else if (pwregex == null) {
								alert("비밀번호를 확인해주세요");
								document.getElementById("pw").focus();
								return;
								
							}else if(believe_pw ==0){
								document.getElementById("repw_check").innerHTML= "패스워드 재확인을 하세요";
								document.getElementById("repw").focus();
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
					}else if(data.includes("비밀번호를 다시 확인해주세요")){
						document.getElementById("check_pw").value = "";
						document.getElementById("check_pw").focus();
					}
				}
				
			});
		});
		
	});
	

	
</script>
<body>
	<jsp:include page="userHeader.jsp" />
	<h1>개인정보</h1>
	<div id='wrap'>
		<div id='showInfo'>
			<table id='tbl'>
				<c:forEach var='list' items='${list }'>
					<tr><th>id</th><th>${list.id }</th></tr>
					<tr><th>name</th><th>${list.name }</th></tr>
					<tr><th>tel</th><th>${list.tel }</th></tr>
					<tr><th>email</th><th>${list.email }</th></tr>
					<tr><th>regdate</th><th>${list.reg_date }</th></tr>
					<tr><th colspan='2'><button id='update'>수정</button></th></tr>
				</c:forEach>
			</table>
		</div><br>
		
		<div id='pwcheck' class='modal'><input type='password' id='check_pw' placeholder='비밀번호를 입력하세요.'>
		<br><button id='checkPw'>확인</button></div>
		
		<div id='updateInfo'>
			<table id='tbl2'>
				<c:forEach var='list' items='${list }'>
					<tr><th>이름</th><th><input type='text' id='Myname' value='${list.name }'></th></tr>
					<tr><th colspan='2'><div class='warning' id='name_check'></div></th></tr>
					<tr><th>번호</th><th><input type='text' id='tel' value='${list.tel }'></th></tr>
					<tr><th colspan='2'><div class='warning' id='tel_check'></div></th></tr>
					<tr><th>이메일</th><th><input type='text' id='email' value='${list.email }'></th></tr>
					<tr><th colspan='2'><div class='warning' id='email_check'></div></th></tr>
					<tr><th>패스워드</th><th><input type='password' id='pw' value='${list.pw }'></th></tr>
					<tr><th colspan='2'><div class='warning' id='pw_check'></div></th></tr>
					<tr><th>패스워드 재확인</th><th><input type='password' id='repw'></th></tr>
					<tr><th colspan='2'><div class='warning' id='repw_check'></div></th></tr>
					<tr><th colspan='2'><button id='realUpdate'>수정</button></th></tr>
				</c:forEach>
			</table>
		</div>
		<br>
	</div>
</body>
</html>