<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<script type="text/javascript">
$(document).ready(function(){
	$("li:eq(3)").addClass("active");
	$(".glyphicon-search").hide();
	$(".col-sm-offset-2").hide();
	$(".pager.date").parent().attr("class" , "col-sm-12");
	$("body").attr("style","padding-top:190px;position:relative;");
	$("#full_date").text("${resultDate.START_DATE} - ${resultDate.END_DATE}");
	$(".inOutBtn").text('지출/전체')
					.data('type' , 'inOutAll');
	$(".baseBtn").text('주단위')
					.data('type', 'W')
					.data('modalBody' , {
						'주 단위' : {'className' : 'baseBtn week'},
						'월 단위' : {'className' : 'baseBtn month'},
						'연 단위' : {'className' : 'baseBtn year'}
					});
	$(".baseAllBtn").text('전체 기간')
						.data('type' , 'all');	
	$(document).on({
		click	: function(){
			$("#myModal").modal().myModal(Modal.BaseStats.inOutTypeModal()); 
		}	
	}, '.inOutBtn');
	
	$(document).on({
		click	: function(){
			var $targetEl		= $(".inOutBtn");
			$targetEl.text($(this).text()).data("type" , $(this).attr("class").split(" ")[4]);
			var $targetData	= $targetEl.data("type").trim();
			
			if ($targetData == "outPayAll"){
				$(".baseBtn").text('주단위')
								.data('type', 'W')
								.data('modalBody' , {
									'주 단위' : {'className' : 'baseBtn week'},
									'월 단위' : {'className' : 'baseBtn month'},
									'연 단위' : {'className' : 'baseBtn year'}
								});
				$(".baseAllBtn").text('전체 지출').data('type' , 'all');
			}else if ($targetData == "outPayType" || $targetData=="inPayType" ){
				$(".baseBtn").text('분류별')
								.data('type','class')
								.data('modalBody' , {
									'분류별' : {'className' : 'baseBtn class'},
									'세부분류별' : {'className' : 'baseBtn dtlClass'},
									'카드종류별' : {'className' : 'baseBtn cardClass'}
								});
				$(".baseAllBtn").text('전체 기간').data('type' , 'all');			
			}else if ($targetData == "inPayAll"){
				$(".baseBtn").text('월단위')
								.data('baseType','M')
								.data('modalBody' , {
									'월 단위' : {'className' : 'baseBtn month'},
									'연 단위' : {'className' : 'baseBtn year'}
								});
				$(".baseAllBtn").text('전체 수입').data('type' , 'all');	
			}else{
				$(".baseBtn").text('월단위')
								.data('baseType','class')
								.data('modalBody' , {
									'월 단위' : {'className' : 'baseBtn month'},
									'연 단위' : {'className' : 'baseBtn year'}
								});
				$(".baseAllBtn").text('전체 기간').data('type' , 'all');	
			}
			$("#myModal").modal("hide").baseStatsList();
		}	
	}, '.btn-inOutDtlBtn');
	
	$(document).on({
		click	: function(){
			$("#myModal").modal().myModal(Modal.BaseStats.baseTypeModal($(".baseBtn").data("modalBody"))); 
		}	
	}, '.baseBtn');
	
	$(document).on({
		click	: function(){
			var $targetEl		= $(".baseBtn");
			$targetEl.text($(this).text()).data("type" , $(this).attr("class").split(" ")[4]);
			var $targetData	= $targetEl.data("type").trim();
			$("#myModal").modal("hide").baseStatsList();
		}	
	}, '.btn-baseBtn');
	
	$.fn.baseStatsList	= function(){
		$.post( '/baseStatsList',
				{
					'inOutType' 	: $(".inOutBtn").data("type"),
					'baseType'	: $(".baseBtn").data("type"),
					'baseAllBtn'	: $(".baseAllBtn").data("type")
				},
				function (data) {
					var strHtml	="";
					console.log(data.result);
					$.each(data.result , function(i, val){
							strHtml	+= 	"<tr>"+
													"<td>"+val.LAST_DATE+"</td>"+
													"<td>"+val.AMOUNT+"</td>" + 
													"<td>"+val.AMOUNT_AVG+"</td>" +  
												"</tr>";	
					});
					$(".statsList >table > tbody").children().remove();
					$(".statsList >table>tbody").append(strHtml);
				},
				'json'
		);	
	};
});
</script>	
</head>
<body>
  	<%@include file="/WEB-INF/views/includes/gnb.jsp" %>
  	<div class="container">
  		<div class= "row statsList">
  			<table class="table table-hover bottomLine">
  				<thead>
  					<tr>
	  					<th>종료일</th>
	  					<th>사용금액</th>
	  					<th>12달 평균</th>
  					</tr>
  				</thead>
  				<tbody>
  					<c:forEach items="${result}" var="result">
						<tr>
							<td>${result.LAST_DATE}</td>
							<td>${result.AMOUNT}</td>
							<td>${result.AMOUNT_AVG}</td>
						</tr>
					</c:forEach>  				
  				</tbody>
  			</table>
  		</div>
  	</div>
	<%@include file="/WEB-INF/views/includes/modal.jsp" %>
</body>
</html>