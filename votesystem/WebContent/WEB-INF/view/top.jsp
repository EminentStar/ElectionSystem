<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="javatopwrap">

	<div class="top_wrap">
		<div class="top">
			<c:if test="${userInfo.users_name!=null}">
				<div class="top_username">
					<span><c:out value="${userInfo.users_name}" />
						<spring:message code="label.welcome" /></span>
				</div>
			</c:if>
			<center>
				<table class="top_title">
					<tr>
						<td height="150" align="right"><a href="home/main"><img width="100px" src="<spring:url value="/img/mainlogo.png"/>"/></a><spring:message code="label.top.main" /></td>
					</tr>
				</table>
			</center>
		</div>
		<div class="menudiv">
			<center>
				<table cellpadding="0" cellspacing="0" class="menu" border="0">
					<tr>
						<td>
							<ul>
								<li><a href="<spring:url value="/home/main"/>"><spring:message
											code="label.home" /></a></li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="#"><spring:message code="label.vote" /></a>
								<!-- 투표  -->
									<ul>
										<li><a
											href="<spring:url value="/candi/candidateintroduce"/>"><spring:message
													code="label.candi.introduce" /></a></li>
										<!-- 후보자 소개 -->
										<li><a href="<spring:url value="/vote/votelist"/>"><spring:message
													code="label.vote.execute" /></a></li>
										<!-- 투표하기 -->
										<li><a href="<spring:url value="/vote/voteresultlist"/>"><spring:message
													code="label.vote.result" /></a></li>
										<!-- 투표결과 -->
										<li><a href="<spring:url value="/vote/voterate"/>"><spring:message
													code="label.vote.rate" /></a></li>
										<!-- 투표현황 -->
									</ul></li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="#"><spring:message
											code="bbs.studentunion.title" /></a>
								<!--학생회 활동-->
									<ul>
										<li><a href="<spring:url value="/bbs/list/3"/>"><spring:message
													code="bbs.studentunion.title" /></a></li>
										<!--학생회 활동 -->
										<li><a href="<spring:url value="/pledge/pledgecheck"/>"><spring:message
													code="label.pledge.check" /></a></li>
										<!-- 공약실천여부-->
									</ul></li>
							</ul>
						</td>
						<td>
							<ul>
								<li><a href="#"><spring:message code="label.bbs" /></a>
								<!--게시판 -->
									<ul>
										<li><a href="<spring:url value="/bbs/list/1"/>"><spring:message
													code="bbs.notice.detail" /></a></li>
										<!--공지사항 -->
										<li><a href="<spring:url value="/bbs/list/2"/>"><spring:message
													code="bbs.qna.title" /></a></li>
										<!-- Q&A-->
									</ul></li>
							</ul>
						</td>
						<c:forEach var="val" items="${userInfo.role}">
							<c:if test="${val=='SYS_ROLE_ADMIN'}">
								<td>
									<ul>
										<li><a href="#"><spring:message
													code="label.data.management" /></a>
										<!--데이터 관리 -->
											<ul>
												<li><a href="<spring:url value="/user/userlist"/>"><spring:message
															code="label.modify.student" /></a></li>
												<!--학생정보/권한 수정 -->
												<li><a href="<spring:url value="/candi/candilist"/>"><spring:message
															code="label.candi.information" /></a></li>
												<!--후보자 정보 -->
												<li><a href="<spring:url value="/pledge/pledgelist"/>"><spring:message
															code="label.pledge.information" /></a></li>
												<!--공약 정보 -->

												<li><a href="<spring:url value="/home/homemodify"/>"><spring:message
															code="label.modify.votemain" /></a></li>
												<!-- 투표기간 활성화/메인 수정-->
											</ul></li>
									</ul>
								</td>
							</c:if>
						</c:forEach>
						<td>
							<ul>
								<c:choose>
									<c:when test="${userInfo.username!=null}">
									<c:forEach var="val" items="${userInfo.role}">
									<c:if test="${val!='SYS_ROLE_ADMIN'}">
										<li><a href="<spring:url value="/home/recheck"/>"><spring:message
													code="label.modify.userInfo" />
												<%-- <c:out value="${userInfo.users_name}"></c:out> --%></a></li>
										<!--회원정보수정-->
									</c:if>
									</c:forEach>
									</c:when>
									<c:otherwise>
										<li><a href="<spring:url value="/login" />"><spring:message
													code="label.login.do" /></a></li>
										<!--login-->
										<!--로그인이 안되있을시 userInfo자체가 없다!  -->
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
						<td>
							<ul>
								<c:choose>
									<c:when test="${userInfo.username != null}">
										<li><a
											href="<spring:url value="/j_spring_security_logout" />"><spring:message
													code="label.logout" /></a></li>
										<!-- logout  -->
									</c:when>
									<c:otherwise>
										<li><a href="<spring:url value="/join/index"/>" />
										<spring:message code="label.join.title" /></a></li>
										<!-- 회원가입 -->
									</c:otherwise>
								</c:choose>
							</ul>
						</td>
					</tr>
				</table>
			</center>
		</div>
	</div>
</div>
