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
h1 {
	background-color: lightblue;
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
	padding:10px;
}
#tr {color: darkblue;}

#wrap {
	margin-top: 50px;
}
.a:hover {
	color: lightblue;
}
.page{
	cursor : pointer;
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
	$(function() {

		getMySugession("all", 1);

		$(document).on("click", ".page", function() {
			let page = $(this).attr("id");

			let searchVal = $("#search option:selected").val();
			getMySugession(searchVal, page);
		})
	})

	function searchSuggestion() {
		let searchVal = $("#search option:selected").val();
		getMySugession(searchVal, 1);
	}

	function getMySugession(mean, page) {
		$("#listTbody").remove();
		$("#tbl").append("<tbody id='listTbody'></tbody>");

			$.ajax({
					url : "MySuggestionList",
					type : "get",
					dataType : "text",
					data : {
						search : mean,
						page : page
					},
					success : function(data) {

						let list = JSON.parse(data);
						$("#listTbody")
								.append(
										"<tr id='tr'><th>번호</th><th>id</th><th>제목</th><th>날짜</th><th>상태</th></tr>");
						for (let i = 0; i < list.length; i++) {
							$("#listTbody")
									.append(
											"<tr><th>"
													+ list[i].suggest_num
													+ "</th><th>"
													+ list[i].id
													+ "</th><th><a href='suggestionContent?num="
													+ list[i].suggest_num
													+ "' class='a'>" + list[i].title
													+ "</th><th>"
													+ list[i].suggest_date
													+ "</th><th>"
													+ list[i].check_state
													+ "</th></tr>");

						}
						if(list.length<5){
							for(let i=0; i<(5-list.length);i++){
								$("#listTbody").append("<tr><th></th></tr>");
							}
						}
						let mok =  Math.floor(list[0].count/5);
						let remain = list[0].count%5;
						if(remain>=1) mok++;
						getCount(mok,page,mean);
						$("#"+page).css("color","blue");
					}
				})
	}

	function getCount(count,page,mean) {
		if(count>0){
			let floor = Math.floor((page-1)/5);
			let page_num = floor*5+1;
			$("#under").remove();
			$("#underTBL").append("<tr id='under'></tr>");
			
			if(count>5) $("#under").append("<a id='previousBlock' class='a'>◁</a>");
			$("#previousBlock").click(function(){
				if(page>5) {
					page_num-=5;
					getMySugession(mean,page_num);
				}
			})
			
			for(let i=page_num; i<=(page_num*5) ;i++){
				if(i>count) return;
				$("#under").append("<a class='page' id='"+i+"'>"+i+"</a>");
				$("#under").append("&nbsp;");
			}
			
			if(count>5)$("#under").append("<a id='nextBlock' class='a'>▷</a>");
			$("#nextBlock").click(function(){
				page_num+=5;
				getMySugession(mean, page_num);
			})
		}else {
			$("#under").remove();
			$("#underTBL").append("<tr id='under'></tr>");

			if($("#search option:selected").val()=="all"){
				$("#under").append("<a>제출된 제안서 없음</a>");
			}else {
				$("#under").append("<a>현재 "+$("#search option:selected").val()+"된 제안서 없음</a>");
			}
		}
	}
</script>
<body>
	<jsp:include page="userHeader.jsp" />
	<h1>미션 제안 결과</h1>

	<div id='wrapp'>
		<table id='tbl'>
			<tbody id='searchTbody'>
				<tr style='float: left;'>
					<th colspan='5'><select id='search'>
							<option value='all'>-검색-</option>
							<option value='all'>전체</option>
							<option value='미확인'>미확인</option>
							<option value='확인'>확인</option>
							<option value='검토'>검토</option>
							<option value='추가'>추가</option>
							<option value='보류'>보류</option>
							<option value='개발'>개발</option>
					</select>
						<button onclick='searchSuggestion()'>검색</button></th>
				</tr>
			</tbody>
			<tbody id='listTbody'></tbody>
		</table>
		<table id='underTBL'>
		</table>
	</div>
</body>
</html>