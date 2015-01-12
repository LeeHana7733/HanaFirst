<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("li:eq(4)").addClass("active");
});
</script>	
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
  	<div id="Nwagon"></div>
<script>
	var options = {
		'dataset':{
			title: 'Web accessibility status',
			values:[98.66, 1.34],
			colorset: ['#2EB400', '#2BC8C9'],
			fields: ['현대카드', '현금'],
		},
		'donut_width' : 85,
		'core_circle_radius':0,
		'chartDiv': 'Nwagon',
		'chartType': 'pie',
		'chartSize': {width:700, height:400}
	};
	Nwagon.chart(options);
</script>
</body>
</html>