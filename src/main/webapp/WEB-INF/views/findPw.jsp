<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
* {text-align: center;
}
#show {
	border: 3px solid lightblue;
	border-radius: 10px;
	text-align: center;
	width: 200px;
}
#form {
	border: 3px solid lightblue;
	border-radius: 10px;
	width: 250px;
	height: 120px;
	text-align: center;
	line-height: 40px;
}
input {
	border: 2px solid lightblue;
	outline : lightblue;
}

#btn,#findPw {
	display : inline-block;
	margin : 2px;
	border-radius: 10px;
	border: 2px solid lightblue;
	background-color : transparent;
}

#btn:hover,#findId:hover {
	background-color: lightblue;
	transition-duration: 1s;
	color: white;
	outline: none;
}
</style>
<script src='js/jquery.js'></script>
<script>
$(function(){
	document.getElementById("findPw").addEventListener("click",function(){
		$.ajax({
			url :"findPw.do", 
			type : "get",
			data : {id : document.getElementById("id").value,
					tel : document.getElementById("tel").value	
			},
			dataType : "text",
			success : function(data){
				document.getElementById("form").remove();
				
				let idDiv = document.createElement("div"); 
				idDiv.setAttribute("id","show");
				idDiv.innerText = data;

				const closeBtn = document.createElement("button");
				closeBtn.innerText = "닫기";
				closeBtn.setAttribute("id","btn");
				closeBtn.setAttribute("onclick","window_close()");

				document.getElementById("form2").appendChild(idDiv);
				document.getElementById("show").appendChild(closeBtn);
			
			}
		})
	})
	
})
function window_close(){
	window.close();
}
	
</script>
<body>
	<div id='form'>
		<table>
			<tr>
				<td>id</td>
				<th><input type='text' id='id'></th>
			</tr>	
			
			<tr>
				<td>tel</td>
				<th><input type='text' id='tel'></th>
			</tr>
			<tr>
				<th colspan='2'><button id='findPw'>찾기</button></th>
			</tr>
		</table>
	</div>
	
	<div id='form2'>
	</div>
		
</body>
</html>