<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
* {text-align: center;
	cursor :pointer;
}
body{
	background-image : url('/pictures/background_img/travel.jpg');
	background-size : cover;
}
h1 {background-color: lightblue;}
div{margin:auto;}
header{
	height:90px;
	width : 100%;
	position :absolute;
}
#wrap{
	margin-top : 80px;
}
.content {
	display: block;
	background: #50627F;
	color: white;
	text-align: center;
	height: auto;
	line-height: 22px;
	border-radius: 4px;
	padding: 0px 10px;
}

.content2 {
	display: block;
	background: #50627F;
	color: white;
	text-align: center;
	width: 300px;
	height: auto;
	line-height: 22px;
	border-radius: 4px;
	padding: 0px 10px;
}

#chance {
	text-align:center;
	font-weight: bold;
	font-size: large;
}

img {
	width: 200px;
	heifht: 200px;
}

.overlaybox {
	background: #50627F;
	color: white;
}

p {
	margin: 0;
	padding: 0;
	width: 200px;
	height: 100px;
	white-space: normal;
	overflow: auto;
}

p::-webkit-scrollbar {
	width: 10px;
	background-color: black;
}
</style>
<script src='js/jquery.js'></script>
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=3d11cd79bae9d9a252f0519f4e91af50"></script>
<script>
	$(function() {
		let chance =5;
		let check=0;
		let fail=0;
		document.getElementById('chance').innerHTML ="기회 : "+ chance+"회";
		
		let mapContainer = document.getElementById('map') // 지도를 표시할 div 
		let mapOption = {
			center : new kakao.maps.LatLng(36.3063646, 127.5712809), // 지도 중심 : 옥천
			level : 15
		// 지도의 확대 레벨
		};

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		let map = new kakao.maps.Map(mapContainer, mapOption);
		// 마커가 표시될 위치입니다 
		
		let positions = [ {
			title : '함안',
			latlng : new kakao.maps.LatLng(35.2725591, 128.4064797),
			content :  
			'<div class="overlaybox">함안-낙화놀이<br><img src="pictures/location/함안낙화놀이.jpg">' 
		  	+'<div class="info"><p>군민의 안녕을 기원하는 뜻에서 매년 석가탄신일에 무진정 일대에서 열리는 함안 고유의 민속놀이다.'
		  	+'함안 낙화놀이는 연등과 연등사이에 참나무 숯가루로 만든 낙화를 매달아 이 낙화에 불을 붙여 꽃가루처럼 물위에 날리는 불꽃놀이이다.' 
		    +'</p></div>' 
		    +'</div>',
			expression :'<span class="content">낙화놀이</span>', 
		}, {
			title : '여수',
			latlng : new kakao.maps.LatLng(34.7603737,127.6622221),
			content : 
				'<div class="overlaybox">여수-오동도<br><img src="pictures/location/여수오동도.jpg">' 
			  	+'<div class="info"><p>섬의 이름은 오동나무에서 유래했는데,섬의 모양이 오동나무 잎을 닮았고, 섬에 오동나무가 울창한 숲을 이루고 있었다고 한다.'
			  	+'국내에서 손꼽히는 동백꽃 자생지이며 해식애가 발달해 여러 기암절벽들이 존재하고 있다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">오동도</span>' 
		}, {
			title : '춘천',
			latlng : new kakao.maps.LatLng(37.7917117,127.5255207),
			content : 
				'<div class="overlaybox">춘천-남이섬<br><img src="pictures/location/춘천남이섬.jpg">' 
			  	+'<div class="info"><p>나미나라 공화국이라는 남이섬 위에 세워진 국가 개념을 표방하는 특수 관광지라는 컨셉을 쓰고 있다.'
			  	+'남이섬은 나미나라공화국(Naminara Republic)은 남이섬 위에 세워진 국가 개념을 표방하는 특수 관광지로,'
			  	+'독자적인 외교와 문화 정책을 펼치고 있습니다. 전 세계 관광객들에게 아름다운 동화와 노래를 선물하는, 이 세상에 유일무이한 상상공화국이다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">남이섬</span>' 
		}, {
			title : '경주',
			latlng : new kakao.maps.LatLng(35.7900971,129.3320924),
			content : 
				'<div class="overlaybox">경주-불국사<br><img src="pictures/location/경주불국사.jpg">' 
			  	+'<div class="info"><p>불국사는 대한민국의 보물 제1744호이다.'
			  	+'경내에는 통일신라 시대에 만들어진 다보탑과, 석가탑으로 불리는 3층 석탑, 자하문으로 오르는 청운·백운교, 극락전으로 오르는 연화·칠보교가 국보로 지정, 보존되어 있다. ' 
			  	+'아울러 비로전에 모신 금동비로자나불좌상과 극락전에 모신 금동아미타여래좌상을 비롯한 다수의 문화유산도 당시의 찬란했던 불교문화를 되새기게 한다. 이러한 가치를 인정받아 1995년 12월에 석굴암과 함께 세계유산에 등재되었다.'
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">불국사</span>' 
		}, {
			title : "태안",
			latlng : new kakao.maps.LatLng(36.7456421,126.2980528),
			content : 
				'<div class="overlaybox">태안-신두리 해안사구<br><img src="pictures/location/태안신두리해안사구.jpg">' 
			  	+'<div class="info"><p>태안 신두리 해안사구는 충청남도 태안군 원북면 신두리에 있는 한국 최대의 해안사구이다. 대한민국의 천연기념물 제431호로 지정되어 있다.'
			  	+'신두리 해안사구는 전형적인 생태관광지로서도 가치가 있는 지역이며 폭풍이나 해일로부터 해안선을 보호하면서 인간과 사구 생명체에게 지하수를 공급하는 유익한 기능을 담당하고 있다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">신두리 해안사구</span>' 
		}, {
			title : "전주",
			latlng : new kakao.maps.LatLng(35.8147105,127.1526312),
			content :
				'<div class="overlaybox">전주-한옥마을<br><img src="pictures/location/전주한옥마을.jpg">' 
			  	+'<div class="info"><p>전주 풍남동 일대에 700여 채의 한옥이 군락을 이루고 있는 국내 최대 규모의 전통 한옥촌이며, 전국 유일의 도심 한옥군이다.'
			  	+'1910년 조성되기 시작한 우리나라 근대 주거문화 발달과정의 중요한 공간으로, 경기전, 오목대, 향교 등 중요 문화재와 20여개의 문화시설이 산재되어 있으며,'
			  	+'한옥, 한식, 한지, 한소리, 한복, 한방 등 韓스타일이 집약된 대한민국 대표 여행지이다.'
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">한옥마을</span>' 
		},{
			title : "옥천",
			latlng : new kakao.maps.LatLng(36.3907183,127.5534255),
			content : 
				'<div class="overlaybox">옥천-수생식물학습원<br><img src="pictures/location/옥천수생식물학습원.png">' 
			  	+'<div class="info"><p>수생식물학습원은 국내에서 3번째로 큰 대청호 한복판, 아름다운 호수정원 위에 자리 잡고 있다.'
			  	+'대청호 안에서 가장 뛰어난 경관이 펼쳐지는 곳으로 2003년부터 5가구의 주민들이 수생식물을 재배하고 번식, 보급하는 관경농업의 현장으로 시작되었다.'
			  	+'수련농장, 수생식물 농장, 온대수련 연못, 매실나무 과수원, 잔디광장, 산책로 등이 조성되어 있으며 수련, 가시연, 연꽃, 부레옥잠화, 물양귀비, 파피루스 등 다양한 수생식물을 감상할 수 있다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">수생식물학습원</span>' 
		},{
			title : "거제",
			latlng : new kakao.maps.LatLng(34.8806427,128.6210824),
			content : 
				'<div class="overlaybox">거제-바람의 언덕<br><img src="pictures/location/거제바람의언덕.jpg">' 
			  	+'<div class="info"><p>원래는 "띠밭늘" 이라고 불렸는데 이 곳이 시조과의 야생식물인 띠가 자란다고 하여서 불렸다가 바다와 접하여 바람이 분다는 언덕이라고 하여서 바람의 언덕이라고 불리고 있다.'
			  	+'북쪽과 서쪽, 동쪽으로는 남해안과 접하고 남쪽으로는 풍차와 거제 도장포마을이 있고 거제 해금강으로 가는 유람선선착장이 있다. 풍차는 2009년에 네덜란드풍의 풍차를 축조하여 완공하였으며 이 언덕의 랜드마크로 뽑히고 있다.'
			  	+'건너편에 신선들이 유랑을 하였다는 거제 신선대가 있고 바다 건너로 거제 해금강과 외도가 접해있다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">바람의 언덕</span>' 
		},
		{
			title : "인제",
			latlng : new kakao.maps.LatLng(38.0694675,128.1706991),
			content : 
				'<div class="overlaybox">인제-원대리 자작나무 숲<br><img src="pictures/location/인제원대리자작나무숲.jpg">' 
			  	+'<div class="info"><p>인제읍 인근의 자연 생태관광지인 원대리 자작나무 숲은 1974년부터 1995년까지 138ha에 자작나무 690,000본을 조림하여 만들어졌으며 현재는 그중 25ha를 유아 숲 체험 원으로 운영하고 있다.'
			  	+'자작나무 숲의 탐방은 입구에서 입산 기록 후 도보로 이용할 수 있다. 자작나무 숲만이 간직한 생태적, 심미적, 교육적 가치를 발굴하여 제공하고자 마련된 공간으로 인제군을 대표하는 자연 생태관광지로 자리 잡았다.'
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">원대리 자작나무 숲 </span>' 
		},{
			title : "평창",
			latlng : new kakao.maps.LatLng(37.370474,128.3899769),
			content : 
				'<div class="overlaybox">평창-대관령<br><img src="pictures/location/평창대관령.jpg">' 
			  	+'<div class="info"><p>대관령(大關嶺)은 강원도 강릉시와 평창군을 잇는 높이 832 m의 고개로, 태백산맥의 주요 고개이며 영서와 영동을 나누는 분수령이다.'
			  	+'평창 대관령은 유명한 스키장과 리조트, 역사 깊은 눈꽃축제, 체험 마을, 국내 최대의 목장, 황태 덕장 등 관광 인프라가 잘 형성되었다. '
			  	+'1993년부터 지역의 특성을 살려 시작한 대관령눈꽃축제는 이색적인 국제알몸마라톤대회와 초대형 눈 조각을 볼 수 있는 국내 최대 겨울 축제로 자리 잡았다.' 
			    +'</p></div>' 
			    +'</div>', 
			expression : '<span class="content">대관령</span>' 
		}
		];
		
		let rdNum = Math.floor(Math.random() * positions.length);

	
			// 마커를 생성합니다
			let marker = new kakao.maps.Marker({
				map : map, // 마커를 표시할 지도
				position : positions[rdNum].latlng
			// 마커의 위치
			});
			
			let customOverlay = new kakao.maps.CustomOverlay({
			    position: positions[rdNum].latlng,
			    content:positions[rdNum].expression
			});
			
			let customOverlay2 = new kakao.maps.CustomOverlay({
			    position: positions[rdNum].latlng,
			    content: positions[rdNum].content   
			});
			
			customOverlay.setMap(map);
			
			//마커를 클릭했을 때 커스텀 오버레이를 표시합니다
			kakao.maps.event.addListener(marker, 'click', function() {
				
				chance--;
				document.getElementById('chance').innerHTML ="기회 : "+ chance+"회";
				
				let sel = prompt("이곳은 어디일까요?");
			
				if(sel==positions[rdNum].title){
					alert("정답");
					customOverlay2.setMap(map);
					$("#exit").remove();
					window.open("setComment","코멘트창","top=200px, left=1500px,width=600px,height=500px");
				}else{
					alert("떙");
				}
				
				if(chance==0){
					let sel2 = confirm("게임이 종료되었습니다! 다시 도전하시겠습니까?");
					if(sel2){
						fail++;
						sessionStorage.setItem("fail",fail);
						chance=1;
						document.getElementById('chance').innerHTML ="기회 : "+ chance+"회";
					}else {
						
						essionStorage.setItem("exit_game",'exit');
						sessionStorage.setItem("again_game",window.location.href);
					}
				}
			});
	});
</script>
</head>
<body>
<header>
	<jsp:include page="exit.jsp"/>
	<h1>지역 맞추기</h1>
</header>
<br>
	<div id='wrap'>
		<div id='chance'></div>
		<span>※파란색 마커를 클릭해 해당 지역을 맞추세요~~※</span>
		<div id="map" style="width: 500px; height: 500px;"></div>
	</div>
</body>

</html>