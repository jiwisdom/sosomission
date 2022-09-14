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

}
h1 {
	background-color: lightblue;
	margin-bottom: 50px;
}

#form {
	display: flex;
	flex-wrap: wrap;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

input {
	border: 2px solid lightblue;
	border-radius: 5px;;
	width: 300px;
	height: 25px;
	font-size: large;
	outline: none;
}

button {
	margin: 10px;
	width: 100px;
	height: 25px;
	font-size: large;
	border-radius: 10px;
	border: 2px solid lightblue;
	background-color: transparent;
}

button:hover {
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}

#modelBTN {
	position: absolute;
	top: 50%;
	left: 50%;
	width: 120px;
	height: 30px;
	margin-top: -15px;
	margin-left: -60px;
	line-height: 15px;
	cursor: pointer;
}

.modal {
	position: absolute;
	width: 100%;
	height: 100%;
	background: grey;
	top: 0;
	left: 0;
	display: none;
}

.modal_content {
	width: 400px;
	height: 200px;
	background: #fff;
	border-radius: 10px;
	position: relative;
	top: 50%;
	left: 50%;
	margin-top: -100px;
	margin-left: -200px;
	text-align: center;
	box-sizing: border-box;
	padding: 74px 0;
	line-height: 23px;
	cursor: pointer;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {

		$("#reject").click(function() {
			$(".modal").fadeOut();
		});

		$("#secssion").click(function() {
				if (check) {
					$.ajax({
						url : "delete",
						type : "post",
						dataType : "text",
						success : function(data) {
							if (data.includes("회원 탈퇴되었습니다.")) {
								$("#contents").html(data);
								$("#secssion").remove();
								$("#reject").remove();
								$(".modal_content").append("<a href='login' id='moveLogin'><button>닫기</button></a>");
							}
						}
					})
								
				} else {
					$(location).attr("href", "userMain");
				}
		})

		$("#check").click(function() {
			$.ajax({
				url : "pwCheck",
				type : "get",
				data : {
					pw : $("#pw").val()
				},
				dataType : "text",
				success : function(data) {
					if (data.includes("확인되었습니다")) {
						$(".modal").fadeIn();
					}
				}
			})
		})

	})
</script>
<body>
	<jsp:include page="userHeader.jsp" />
	<h1>회원 탈퇴</h1>
	<div id='form'>
		<input type='password' id='pw' placeholder='비밀번호를 입력하세요.'>
		<button id='check'>회원 탈퇴</button>
	</div>

	<div class="modal">
		<div class="modal_content">
			<p id='contents'>확인되었습니다.정말 탈퇴하시겠습니까?</p>
			<button id='secssion'>확인</button>
			<button id='reject'>취소</button>
		</div>
	</div>

</body>
</html>