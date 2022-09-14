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

#comments {
	width: 300px;
	height: 200px;
	border: 3px solid lightblue;
	outline : lightblue;
	overflow: scrolldown;
}

.save {
	width: 50px;
	height: 30px;
	border: 3px solid lightblue;
	border-radius: 10%;
	border: none;
}

.save:hover {
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}
</style>
</head>
<body>
	<script src="js/jquery.js"></script>
	<script>
		$(function() {
			let fail = sessionStorage.getItem("fail");
			let date = sessionStorage.getItem("startDate");
			let time = sessionStorage.getItem("startTime");
			alert(fail);
			
			$("#comments").on("input",function(){
				$("#commentSave").attr('disabled', false);
				$("#main").hide();
				if($("#comments").val()==""){
					$("#main").show();
					$("#commentSave").attr('disabled', true);
				}
			})
			
			$(".save").click(function() {
				$.ajax({
					url : "writeComment",
					type : "post",
					data : {
						comments : $("#comments").val(),
						time : time,
						date : date,
						fail : fail
					},
					dataType : "text",
					success : function(data) {
						alert(data);
						if (data.includes("메인 화면으로 이동합니다.")) {
							opener.location.href = "userMain";
							window.close();
						}
					}
				})
			})
		})
	</script>
</body>
<h1>후기 작성</h1>
<input type="button" class="save" id='main' value="나가기">
<br><br>
<textarea id="comments" placeholder='후기를 남겨보세요~'></textarea>
<br>
<input type="button" class="save" id='commentSave' value="저장" disabled>

</html>