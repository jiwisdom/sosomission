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
* {
	font-size: medium;
	text-align: center;
}

#progressBar {
	margin: auto;
}

h1 {
	
	background-color: lightblue;
}

#comment {
	width: 500px;
	height: 300px;
	font-size: large;
	border: 2px solid lightblue;
	outline: lightblue;
	text-align: justify;
	vertical-align: top;
}

input[type=text] {
	width: 30px;
}

button {
	border: 2px solid lightblue;
	background-color: transparent;
	border-radius: 10px;
}

button:hover {
	background-color: lightblue;
	color: white;
	transition-duration: 1s;
}

#reply {
	border: 2px solid lightblue;
	outline: lightblue;
	font-size: large;
	width: 500px;
	height: 100px;
}

#replyText {
	border: 2px solid lightblue;
	font-size: large;
	width: 500px;
	height: 200px;
	margin: auto;
	padding: 10px;
}

.replyBtn {
	border: 2px solid lightblue;
	background-color: transparent;
	border-radius: 5px;
	widht: 20px;
}

.replyBtn:hover {
	background-color: lightblue;
	color: white;
	transition-duration: 1s;
}

#newReply {
	border: 3px solid lightblue;
	font-size: large;
	width: 500px;
	height: 100px;
	outline: lightblue;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		getReplyList()
		
		if('${requestScope.suggest_num}'=='0'){
			$("#conversation").hide();
		}
		
		let admin = sessionStorage.getItem("admin");
		if (admin == "yes") {
			$("#html").removeAttr("disabled");
			$("#css").removeAttr("disabled");
			$("#js").removeAttr("disabled");
			$("#java").removeAttr("disabled");
			$("#update").removeAttr("disabled");
			$("#comment").removeAttr("disabled");
		}

		if ($("#html").val() >= 85 && $("#css").val() >= 85
				&& $("#js").val() >= 85 && $("#java").val() >= 85) {

			$("#progressBar").mouseleave(function() {
								$("#addMission").remove();
								if ($("#html").val() < 85
										|| $("#css").val() < 85
										|| $("#js").val() < 85
										|| $("#java").val() < 85) {
									$("#addMission").remove();

								} else if ($("#html").val() >= 85
										&& $("#css").val() >= 85
										&& $("#js").val() >= 85
										&& $("#java").val() >= 85) {
									$("#btns").append(
												"<button id='addMission'>?????? ??????</button>");
								}
							})

			$("#btns").append("<button id='addMission'>?????? ??????</button>");

		} else {
			$("#progressBar").mouseleave(
					function() {
						$("#addMission").remove();

						if ($("#html").val() >= 85 && $("#css").val() >= 85
								&& $("#js").val() >= 85
								&& $("#java").val() >= 85) {
							$("#btns").append(
									"<button id='addMission'>?????? ??????</button>");
						}
					})
		}

		$(document).on("click", "#update", function() {
			$.ajax({
				url : "updateProgressContent",
				type : "post",
				data : {
					title : $("#title").html(),
					comment : $("#comment").val(),
					html : $("#html").val(),
					css : $("#css").val(),
					js : $("#js").val(),
					java : $("#java").val()
				},
				dataType : "text",
				success : function(data) {
					alert(data);
					location.reload();
				}
			})
		})

		$(document).on("click","#addMission",
				function() {

					if ($("#html").val() >= 85 && $("#css").val() >= 85
							&& $("#js").val() >= 85 && $("#java").val()) {
						$.ajax({
							url : "addNewMission",
							type : "get",
							data : {
								reply : $("#replyText").val(),
								title : $("#title").html(),
								comment : $("#comment").val()
								
							},
							dataType : "text",
							success : function(data) {
								alert(data);
								$(location).attr("href", "missionList")
							}
						})
					}

				})

		$("#replyInsert").click(function() {
			if ($("#reply").val() != "") {
				$.ajax({
					url : "insertReply",
					type : "get",
					data : {
						reply : $("#reply").val(),
						title : '${requestScope.title }'
					},

					dataType : "text",
					success : function(data) {
						alert(data);
						if (data.includes("?????????????????????.")) {
							location.reload();
						}
					}
				})
			}
		})

		$("#moveMissionDevelopPage").click(function() {
			location.href = "moveMissionDevelopPage?title="+ $("#title").html() + "";
		})

		$("#updateReply").click(function(){
			let reply_num = $("#updateReply").val();
			$("#newReply").removeAttr("disabled");
			$("#updateReply").remove();
			$("#deleteReply").remove();
			$("#replybtns").append("<button id='realUpdate' class='replyBtn' value='"+reply_num+"'>??????!</button>")
		})
		
		$(document).on("click","#realUpdate",function(){
			$.ajax({
				url :"updateReply",
				type :"get",
				data :{
					reply_comment : $("#newReply").val(),
					reply_num : $("#realUpdate").val()
				},
				dataType:"text",
				success :function(data){
					alert(data);
					location.reload();
				}
			})
		})

		$("#deleteReply").click(function(){
			$.ajax({
				url :"deleteReply",
				type :"get",
				data :{reply_num : $("#deleteReply").val()},
				dataType:"text",
				success :function(data){
					alert(data);
					location.reload();
				}
			})
		})
	})

	function getReplyList() {
		$.ajax({
			url : "getReplyList",
			type : "post",
			data : {
				title : '${requestScope.title }'
			},
			dataType : "text",
			success : function(data) {
				let json = JSON.parse(data);

				$("#replyDiv").append("<textarea id='replyText' disabled>");
				for (let i = 0; i < json.length; i++) {
					$("#replyText").append(
							">>" + json[i].reply_comment + "\n ????????? "
									+ json[i].id + " | ???????????? "
									+ json[i].write_date + "\n\n");
				}
				$("#replyTbl").append("</textarea>");
			}
		})
	}
</script>
<body>

	<c:if test="${requestScope.admin =='admin'}">
		<jsp:include page="adminHeader.jsp" />
	</c:if>
	<c:if test="${requestScope.admin !='admin'}">
		<jsp:include page="userHeader.jsp" />
	</c:if>

	<h1>?????? ??????</h1>
	<h3 id='title'>${requestScope.title }</h3>
	<button id='moveMissionDevelopPage'>?????? ????????? ??????</button>

	<table id='progressBar'>
		<tr>
			<th>html <progress id='htmlPro' value='${requestScope.html }'
					max='100'></progress>
			</th>
			<th><input type='text' class='pro' id='html' disabled
				value='${requestScope.html }'>%</th>
		</tr>
		<tr>
			<th>css <progress id='cssPro' value='${requestScope.css }'
					max='100'></progress></th>
			<th><input type='text' class='pro' id='css' disabled
				value='${requestScope.css }'>%</th>
		</tr>
		<tr>
			<th>js <progress id='jsPro' value='${requestScope.js }'
					max='100'></progress></th>
			<th><input type='text' class='pro' id='js' disabled
				value='${requestScope.js }'>%</th>
		</tr>
		<tr>
			<th>java <progress id='javaPro' value='${requestScope.java }'
					max='100'></progress></th>
			<th><input type='text' class='pro' id='java' disabled
				value='${requestScope.java }'>%</th>
		</tr>
	</table>
	<p>?????? ?????? ??????</p>
	<textarea id='comment' disabled>${requestScope.comment }
	</textarea>

	<div id='btns'>
		<button id='update' disabled>?????? ?????? ??????</button>
	</div>
	<br>
	<br>
	<div id='conversation'>
		<p>?????????-????????? ??????</p>
		<div id='replyDiv'></div>
		<br>

		<c:if test="${requestScope.noReply !='noReply' }">
			<p>????????? ??????</p>
			<textarea id=newReply disabled>${requestScope.newReply }</textarea>
			<br>
			<span> ????????? ${requestScope.writer } | ?????? ??????
				${requestScope.write_date }&nbsp;&nbsp; </span>

			<c:if test="${requestScope.writer == requestScope.id }">
				<span id='replybtns'><button id='updateReply'
						class='replyBtn' value=${requestScope.reply_num }>??????</button>
					&nbsp;
					<button id='deleteReply' class='replyBtn'
						value=${requestScope.reply_num }>??????</button> </span>
			</c:if>
		</c:if>
		<br> <br> <span>?????? ?????????</span>
		<div>
			<textarea id='reply' placeholder='?????? ?????? ????????? ?????? ????????? ????????????:)'></textarea>
			<br>
			<button id='replyInsert' style='width: 60px;'>??????</button>
		</div>

	</div>

</body>
</html>