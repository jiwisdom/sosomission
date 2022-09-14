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
	cursor :pointer;
}

#tbl {
	margin: auto;
	border-collapse: collapse;
}

th {
	width: 71px;
	height: 57px;
	position: relative;
}

#move {font-size: xx-large;}

p {display: inline;}

span:hover {color: red;}

img {
	width: 71px;
	height: 57px;
}

.picture_num {
	position: absolute;
	z-index: 1;
	top: 5px;
	left : 0px;
	color: white;
}
#wrap{
	margin:30px;

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
.modal {
	position: absolute;
	width: 100%;
	height: 100%;
	background: grey;
	top: 0;
	left: 0;	
}

.modal_content {
	width: 500px;
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

	document.addEventListener("DOMContentLoaded", function(){
		if(sessionStorage.getItem("alert")=='one'){
			ShowNewMission();
			document.querySelector("#click").addEventListener("click",function(){
				$(".modal").fadeOut();
				calendar(year, month, dayOfWeek, lastDay);	
				sessionStorage.setItem("alert","no");
			})
			
		}else{
			$(".modal").remove();
			calendar(year, month, dayOfWeek, lastDay);
		}
	});
	
	let date = new Date();
	let year = date.getFullYear();
	let month = date.getMonth() + 1;
	//달의 마지막 날+요일 구하기
	let endDay = new Date(year, month, 0);
	//달의 마지막 날짜 구하기
	let lastDay = endDay.getDate();
	//달의 시작 요일 구하기
	let preDay = new Date(year, month - 1, 0); //저번 달 마지막 날 구하기
	let dayOfWeek = preDay.getDay() + 2; // (preDay.getDay는 0~6으로 표시됨)+ 2 == 이번 달 첫번째 요일 >> th_num이 1로 시작함

	
	//달력 만드는 함수
	function calendar(year, month, dayOfWeek, lastDay) {
		let doMissionList = getDate(year,month);
		let usePointList = getUsePointDate(year,month);
		
		let tbl_calendar = document.createElement("tbody");
		document.querySelector("#tbl").append(tbl_calendar);
		tbl_calendar.setAttribute("id","tbl_calendar");
		document.querySelector("#tbl_calendar").innerHTML = "<tr><th>일요일</th><th>월요일</th><th>화요일</th><th>수요일</th><th>목요일</th><th>금요일</th><th>토요일</th></tr>";

		document.querySelector("#year_month").innerHTML  = year + "년 " + month + "월";

		let date = 1; //날짜

		let th_num = 1; //th의 id명 그림 넣을 떄 필요

		let cal_date = year + "-" + month + "-" + date;

		//주는 6주로 고정 >> 그림 42조각으로 할거임
		for (let i = 1; i <= 6; i++) {
			let tr = document.createElement("tr");
			tr.setAttribute("id",i+"주");
			document.querySelector("#tbl_calendar").append(tr);
			
			//th가 7번 생성되게 함
			for (let num = 1; num <= 7; num++) {
				
				//th의 id 값이 달의 시작 날보다 작으면 date는 없음
				if (th_num < dayOfWeek) {
					date = "";
				}
					//해당 달의 1일 부터 마지막 날까지
				if (date>=1 &&  date<= lastDay) {
					let th = document.createElement("th");
					th.setAttribute("id",th_num);
					th.innerHTML = date;
					document.getElementById(i + "주").append(th);
					
					//포인트 사용 시 
					document.getElementById(th_num).addEventListener("click",function(e){
						if(sessionStorage.getItem("point")!=0){
							let check = confirm("포인트 사용하시겠습니까?");
							if(check){
								$.ajax({
									url :"usePoint",
									type :"get",
									data : {useDay : year+"-"+month+"-"+document.getElementById(e.target.getAttribute("id")).innerHTML},
									dataType:"text",
									success : function(data){
										alert(data);
										if(data.includes("포인트 사용!")){
											location.reload();
										}
									}
								})
							}
						}else {
							alert("포인트가 없습니다..");
						}
					})
					
					let full_date = year+"-"+month+"-"+date;
					
					for(let n=0;n<doMissionList.length;n++){
						if(doMissionList[n] == full_date)	{
							
							document.getElementById(th_num).remove();

							let img_th = document.createElement("th");
							let img_a = document.createElement("a");

							img_th.setAttribute("id",th_num);
							img_a.setAttribute("id",'num'+th_num);
							img_a.setAttribute("class",'picture_num');
							img_a.innerHTML = date;
							img_th.innerHTML = "<img src='pictures/"+month+"/"+th_num+".jpg'>";

							document.getElementById(i+"주").append(img_th);
							document.getElementById(th_num).appendChild(img_a);
							
							document.getElementById(th_num).addEventListener("mouseover",function(e){	
								  e.target.style.color = "orange";
							
							})
							document.getElementById(th_num).addEventListener("mouseout",function(e){
								 e.target.style.color = "white";	
							})
							
							document.getElementById(th_num).addEventListener("click",function(e){	
								let send =full_date;
								window.open("comment?send_date="
										+send,"후기","width=300px; height=300px; left=1200px; top=300px;");
							});
						}
					}  

					
					//포인트 사용한 애들 가져오기
					
					for(let n=0;n<usePointList.length;n++){
						if(usePointList[n] == full_date)	{
							document.getElementById(th_num).remove();
							let img_th = document.createElement("th");
							let img_a = document.createElement("a");

							img_th.setAttribute("id",th_num);
							img_a.setAttribute("id",'num'+th_num);
							img_a.setAttribute("class",'picture_num');
							img_a.innerHTML = date;
							img_th.innerHTML = "<img src='pictures/"+month+"/"+th_num+".jpg'>";
							img_a.style.color = "black";

							document.getElementById(i+"주").append(img_th);
							document.getElementById(th_num).appendChild(img_a);

							for(let mission_date=0;mission_date<doMissionList.length;mission_date++){
		                        if(doMissionList[mission_date] == usePointList[n])   {
		                           img_a.style.color = "white";
		                           document.getElementById(th_num).addEventListener("mouseover",function(e){   
		                                e.target.style.color = "orange";
		                           
		                           })
		                           document.getElementById(th_num).addEventListener("mouseout",function(e){
		                               e.target.style.color = "white";   
		                           })
		                           
		                           document.getElementById(th_num).addEventListener("click",function(e){   
		                              let send =full_date;
		                              window.open("comment?send_date="
				                              +send,"후기","width=300px; height=300px; left=1200px; top=300px;");
		                              
		                           });
		                        }
		                     }   
						}
					}  
					
					//42개의 th 중 날짜칸에 해당하지 않는 애들
				} else if (date > lastDay || date=="") {

					let th = document.createElement("th");
					th.setAttribute("id",th_num);
					th.innerHTML = "<img src='pictures/"+month+"/"+th_num+".jpg'>";
					document.getElementById(i + "주").append(th);
				}
				th_num++;
				date++;
			}//th 생성 끝
		}//주 끝
	}

	//이전 달
	function movePreMonth() {
		month = month-1;
		if (month < 1) {
			month = 12;
			year = year - 1;
		}
		
		let endDay = new Date(year, month, 0);
		let lastDay = endDay.getDate();
		let preDay = new Date(year, month - 1, 0); //저번 달 마지막 날 구하기
		let dayOfWeek = preDay.getDay() + 2; //저번 달 마지막 요일 + 1 == 이번 달 첫번째 요일
		calendar(year, month, dayOfWeek, lastDay);
	}
	// 다음 달
	function moveNextMonth() {
		month = (month+1);
		if (month > 12) {
			month = 1;
			year = year + 1;
		}
		let endDay = new Date(year, month, 0);
		let lastDay = endDay.getDate();
		let preDay = new Date(year, month - 1, 0); //저번 달 마지막 날 구하기
		let dayOfWeek = preDay.getDay() + 2; //저번 달 마지막 요일 + 1 == 이번 달 첫번째 요일
		calendar(year, month, dayOfWeek, lastDay);
	}

	//미션 할 날 가져오는 함수
	function getDate(year,month) {
		month = ("0" + month).slice(-2);
		let list = []; 
		$.ajax({
			url : "doMissionList",
			type : "get",
			async :false,
			data : {month : year+"-"+month},
			dataType : "text",
			success : function(data) {
				let json = JSON.parse(data);
				for(let i=0;i<json.length;i++){
					list[i] = json[i].startDate;
				}
			}
		})

		return list;
	}
	
	function getUsePointDate(year,month) {
		month = ("0" + month).slice(-2);
		let list = []; 
		$.ajax({
			url : "usePointList",
			type : "post",
			async :false,
			data : {month : year+"-"+month},
			dataType : "text",
			success : function(data) {
				let json = JSON.parse(data);
				for(let i=0; i<json.length;i++){
					list[i] = json[i].usePointDate;
				}
			}
		})
		return list;
	}
	function ShowNewMission(){
		$.ajax({
			url :"alterNewMission",
			type:"get",
			async :false,
			dataType: "text",
			success : function(data){
				$("#newMission").append(data);
			}
		})
	}

</script>

<body>
	<jsp:include page="userHeader.jsp"/>
	<div id='wrap'>
		<div id='move'>
		<span onclick="movePreMonth()"><<</span>&nbsp;
		<p id='year_month'></p>
		&nbsp; <span onclick="moveNextMonth()">>></span>
	</div>
	<br>
	<table border='1' id='tbl'>
	</table>
	</div>
	<div class="modal">
		<div class="modal_content">
			<p id='newMission'></p>
			<br>
			<button id='click'>확인</button>
		</div>
	</div>
		
</body>
</html>