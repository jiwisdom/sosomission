<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
a {
	text-decoration: none;
}

a:hover {
	color: lightblue;
}

* {
	text-align: center;
}

h1 {
	background-color: lightblue;
}

#tbl, #underTBL {
	margin: auto;
	border-collapse: collapse;
	overflow: hidden;
}

#tbl {
	display: fixed;
	width: 700px;
	height: 400px;
}

tr {
	height: 20px;
}

tr, th {
	padding: 10px;
}

#tr {
	color: darkblue;
}

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
</head>
<script src='js/jquery.js'></script>
<script>
$(function(){
	showList(1,"all","");
	
	$(document).on("click",".progressBar",function(){
		
		let title = $(this).data("value");
		let url = 'progressBar?title='+title+'';
		
		window.open(url,"진행상황",
				"width=300px; height=200px; left=600px; top=300px;");
	})
	
	$("#search").click(function(){
		let column = $("#column option:selected").val();
		let mean = $("#mean").val();
		showList(1,column,mean);
	})
	
	$(document).on("click",".page",function(){
	
		let page = $(this).attr("id");
		let column = $("#column option:selected").val();
		let mean = $("#mean").val();
		showList(page,column,mean);
	})
	
})

function showList(page,column,mean){
	
	$.ajax({
		url :"getDevelopmentList",
		type :"get", 	
		data : {
			page : page,
			column : column,
			mean : mean
		},
		dataType : "text",
		success : function(data){
			$("#list").remove();
			$("#tbl").append("<tbody id='list'></tbody>");
			
			let list = JSON.parse(data);
			
			$("#list").append("<tr id='tr'><th>title</th><th>mission page</th><th>startDate</th><th>updateDate</th><th>개발담당</th><th>progressBar</th></tr>");
			for(let i=0; i<list.length;i++){
				if(list[i].title!=""){
					$("#list").append("<tr>");
					$("#list").append("<th ><a href='showDevelopmentContent?url="+list[i].url+"&title="+list[i].title+"'>"+list[i].title+"</a></th>");
					$("#list").append("<th><a href='"+list[i].url+"'>"+list[i].url+"</a></th>");
					$("#list").append("<th>"+list[i].startDate+"</th>");
					
					if(list[i].startDate != list[i].updateDate){
						$("#list").append("<th>"+list[i].updateDate+"</th>");
					}else {
						$("#list").append("<th>아직 안만듦</th>");
					}
					$("#list").append("<th>"+list[i].id+"</th>");
					
					$("#list").append("<th><progress class='progressBar' data-value="+list[i].title+" value='"+list[i].avg+"' max ='100'></progress></th>");
					$("#list").append("</tr>");
				}
				
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

function getCount(count,page,column,mean){
	if(count>0){
		let floor = Math.floor((page-1)/5);
		let page_num = floor*5+1;
		
		$("#under").remove();
		$("#underTBL").append("<tr id='under'></tr>");
		
		if(count>5) $("#under").append("<a id='previousBlock'>◁</a>");
		
		$("#previousBlock").click(function(){
			if(page>5) {
				page_num-=5;
				showList(page_num,column,mean);
			}
		})
		
		for(let i=page_num; i<=page_num*5 ;i++){
			if(i>count) return;
			$("#under").append("<a class='page' id='"+i+"'>"+i+"</a>");
			$("#under").append("&nbsp;");
		}
		
		if(count>5)$("#under").append("<a id='nextBlock'>▷</a>");
		
		$("#nextBlock").click(function(){
			page_num+=5;
			showList(page_num,column,mean);
		})
	}else {
		$("#under").remove();
		$("#underTBL").append("<tr id='under'></tr>");

		if($("#column option:selected").val()=="all"){
			$("#under").append("<a> 현재 개발 중인 미션 없음</a>");
			
		}else if($("#column option:selected").val()=="title"){
				$("#under").append("<a> 미션 제목이 "
						+$("#mean").val()+"인 개발 정보 없음</a>");
				
		}else if($("#column option:selected").val()=="id"){
				$("#under").append("<a> 개발담당자가 "
						+$("#mean").val()+"인 개발 정보 없음</a>");
		}	
	}
}

</script>
<body>
	<jsp:include page="adminHeader.jsp" />
	<h2>개발 중인 미션 목록</h2>
	<div id='wrap'>
		<table id='tbl'>
			<tr>
				<th><select id='column'>
						<option value='all'>-검색-</option>
						<option value='all'>전체</option>
						<option value='title'>제목</option>
						<option value='id'>개발담당자</option>
				</select></th>
				<th><input type='text' id='mean'></th>
				<th><button id='search'>검색</button></th>
			</tr>
			<tbody id='list'></tbody>
		</table>
		<table id='underTBL'>
		</table>
	</div>
</body>
</html>