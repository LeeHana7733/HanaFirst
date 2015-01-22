<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script>
	var cateModalTitle;
	var cateModalType;
	$(document).ready(function(){
		$(document).bind('cateEditList', function(event,cateType,title) {
			var cateTypeP	= cateType
			var html	="";
			$.ajaxSetup({async: false});
			$.post("/cateList",
					{cateType : cateTypeP},
					function(data){
						$.each(data.result ,function(i,val){
							console.log(val.cateOid);
							html+="<button type=\"button\" data-oid=\""+val.cateOid+"\" class=\"btn btn-default btn-block btn-cate\">"+val.cateName+"</button>";	
						});
					},
					'json'
			); 
			$("#myModal").modal().myModal(Modal.CateEdit.alertModal(html, title));
			$.ajaxSetup({async: true});
		});
		
		$(document).on({
			click : function(){
				$("#myModal").modal().myModal(Modal.CateEdit.cateMenu());
			}
		} , '.cateEdit');	
		
		$(document).on({
			click : function(){
				modalTitle		= $(this).text();
				cateModalType	= $(this).hasClass("out") ? "PA" : "IN";
				$(document).trigger('cateEditList',[cateModalType,modalTitle]);				
			}
		} , '.btn-cateEdit');
		
		$(document).on({
			click	: function(){
				$.ajaxSetup({async: false});
				var html="<button type=\"button\" data-oid=\"\" class=\"btn btn-default btn-block btn-cateDtl back\">.....</button>";
				$.post("/cateList",
						{cateType : 'PD' , cateOid : $(this).data('oid')},
						function(data){
							$.each(data.result ,function(i,val){
								console.log(val.cateOid);
								html+="<button type=\"button\" data-oid=\""+val.cateOid+"\" class=\"btn btn-default btn-block btn-cateDtl\">"+val.cateName+"</button>";	
							});
						},
						'json'
				); 
				$("#myModal").modal().myModal(Modal.CateEdit.alertModal(html, $(this).text()));
				$.ajaxSetup({async: true});
			}
		}, '.btn-cate');
		
		$(document).on({
			click	: function(){
				$(document).trigger('cateEditList',[cateModalType,modalTitle]);			
			}
		}, '.btn-cateDtl.back');
	});
</script> 
<header class="navbar navbar-inverse navbar-fixed-top bs-docs-nav" role="banner">
	<div class="container">
		<div	class="collapse navbar-collapse navbar-ex1-collapse">
			<ul class="nav nav-tabs"> 
				<li><a href="/">지출내역</a></li>
				<li><a href="/inPay">수입내역</a></li>
				<li><a href="/budget">예산관리</a></li>
				<li><a href="/baseStats">자료통계</a></li>
				<li><a href="/dataCharts">자료차트</a></li>
				<li class="navbar-right dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<span class="glyphicon glyphicon-align-justify"></span>
					</a>
		            	<ul class="dropdown-menu" role="menu">
		             	<li class="cateEdit"><a href="#">카테고리 편집</a></li>
		             	<li><a href="#">즐겨찾기 편집</a></li>
		             	<li><a href="#">엑셀(CSV) 내보내기</a></li>
		             	<li><a href="#">도움말</a></li>
		             	<li><a href="#">환경설정</a></li>
		            	</ul>
				</li>
				<li class="navbar-right a"><span class="glyphicon glyphicon-pencil"></span></li>
				<li class="navbar-right a"><span class="glyphicon glyphicon-search"></span></li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row all">
			<div class="col-sm-8">
				<ul class="pager date">
					<li><button type="button" class="btn btn-default  left">←</button></li>
					<li id="full_date" data-today="${totalInfo.TO_DAY}"> ${totalInfo.TODATE}</li>
					<li><button type="button" class="btn btn-default  right">→</button></li>
				</ul>
			</div>
			<div class="col-sm-2 col-sm-offset-2">
				<ul class="pager totalAmount">
					<li><fmt:formatNumber type="number" pattern="###,###" value="${totalInfo.MONTHTOTAL}" />원</li>
				</ul>
			</div>		
		</div>
	</div>
	<div class="container">
		<div class="row bottom">
			<c:choose>
				<c:when test="${title eq '지출내역'}">
					<div class="col-sm-4"><button type="button" class="btn btn-default card"  data-id="0">카드별</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default class" >분류별</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default detail" >세부분류별</button></div>
				</c:when>
				<c:when test="${title eq '자료통계'}">
					<div class="col-sm-4"><button type="button" class="btn btn-default inOutBtn" >지출/전체</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default baseBtn" >주단위</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default baseAllBtn">전체 지출</button></div>
				</c:when>
				<c:otherwise>
					<div class="col-sm-4"><button type="button" class="btn btn-default budgetType"  data-type="W">주별 예산</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default  amountMoney">금액 표시</button></div>
					<div class="col-sm-4"><button type="button" class="btn btn-default amount">가능액 표시</button></div>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</header>