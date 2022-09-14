<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
a {
	text-decoration: none;
}

a:hover {
	color: lightblue;
}

* {text-align: center;
}

h1 {
	background-color: lightblue;
}

#section {
	margin: 20px;
}

#tbl,#underTBL {
	margin: auto;
	border-collapse: collapse;
	overflow: hidden;
}
#tbl{
	display : fixed;
	width: 700px;
	height :400px;
}
tr{
	height :20px;
}
tr,th{
	padding:5px;
}
th{
	word-break:break-all;
}
#tr {color: darkblue;}

#wrap {
	margin-top: 50px;
}
.page{
	font-size:large;
}
button {
	width: 50px;
	height: 20px;
	border: 3px solid lightblue;
	border-radius: 10%;
	border: none;
}

button:hover {
	background-color: lightblue;
	color: white;
	outline: none;
}
</style>
<script src='js/jquery.js'></script>
<script>
	$(function() {
		showAllSecMember(1, "all", "");
		
		$("#search").click(function() {

			let column = $("#column option:selected").val();
			let mean = $("#mean").val();
			showAllSecMember(1, column, mean);
		})

		$(document).on("click", ".page", function() {
			let page = $(this).attr("id");
			let column = $("#column option:selected").val();
			let mean = $("#mean").val();
			showAllSecMember(page, column, mean);
		})

	})
	function showAllSecMember(page, column, mean) {
		
			$.ajax({
					url : "getMemberDeleteList",
					type : "get",
					data : {
						page : page,
						column : column,
						mean : mean
					},
					dataType : "text",
					success : function(data) {
						$("#list").remove();
						$("#tbl").append("<tbody id='list'></tbody>");
						let list = JSON.parse(data);
						$("#list").append("<tr id='tr'><th>id</th><th>pw</th><th>name</th><th>tel</th><th>email</th><th>reg_date</th><th>sec_date</th></tr>");
						for (let i = 0; i < list.length; i++) {
							$("#list").append(
									"<tr><th>" + list[i].id + "</th><th>"
											+ list[i].pw + "</th><th>"
											+ list[i].name + "</th><th>"
											+ list[i].tel + "</th><th>"
											+ list[i].email + "</th><th>"
											+ list[i].reg_date + "</th><th>"
											+ list[i].sec_date+"</th></tr>");
							
						}
						if(list.length<5){
							for(let i=0; i<(5-list.length);i++){
								$("#list").append("<tr><th></th></tr>");
							}
						}
						let mok =  Math.floor(list[0].count/5);
						let remain = list[0].count%5;
						if(remain>=1) mok++;
						
						getCount(mok,page,column,mean);
						$("#"+page).css("color","blue")
					}
				})
	}
	
	function getCount(mok,page,column,mean) {
		if(mok>0){
			let floor = Math.floor((page-1)/5);
			let page_num = floor*5+1;
			$("#under").remove();
			$("#underTBL").append("<tr id='under'></tr>");
			
			if(mok>5) $("#under").append("<a id='previousBlock'>◁</a>");
			$("#previousBlock").click(function(){
				if(page>5) {
					page_num-=5;
					showAllSecMember(page_num, column, mean);
				}
			})
			
			for(let i=page_num; i<=(page_num*5) ;i++){
				if(i>mok) return;
				$("#under").append("<a class='page' id='"+i+"'>"+i+"</a>");
				$("#under").append("&nbsp;");
			}
			
			if(mok>5)$("#under").append("<a id='nextBlock'>▷</a>");
			$("#nextBlock").click(function(){
				page_num+=5;
				showAllSecMember(page_num, column, mean);
			})
			
		}else {
			$("#under").remove();
			$("#underTBL").append("<tr id='under'></tr>");
			if($("#column option:selected").val()=="all"){
				$("#under").append("<a> 탈퇴 회원 없음 </a>");
			}else if($("#column option:selected").val()=="id"){
				$("#under").append("<a> id가 "+ $("#mean").val()+"인 탈퇴 회원 없음</a>");
			}else if($("#column option:selected").val()=="name"){
				$("#under").append("<a> 이름이 "+ $("#mean").val()+"인 탈퇴 회원 없음</a>");
			}	
			
		}
	}
</script>
<body>
	<jsp:include page="adminHeader.jsp" />
	<h1>탈퇴 회원 정보 관리</h1>
	<div id='wrap'>

		<table id='tbl'>
			<tr>
				<th><select id='column'>
						<option value='all'>-검색-</option>
						<option value='all'>전체</option>
						<option value='id'>id</option>
						<option value='name'>이름</option>
				</select></th>
				<th><input type='text' id='mean' style='width: 80px;'></th>
				<th><button id='search'>검색</button></th>
			</tr>
			<tbody id='list'></tbody>
		</table>
		<table id='underTBL'>
		</table>
	</div>
</body>
</html>