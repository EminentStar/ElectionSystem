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
<link href="<spring:url value="/css/view/bbs.css"/>" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
<link rel="stylesheet" href="http://blueimp.github.io/Gallery/css/blueimp-gallery.min.css">
<link rel="stylesheet" href="<spring:url value="/css/bootstrap/bootstrap-image-gallery.min.css" />">
<%-- <link rel="stylesheet" href="<spring:url value="/css/bootstrap/demo.css" />"> --%>
<link rel="stylesheet" type="text/css" href="<spring:url value="/css/view/bbsStyle.css"/>"/>
<script type="text/javascript">
$(function() {//document.ready랑 같다?씨발?발놈씨?
	/* $("input[name=searchText]").attr('disabled',true);
	$("input[name=searchButton]").bind('click', function() {
		search();
	});
	$("input[name=searchText]").bind('keypress', function(e) {
		if (e.keyCode == 13) {
			e.preventDefault();
			search();
		}
	});

	$(":checkbox").bind('click',function(e){
		$("input[name=searchText]").attr('disabled',$(":checked").length == 0);
			//$("input[name=searchText]").attr('disabled',true);
		if($(":checked").length == 0){
			$("input[name=searchText]").val("");
		}
	});
	search(); // 처음에 무조건 호출해(jQuery로 변경시 해주는 작업)
	
	$("#newPost").bind('click', function(){
		window.location.href = "<spring:url value = "/bbs/form/new" />"; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	}); */
	search();
	$("#newPost").bind('click', function(){
		//var bbs_type = $("#bbs_type").val();
		window.location.href = "<spring:url value ="/bbs/form/new/3" />" ; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	});//With board, Distinguish bbs/form/new?bbs_type=1,bbs/form/new?bbs_type=2,bbs/form/new?bbs_type=3.;
	$("#editList").bind('click',function(){
		window.location.href = "<spring:url value ="/bbs/list/4" />" ; //이렇게 이벤트 핸들러달았고 등록버튼을누르면 어딘가가겠죠?
	});
	console.log(vs.session.user.role+"권한");
	if(vs.session.user.role!="ROLE_ADMIN"){
		$("#newPost").css("visibility", "hidden");
		$("#editList").css("visibility", "hidden");
	}
});

/*
 <div id="links">
    <a href="D:/upload/pjk.jpg" title="pjk" data-gallery>
        <img src="D:/upload/pjk.jpg" alt="pjk">
    </a>
</div>
 */
	function search(){
		$.post("<spring:url value="/bbs/search/3"/>"
				,$("#searchForm").serialize()
				,function(result){
			$("#links").html("");
			$(result.postList).each(function(index, post) {
				//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
				var $a = $("<a href=\"../../file/download/"+post.fid+"\" title='"+post.title+"' data-gallery >");
				$a.append("<img src=\"../../file/download/"+post.fid+"\" style=\"width:90px; height:90px;\"/>");
				console.log($a);
				$("#links").append($a);

			});
		});			
		
	}
/* function search() {
	//alert("꺼져");
	//alert($("#bbsList").html());
	 
	if($("input[name=searchText]").val().length == 0
		&& $(":checked").length == 1 
		&& $($(":checked")[0]).val() == "users_name" ){
		alert("<spring:message code="bbs.notice.writerName.required" />");
		return;
	} 
	
	
	$.post("<spring:url value="/bbs/search" />", $("#searchForm").serialize() //serialize하니깐 폼값이 다넘어가죠?
			, function(result) {
		//결과처리
		//기존 화면 제거
		$("#bbsList").html("");
		//새로운 리스트 추가
			//val엔 하나의 로우에대한 컬럼정보가 넘어온다?
			$(result.postList).each(function(index, post) {
			var $tr = $("<tr style = 'cursor:pointer;'>"); //손가락 표시
			$tr.append($("<td>").append(post.num_bid));
			$tr.append($("<td>").append(post.title));
			$tr.append($("<td>").append(post.users_name));
			$tr.append($("<td>").append(post.create_dttm));
			console.log("<spring:url value="file/download" />");
			$tr.append($("<td>").append("<img src=\"../../file/download/"+post.fid+"\" style=\"width:100px; height:100px;\"/>"));
			$("#bbsList").append($tr);

			$tr.bind('click',function(){
				//alert(post.num_bid);.
				window.location.href = "<spring:url value="/bbs/detail/" />"+post.num_bid;  //url 이동하는 문장
			});
			$tr.bind('mouseover',function(){
				$tr.css("background","#3CC8C8");
			});
			$tr.bind('mouseleave',function(){
				$tr.css("background","#D8BFD8");
			});
		});
		
		var $p = result.paging;
		var r = $p.currPageNo * $p.pageCnt;
		var pgSet = $p.pageCnt * $p.pageRows;  //=>25
		var endPageNo = (parseInt(r / pgSet) + (r % pgSet > 0 ? 1 : 0)) * $p.pageCnt;
		var startPageNo = endPageNo - $p.pageCnt + 1;
		if (endPageNo > $p.lastPageNo) {
			endPageNo = $p.lastPageNo;
			startPageNo = endPageNo - (endPageNo % $p.pageCnt) + 1;
		}
		
		var $pagingArea = $("#pagingArea");
		
		$pagingArea.html(""); //이렇게 지울수있다?
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.firstPageNo +")'>first</a>");
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.prevPageNo +")'>prev</a>");
		
		for(var i=startPageNo; i<=endPageNo ; i++){
			if($p.currPageNo == i ){
				$pagingArea.append($("<td>")).append(i);
			}else{
				$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+ i +")'>"+ i +"</a>");
			}
		}
		
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.nextPageNo +")'>next</a>");
		$pagingArea.append($("<td>")).append("<a href='#' onclick='goPage("+$p.lastPageNo +")'>last</a>");
	});
	
}
	function goPage(currPageNo){
		//alert(currPageNo);
		$("#currPageNo").val(currPageNo);
		search();
	} */
</script>
<title><spring:message code="bbs.studentunion.title"/></title>
</head>
<body>
  <jsp:include page="/WEB-INF/view/top.jsp" />
  <center>
  <table align="center" width="900" style="margin-top: 20px">
		<tr align="left" class="titlefont">
			<td colspan="5" class="line" ><spring:message code="bbs.studentunion.title"/><!-- 학생회 활동  -->
			</td>
		</tr>
   </table>
  <div class="middle">
	<div id="blueimp-gallery" class="blueimp-gallery">
    <!-- The container for the modal slides -->
    <div class="slides"></div>
    <!-- Controls for the borderless lightbox -->
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
    <!-- The modal dialog, which will be used to wrap the lightbox content -->
    <div class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" aria-hidden="true">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body next"></div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default pull-left prev">
                        <i class="glyphicon glyphicon-chevron-left"></i>
                        Previous
                    </button>
                    <button type="button" class="btn btn-primary next">
                        Next
                        <i class="glyphicon glyphicon-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<%-- <div><font class="bold" align="center"><spring:message code="bbs.studentunion.title"/></font></div> --%>
<br/>
<br/>
<br/>
<br/>
<input type="hidden" name="bbs_type" id = "bbs_type" value="3" /> <!-- In order to distinguish such board -->
<div id="links">   

</div>
<div style="height:50px"></div>
<div>
	<input type="button" name="newPost" id="newPost" class="button" value="<spring:message code="label.insert" />" />
	&nbsp;&nbsp;
	<input type="button" name="editList" id="editList" class="button" value="<spring:message code="label.bbs.edit" />" />
</div>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
<script src="<spring:url value="/js/bootstrap/bootstrap-image-gallery.min.js"/>"></script>
<%-- <script src="<spring:url value="/js/bootstrap/demo.js"/>"></script> --%>
</div>
</center>
</body>
</html>