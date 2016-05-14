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
<!-- 여기다 스크립트하나만듭니다 버튼에다 이벤트 달아야죠? 눌렀을때 뭐해라~-->

<link href="<spring:url value="/css/view/slide_style.css" /> " rel="stylesheet" type="text/css" />
<link href="<spring:url value="/css/view/elected_person.css" />" rel="stylesheet" type="text/css"/>
<%-- <script type="text/javascript" src="<spring:url value="/js/jquery/plugin/voteresult/jquery.js"/>" charset="utf-8" ></script> --%>
<script type="text/javascript">
$(function(){
	
	search();

});

function search(){
	
	$.post(
			 '<spring:url value="/vote/electedresult"/>'
			,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
			,function(result) {
				 console.log(result);
			$(result.electedresult[0]).each(function(index, candi) {
		
			var $td = $("<td>");
			var $td1 =$("<td>");
			var $ul = $("<ul style='list-style:none;'>");
			
			$td.append($("<img src=\"../file/candidownload/" +candi.fid+"/1\" style=\"width:100px; height:100px;\"/>" ));
			$td.append($ul.append("<li>"+"기호: "+ candi.cand_id + "</li><br>").append("<li>"+"이름: "+ candi.user_name+ "</li><br>")
					.append("<li>"+"학과: " +candi.dept_name+"</li><br>"));
			$td1.append("약력: "+candi.profile);		
			
			$("#electedresult").append($td);
			$("#electedresult").append($ul);
			$("#electedresult").append($td1);
	
			
		});
	});
	
/* 	 <td>사진 불러오기</td>
     <td>당선자 정보
         <ul>
          <li>
          <li>
          <li>
     </td>
     <td>약력
         <ul>
          <li>
          <li>
          <li></td>
		 */
		$.post(
				 '<spring:url value="/vote/votetotalrate"/>'
				,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
				,function(result) {
		
                 
				//$("#votetotalRate").html("");
				$(result.votetotalRate).each(function(index, rate) {
				var $ul = $("<ul style='list-style:none;'>");
				$ul.append($("<li>"+rate.total + "</li><br>"));
				$ul.append($("<li>"+rate.total_vote +"</li><br>"));
				$ul.append($("<li>"+rate.rate+ "%" + "</li><br>"));
				$("#votetotalRate").append($ul); 			
			});
		});
	
		//후보별 투표율
		$.post(
				 '<spring:url value="/vote/votecandirate"/>'
				,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
				,function(result) {
		
			
			//$("#votecandiList").html("");
			$(result.data.votecandiList).each(function(index, vote) {
				var $tr = $("<tr>");
				 $tr.append($("<td align='center'>"+vote.cand_id +"</td>"));
				$tr.append($("<td align='center'>"+vote.user_name+"</td>"));
				$tr.append($("<td align='center'>"+vote.rates+"%"+"</td>"));
				$("#votecandiList").append($tr);			
			});
		});		

/* 		  <tr>
        <td align="center">1</td>
        <td align="center">이정현</td>
        <td align="center">47%</td>
      </tr> 
 */		$.post(
				 '<spring:url value="/vote/votecollegerate"/>'
				,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
				,function(result) {
					 
					 console.log(result);
					 //$("#votecollegeRate").html("");
					 				 
						 //$("#LiberalArt").html("");		
						  /* <tr>
				            <td height="35" width="22%" align="center">단 대 </td>
				            <td width="28%" align="center">학과</td>
				            <td width="25%" align="center">투표자</td>
				            <td width="25%" align="center">투표율</td>
				          </tr>
				          <tr>
				            <td align="center"><p>공과<br />
				                대학</p></td>
				            <td colspan="3" align="center">&nbsp;</td>
				          </tr>
						 */ 
							$(result.votecollegeRate).each(function(index, college) {
							if(college.votecollegename == "인문과학대학"){	
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr align='center'>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#LiberalArt").append($tr);	
							}else if(college.votecollegename=="사회과학대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#SocialSciences").append($tr);	
							}else if(college.votecollegename=="경영대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#Business").append($tr);	
							}else if(college.votecollegename=="호텔관광대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#Hospitality").append($tr);	
							}else if(college.votecollegename=="자연과학대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#NaturalSciences").append($tr);	
							}else if(college.votecollegename=="생명과학대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#LifeSciences").append($tr);	
							}else if(college.votecollegename=="전자정보공학대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#Electronics").append($tr);	
							}else if(college.votecollegename=="공과대학"){
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='cente r'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#Engineering").append($tr);	
							}else {
								console.log(college.votedeptname);
								console.log(college.collegevotepeople);
								console.log(college.collegevoterate);
								//$("#LiberalArt").html("");		
								var $tr = $("<tr>");
								$tr.append($("<td align='center'>"+college.votedeptname+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevotepeople+"</td>"));
								$tr.append($("<td align='center'>"+college.collegevoterate+"</td>"));
								$("#Arts").append($tr);	
							}
						});
					 
		});
		/* $.post(
				 '<spring:url value="/vote/electedresult"/>'
				,$("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
				,function(result) {
		
                
				$("#electedresult").html("");
				$(result.electedresult[0]).each(function(index, elected) {
				var $ul = $("<ul style='list-style:none;'>");
				 $ul.append($("<li>"+rate.total+"</li><br>"));
				$ul.append($("<li>"+rate.total_vote+"</li><br>"));
				$ul.append($("<li>"+rate.rate+"</li><br>"));
				$("#electedresult").append($ul);			
			});
		}); */
	//});
}

$(document).ready(function(){

	$(".btn-slide").click(function(){
		$("#panel").slideToggle("slow");
		$(this).toggleClass("active"); 
		return false;
	});
		 
});

</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<div class="wrap">
  <div class="top1">
    <table width="100%" border="0" >
      <tr>
        <td class="title">총 학생회 선거 당선자</td>
      </tr>
    </table>
  </div>
  <div  class="content1">
    <table  width="100%" height="0" border="0" >
          <tr id= "electedresult" name="electedresult">
          	
          </tr> 
    </table>
  </div>
  <div class="top2">
    <table width="100%" border="0">
      <tr>
        <td class="title">투 표 율</td>
      </tr>
    </table>
  </div>
  <div class="content2">
    <div class="content2_title">
      <table width="100%">
        <tr>
          <td width="50%" align="center">투표결과</td>
          <td width="50%" align="center">후보자 별 득표율</td>
        </tr>
      </table>
    </div>
    <div class="content2_wrap">
      <div class="content2_left">
        <table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="44%">
            <ul style="list-style:none;">
                <li>전체 인원:</li>
                <br>
                <li>전체 투표수:</li>
                <br>
                <li>전체 투표율:</li>
                <br>
              </ul></td>
            <td id= "votetotalRate" name="votetatalRate" width="56%">
           <!--  <ul style="list-style:none;">
            <li>10000명</li>
                <br>
                <li>10000표</li>
                <br>
                <li>100%</li>
                <br>
            </ul> -->
            </td>
          </tr>
        </table>
      </div>
      <div class="content2_right">
        <table name= "votecandiList" id="votecandiList" width="93%" border="1" align="center" cellpadding="0" cellspacing="0">
          <tr>
            <td width="24%" height="30" align="center">기호번호</td>
            <td width="26%" align="center">이름</td>
            <td width="50%" align="center">득표율</td>
          </tr>
         <!--  <tr>
            <td align="center">1</td>
            <td align="center">이정현</td>
            <td align="center">47%</td>
          </tr> -->
        </table>
      </div>
    </div>
  </div>
  <div class="top3">
    <table width="100%" border="0">
      <tr>
        <td class="title">단과대학 별 투표율</td>
      </tr>
    </table>
  </div>
  <div id="panel">
    <div class="content3_wrap">
      <div class="content3_left">
        <table id="LiberalArt" name="LiberalArt" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단대</td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="6" align="center">인문<br/>
              과학<br/>
              대학</td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
      <div class="content3_center">
        <table id="NaturalSciences" name= "NaturalSciences" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단대</td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="7" align="center">자연<br/>
              과학<br />
              대학</td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
      <div class="content3_right">
        <table id="SocialSciences" name= "SocialSciences" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단대</td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="5" align="center">사회<br/>
              과학<br />
              대학</td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
    </div>
    <div class="content3_wrap">
      <div class="content3_left">
        <table id="Engineering" name= "Engineering" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단 대 </td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="11" align="center"><p>공과<br /> 
                대학</p></td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
      <div class="content3_center">
        <table id="Hospitality" name= "Hospitality" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단 대 </td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="4" align="center"><p>호텔<br />
                관광<br/>대학</p></td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
      <div class="content3_right">
        <table id="Business" name= "Business" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단대</td>
            <td width="28%" align="center">학과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="2" align="center"><p>경영<br />
              대학<br/></p>
            </td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
    </div>
    <div class="content3_wrap">
      <div class="content3_left">
        <table id="Electronics" name= "Electronics"  width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단 대</td>
            <td width="28%" align="center">학 과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="7" align="center"><p>전자<br/>정보<br/>공학</p></td>
            <td colspan="3" align="center">&nbsp;</td>
          </tr>
        </table>
      </div>
      <div class="content3_center">
        <table id="LifeSciences" name= "LifeSciences" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단 대</td>
            <td width="28%" align="center">학 과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="5" align="center">생명<br />
              과학<br />
              대학</td>
            <td colspan="3" align="center">&nbsp;
              </tda>            </td>
          </tr>
        </table>
      </div>
      <div class="content3_right">
      <table id="Arts" name= "Arts"width="97%" width="98%" height="300" border="1" cellpadding="0" cellspacing="0">
          <tr>
            <td height="35" width="22%" align="center">단 대</td>
            <td width="28%" align="center">학 과</td>
            <td width="25%" align="center">투표자</td>
            <td width="25%" align="center">투표율(%)</td>
          </tr>
          <tr>
            <td rowspan="9" align="center">예체능<br />
              대학</td>
            <td colspan="3" align="center"></td>            
          </tr>
        </table>
      </div>
    </div>
  </div>
  <p class="slide"><a href="#" class="btn-slide">단과대 별 투표율</a></p>
</div>
</body>
</html>
