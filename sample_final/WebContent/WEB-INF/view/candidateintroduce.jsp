<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/com/config.jsp" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<jsp:include page="/WEB-INF/view/com/meta.jsp" />
	<jsp:include page="/WEB-INF/view/com/favicon.jsp" />
	<jsp:include page="/WEB-INF/view/com/css.jsp" />
	<jsp:include page="/WEB-INF/view/com/script.jsp" />
	<title>candidateintroduce</title>
	<link rel="stylesheet" href="<spring:url value="/css/view/candidateintroduce.css"/>"/>
	<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
    
	
	<script type="text/javascript">
		 $(function() {
			search();
			//loadPoster(1);
			
			$("#vote").bind("click",function(){
				window.location.href="<spring:url value="/vote/votelist" />";
			});	
			//각 후보자의 증명사진을 클릭했을때
			//밑의 포스터와 약력이 바껴야한다. 일단 처음 해결은 ajax 에 img태그에 이벤트핸들러로 메서드를 불러왔다.
			
		});
		 
		function loadPoster(candi_id){
			   //alert("Candidate number "+candi_id+" 's loads poster. Ye~");
			   $.post("<spring:url value="/candi/candidatesearch"/>"
					   ,{cand_id : candi_id }
					   ,function(result){
						   //console.log("profile : "+result.candi.profile);
						   //console.log("filepath : "+result.candi.filepath);
						   $("#profile").html("");
						   $("#poster").html("");
						   $("#poster").append("<img src=\"../file/candidownload/"+result.candi.fid+"/"+result.candi.sub_fid+"\" style=\"width:214px; height:296px;\" />");
						   $("#profile").append(result.candi.profile);
						   
						   //해당기호의 공약 탭을 구성
			               $("#tabs>ul").html("");
			               $("#tabs>div").remove();
			               $(result.pledgeList).each(function(index,pledge){
			            	   var cnt = index+1;
			            	   var $liTap = $("<li><a href='#tabs-" + cnt + "'>공약" +cnt + "</a></li>");
			            	   // href='#tabs-"+cnt+"'>공약"+cnt+"</a></li>
			            	   //$liTap.append($("<a>").attr("href", '#tabs-'+ cnt).html("공약" + cnt));
			            	   $("#tabs>ul").append($liTap);
			            	   
			            	   var $div = $("<div id ='tabs-"+cnt+"'>");
			            	   var $table = $("<table width='100%'>");
			            	   var $tr = $("<tr>");
			            	   var $td = $("<td style='word-break:break-all'>");
			            	   $td.append("공약 제목 : "+pledge.pledge_title+"<br/>");
			            	   $td.append("내용 : "+pledge.pledge_contents+"<br/>");
			            	   $tr.append($td);
			            	   $table.append($tr);
			            	   $div.append($table);
			            	   $("#tabs").append($div);
			            	   
			            	   });
			 			  	
			               $("#tabs").tabs().tabs( "refresh" );
			               
			               });
		   }
		function search(){
			   $.get("<spring:url value="/candi/candidatesearch"/>"
			         ,function(result){
			            console.log("result.candiList : " + result.candiList);
			            console.log("result.pledgeList : " + result.pledgeList);
			            $(result.pledgeList).each(function(index,pledge){
			            	console.log(pledge);
			            });
			            //각 기호별 증명사진과 기호번호를 불러옴
			            $("#candidatePhoto").html("");//이게 html을 비우는 거에요!
			            $(result.candiList).each(function(index,candi){
			               console.log("fid : " + candi.fid);
			               var $div = $("<div class='candicontent'>");
			               var $center = $("<center>");
			               var $tablePhoto = $("<table width='85%' border='1' align='center'>");
			              
			               var $tablePhotoTr1 = $("<tr>");
			               $tablePhotoTr1.append(
			            		   "<td height='220' align='center' style = 'cursor:pointer;'><img src=\"../file/candidownload/"+candi.fid+"/1\" style=\"width:220px; height:224px;\" onClick=\"loadPoster("+ candi.cand_id +");\" /></td>");
			               var $tablePhotoTr2 = $("<tr>");
			               $tablePhotoTr2.append("<td height='30' align='center'>기호 "+candi.cand_id+"번 " + candi.user_name);
			               $tablePhoto.append($tablePhotoTr1);
			               $tablePhoto.append($tablePhotoTr2);
			               $center.append($tablePhoto);
			               $div.append($center);
			               $("#candidatePhoto").append($div); 
			            });
			            
			            /*  //사용되지않음
			            	$(result.candiList).each(function(index,candi){
			              	console.log("user_name : " + candi.user_name +", cand_id : " + candi.cand_id);
			              	var $div = $("<div style='float: left; width: 33%;'>");
				            $div.append("기호 "+candi.cand_id+"번 " + candi.user_name);
				            $("#candidateName").append($div); 
			            }); */
			            
			           /*  $("#tabs").html("");
			            var $ul = $("<ul>");
			            $(result.candiList).each(function(index,candi){
			            	//<li><a href="#tabs-1">공약1</a></li>
			            	var id = "tabs-"+(index + 1);
			            	var $li = $("<li>");
			            	$li.append("<a href=#"+id+">"+"기호"+(index+1)+"번 "+candi.user_name+"</a>");
			            	$ul.append($li);
			            });
			            $("#tabs").append($ul);
			            
			            $(result.candiList).each(function(index,candi){
			            	var id = "tabs-"+(index + 1);
			            	var $div = $("<div id = "+id+">");
			            	$("#tabs").append($div);
			            });
			            
			             $(result.pledgeList).each(function(index,pledge){
			            	var id = "tabs-"+pledge.cand_id;
			            	var $p = $("<p>");
			            	$p.append(pledge.pledge_contents);
				            $("#"+id).append($p);
			            }); 
			            
			             $("#tabs").tabs(); */
			         });
			   
			} 
			
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/view/top.jsp" />
<div class="middle">
<div class="candipageWrap">
  <div style="text-align: left ; margin-top:20px "  class="titlefont">후보자 소개</div>
  <div class="line"></div>
  <br></br>
  <div class="candiWrap" id="candidatePhoto">
  
  <!-- 후보자별 이부분 반복해서 등록함-->
   <!--  <div class="candicontent" >
      <center>
        <table width="85%" border="1" align="center">
          <tr>
            <td height="220" align="center">사진</td>
          </tr>
          <tr>
            <td height="30" align="center">기호 이름</td>
          </tr>
        </table>
      </center>
    </div> -->
  <!------------------------------------>  
  
  
      
  </div>
 
  
  
  <div class="detailTitle" style="margin-top: 20px; font-family: 맑은 고딕;font-size: 14pt;font-weight: bold;text-align: left;">상세소개
  <div class="line"></div>
  </div>
  
  
  <div class="detailcontent">
	  <table width="100%" border="1" cellpadding="10px">
		  <tr>
		    <td width="27%" rowspan="2" align="center" id="poster"></td>
		    <td width="73%" height="30">약력</td>
		  </tr>
		  <tr>
		    <td height="220" style="word-break:break-all" id="profile"></td>
		  </tr>
	</table>
 </div>
<div class="pledgecontent">
	<div id="tabs"><ul></ul></div>
</div>
<div class="votebutton">
  <center><input type="button" name="vote" class="button1" id="vote" value="투표하기" />
  </center>
  </div>
</div>
</div>
</body>
</html>