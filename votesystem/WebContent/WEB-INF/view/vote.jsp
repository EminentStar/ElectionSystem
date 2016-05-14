<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="/WEB-INF/view/com/meta.jsp" />
<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
<jsp:include page="/WEB-INF/view/com/css.jsp" />
<jsp:include page="/WEB-INF/view/com/script.jsp" />
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
	$(function() {//document.ready랑 같다?씨발?

		search(); // 처음에 무조건 호출해(jQuery로 변경시 해주는 작업)

		$("input[name=cand_vote]")
				.bind(
						'click',
						function() {

							$
									.post(
											'<spring:url value="/vote/dovote" />',
											$("#voteForm").serialize(),
											function(result) {
												if (result.data != null
														&& result.data.error != undefined) {
													console
															.log(result.data.error);
												} else {

													alert("<spring:message code="label.complete.vote" />");
													window.location.href = "<spring:url value = '/vote/voterate' />";
												}

											});
						});
		if(vs.session.user.role=="SYS_ROLE_ADMIN"){
			$("#cand_vote").css("visibility", "hidden");
		}
	});

	function displayResult(selectcandi) {

		document.getElementById("cand_id").value = selectcandi;
	}
	function search() {

		$
				.post(
						"<spring:url value="/vote/votesearch"/>",
						$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
						,
						function(result) {
							//결과처리
							//기존 화면 제거
							$("#voteList").html("");
							//새로운 리스트 추가
							$(result.voteList)
									.each(
											function(index, candi) {
												//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
												var $div = $("<div style='float: left; width: 33%;'>");
												$div
														.append("<img src=\"../file/candidownload/"+candi.fid+"/1\" style=\"width:200px; height:250px;\"/>");
												//$tr.append($("<td>").append(candi.user_id));				
												$div
												.append($("<br>"))
														.append($("<label >")
																.append(
																		candi.cand_id)
																.append("번 ")
																.append(
																		candi.user_name)
																.append(
																		"<input type='radio' name='selectcandi' onclick='displayResult(this.value)' id='selectcandi' value='"
																				+ candi.cand_id
																				+ "'/>"));
												//$tr.append($("<td>").append(candi.profile));				
												$("#voteList").append($div);

											});
						});

	}
</script>

<title>Put your title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<style>
#selectcandi{
	width: 20px;
	height: 20px;
}
.votebutton {
	width: 100%;
	float: left;
	margin-top: 20px;
	margin-bottom: 20px;
}
#cand_vote {
	background-color:#FF4D4D;
	border:2px solid #83c41a;
	color:#ffffff;
	font-family:"맑은 고딕";
	font-size:40px;
	font-weight:bold;
	width:700px;
	text-decoration:none;
	text-align:center;
	padding-bottom: 15px;
}
#cand_vote:hover {	
	background-color:#a5cc52;
	cursor: pointer;
}

html,body {
	margin: 0;
	padding: 0;
	width: 100%;
	height: 100%;
}

.content {
	font-family:"맑은 고딕";
 	font-size:20px;
	min-height: 100%;
	position: relative;
	overflow: auto;
	z-index: 0;
}

.background {
	position: absolute;
	z-index: -1;
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}

.top_block {
	width: 100%;
	display: block;
}

.bottom_block {
	position: absolute;
	width: 100%;
	display: block;
	bottom: 0;
}

.left_block {
	display: block;
	float: left;
}

.right_block {
	display: block;
	float: right;
}

.center_block {
	display: block;
	width: auto;
}

.block_1 {
	width: 100%;
	height: 70px;
}

.block_2 {
	width: 100%;
	height: auto;
}


</style>
</head>
<body>
	<jsp:include page="/WEB-INF/view/top.jsp" />
	<div class="middle">
		<form name=voteForm id=voteForm>
			<div class="content">

				<div class="top_block block_1">
					<div class="content">
						<table align="center" width="900" style="margin-top: 20px">
							<tr align="left" class="titlefont">
								<td colspan="5" class="line"><spring:message
										code="label.vote.execute" />
									<!-- 투표하기 --></td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="top_block block_2">
					<div id="voteList" name="voteList" class="content"></div>
				</div>

				<div class="votebutton">
					<center>
						<input type="button" name="cand_vote" id="cand_vote" value="투표하기" /> 
						<input type='hidden' name='cand_id' id='cand_id' />
					</center>
				</div>							


			</div>

		</form>
	</div>
</body>
</html>

