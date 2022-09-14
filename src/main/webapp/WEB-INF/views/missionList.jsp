<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {text-align: center;
}
h1{background-color: lightblue;}

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
#tr {
	color: darkblue;
	height : 10px;
}

#wrap {
	margin-top: 50px;
}
a:hover{color :lightblue;}

.page{
	font-size:large;
}

</style>
</head>
<script src='js/jquery.js'></script>
<script>
$(function(){
	
	getAllMission(1);
	
	$(document).on("click",".page",function(){
		let page = $(this).attr("id");
		getAllMission(page);
	})
})

	
	function getAllMission(page){
		
		$("#listTbody").remove();
		$("#tbl").append("<tbody id='listTbody'></tbody>");
		$.ajax({
			url : "getMissionList",
			type: "post",
			dataType : "text",
			data : {page:page},
			success : function(data){
				let list = JSON.parse(data);
				
				$("#listTbody").append("<tr id='tr'><th>번호</th><th>제목</th><th>주소</th><th>등록날짜</th></tr>");
				for(let i=0;i<list.length;i++){
					$("#listTbody").append("<tr><th>"
									+ list[i].num
									+ "</th><th>"
									+ list[i].name
									+ "</th><th><a href='"+list[i].page+"'>"
									+ list[i].page
									+ "</a></th><th>"
									+ list[i].date
									+ "</th></tr>");
					
				}
				
				if(list.length<5){
					for(let i=0;i<(5-list.length);i++){
						$("#listTbody").append("<tr><th></th></tr>");
					}
				}
				
				let mok = list[0].count/5;
				let remain = list[0].count%5;
				if(remain>=1) mok++;
				
				document.getElementById("underTBL").innreHTML = getCount(mok,page);
				document.getElementById(page).style.color = "blue";
				
			}
		})
	}
	
	function getCount(count,page){
	
		if(count>0){
			let floor = Math.floor((page-1)/5);
			let page_num = floor*5+1;
			$("#under").remove();
			$("#underTBL").append("<tr id='under'></tr>");
			
			if(count>5) $("#under").append("<a id='previousBlock'>◁</a>");
			$("#previousBlock").click(function(){
				if(page>5) {
					page-=5;
					getAllMission(page);
				}
			})
			
			for(let i=page_num; i<=(page_num*5) ;i++){
				if(i>count) return;
				$("#under").append("<a class='page' id='"+i+"'>"+i+"</a>");
				$("#under").append("&nbsp;");
			}
			
			if(count>5)$("#under").append("<a id='nextBlock'>▷</a>");
			$("#nextBlock").click(function(){
				page+=5;
				getAllMission(page);
			})
		}
	}
	
</script>
<body>
<jsp:include page="adminHeader.jsp"/>
<h1>미션 목록</h1>
<br>
	<div id='wrap'>
		<table id='tbl'>
			<tbody id='listTbody'></tbody>
		</table>
		<table id='underTBL'>
		</table>
	</div>
</body>
</html>