<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {
	text-align: center;
	cursor: pointer;
}
</style>
</head>

<script src='js/jquery.js'></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script>
	$(function() {
		sessionStorage.setItem("popUp","no"); //개발 등록 페이지/팝업창 구분 위함
		
		let ctx = document.getElementById('bar-chart').getContext('2d'); // getContext('2d') >> 표를 2d로 보여줌 

		let chart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : getMname(), //미션 이름 리스트
				datasets : [ {
					label : '성공률', //막대 의미
					data : getPercentage(), //미션 별 성공률
					backgroundColor : "lightblue"
				} ]
			},
			// 그래프 꾸미기
			options : {
				title : {
					display : true,
					text : '미션 별 성공률', //그래프 제목
					fontSize : 30
				},
				legend : {
					labels : {
						fontColor : 'rgba(83, 51, 237, 1)',
						fontSize : 15
					}
				},
				scales : {
					//x축
					xAxes : [ {
						ticks : {
							fontColor : 'darkblue',
							fontSize : '15'
						}
					} ],
					//y축
					yAxes : [ {
						ticks : {
							beginAtZero : true,
							fontColor : 'red',
							fontSize : '15'
						}
					} ]
				}
			}
		})
	})
	function getMname() {
		let list = [];
		$.ajax({
			url : "GetMissionName",
			type : "get",
			async : false,
			dataType : "text",
			success : function(data) {
				let json = JSON.parse(data);
				for (let i = 0; i < json.length; i++) {
					list[i] = json[i].mname;
				}
			}
		})
		return list;
	}

	function getPercentage() {
		let list = [];
		$.ajax({
			url : "GetMissionPercentage",
			type : "post",
			async : false,
			dataType : "text",
			success : function(data) {
				let json = JSON.parse(data);
				for (let i = 0; i < json.length; i++) {
					list[i] = (json[i].percentage);
				}
			}
		})
		return list;
	}
</script>
<body>
	<jsp:include page="adminHeader.jsp" />

	<div id='wrap'
		style="position: relative; height: 800px; width: 600px; margin: auto; top: 200px;">
		<canvas id="bar-chart" width='500' height='500'></canvas>
	</div>
</body>
</html>