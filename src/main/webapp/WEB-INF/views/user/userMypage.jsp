<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>

<section>
	<!--Toggleable / Dynamic Tabs긁어옴-->
	<div class="container">
		<div class="row">
			<div class="col-sm-12 col-md-10 col-lg-9 myInfo">
				<div class="titlebox">MEMBER INFO</div>

				<ul class="nav nav-tabs tabs-style">
					<li class="active"><a data-toggle="tab" href="#info">내정보</a></li>
					<li><a data-toggle="tab" href="#myBoard">내글</a></li>
					<li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
				</ul>
				<div class="tab-content">
					<div id="info" class="tab-pane fade in active">

						<p>*표시는 필수 입력 표시입니다</p>
						<form action="<c:url value='/user/userModify' />" method="post" id="userInfoForm">
							<table class="table">
								<tbody class="m-control">
									<tr>
										<td class="m-title">*ID</td>
										<td><input class="form-control input-sm" value=${userInfo.userId } name=userId readonly></td>
									</tr>
									<tr>
										<td class="m-title">*이름</td>
										<td><input class="form-control input-sm" value=${userInfo.userName } readonly></td>
									</tr>
									<tr>
										<td class="m-title">*비밀번호</td>
										<td><input type="password" class="form-control input-sm" id="userPw"></td>
									</tr>
									<tr>
										<td class="m-title">*비밀번호확인</td>
										<td><input type="password" class="form-control input-sm" id="userPwChk"></td>
									</tr>
									<tr>
										<td class="m-title">*E-mail</td>
										<td><input class="form-control input-sm" id="userEmail1"
											name="userEmail1" value=${userInfo.userEmail1 }>@ <select
											class="form-control input-sm sel" name="userEmail2">
												<option
													value="@naver.com" ${userInfo.userEmail2 == '@naver.com' ? 'selected' : '' }>naver.com</option>
												<option
													value="@gmail.com" ${userInfo.userEmail2 == '@gmil.com' ? 'selected' : '' }>gmail.com</option>
												<option
													value="@daum.net" ${userInfo.userEmail2 == '@daum.net' ? 'selected' : '' }>daum.net</option>
										</select></td>
									</tr>
									<tr>
										<td class="m-title">*휴대폰</td>
										<td><select class="form-control input-sm sel"
											name="userPhone1">
												<option ${userInfo.userPhone1 == '010' ? 'selected' : '' }>010</option>
												<option ${userInfo.userPhone1 == '011' ? 'selected' : '' }>011</option>
												<option ${userInfo.userPhone1 == '017' ? 'selected' : '' }>017</option>
												<option ${userInfo.userPhone1 == '018' ? 'selected' : '' }>018</option>
										</select> <input class="form-control input-sm" id="userPhone2"
											name="userPhone2" value=${userInfo.userPhone2 }></td>
									</tr>
									<tr>
										<td class="m-title">*우편번호</td>
										<td><input class="form-control input-sm" id="addrZipNum" value=${userInfo.addrZipNum } readonly>
											<button type="button" class="btn btn-primary" id="addBtn" onclick="goPopup()">주소찾기</button>
										</td>
									</tr>
									<tr>
										<td class="m-title">*주소</td>
										<td><input class="form-control input-sm add" id="addrBasic" value=${userInfo.addrBasic } readonly></td>
									</tr>
									<tr>
										<td class="m-title">*상세주소</td>
										<td><input class="form-control input-sm add" id="addrDetail" name="addrDetail" value=${userInfo.addrDetail }></td>
									</tr>
								</tbody>
							</table>
						</form>

						<div class="titlefoot">
							<button class="btn" id="modifyBtn">수정</button>
							<button class="btn" id="listBtn">목록</button>
						</div>
					</div>
					<!-- 첫번째 토글 끝 -->
					<div id="myBoard" class="tab-pane fade">
						<p>*내 게시글 관리</p>
						<form>
							<table class="table">
								<thead>
									<tr>
										<td>번호</td>
										<td>제목</td>
										<td>작성일</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="article" items="${userInfo.userBoardList }">
										<tr>
											<td>${article.bno }</td>
											<td><a href="##">${article.title }</a></td>
											<td>${article.regdate }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</form>
					</div>
					<!-- 두번째 토글 끝 -->
					<div id="menu2" class="tab-pane fade">
						<h3>Menu 2</h3>
						<p>Some content in menu 2.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
    
    	//jquery start
    	$(function() {
    		
    		//const PwCheck = RegExp(/^([a-zA-Z0-9])$/);

			
    		$('#modifyBtn').click(function() {
    			if($('#userPw').val() === '') {
    				alert('비밀번호를 입력해 주세요.');
    			} else if($('#userPwChk').val() === '') {
    				alert('비밀번호 확인을 입력해 주세요.');
    			} else if($('#userEmail1').val() === '') {
    				alert('이메일을 입력해 주세요.');
    			} else if($('#userPhone2').val() === '') {
    				alert('핸드폰 번호를 입력해 주세요.');
    			} else if($('#addrDetail').val() === '') {
    				alert('상세주소를 입력해 주세요.');
    			} else {
    				if($('#userPw').val() !== $('#userPwChk').val()) {
    					alert('비밀번호를 다시 확인해 주세요.');
    				} else {
    					alert('회원 정보 수정이 완료되었습니다.');
    					$('#userInfoForm').submit();
    				}
    			}
				
			}); //수정 이벤트 끝
			
			$('#listBtn').click(function() {
				location.href='<c:url value="/freeBoard/freeList" />';
			})
    		
		}); //jquery end
		
		/* 주소 팝업 */
		function goPopup() {
			//절대경로로 팝업창을 오픈
			const pop = window
					.open(
							"${pageContext.request.contextPath}/resources/popup/jusoPopup.jsp",
							"pop",
							"width=570, height=420, scrollbars=yes, resizable=yes");
		}

		function jusoCallBack(roadFullAddr, roadAddrPart1, addrDetail,
				roadAddrPart2, engAddr, jibunAddr, zipNo, admCd, rnMgtSn, bdMgtSn,
				detBdNmList, bdNm, bdKdcd, siNm, sggNm, emdNm, liNm, rn, udrtYn,
				buldMnnm, buldSlno, mtYn, lnbrMnnm, lnbrSlno, emdNo) {
			//콜백으로 받아온 데이터를 가입폼에 입력.
			document.getElementById("addrBasic").value = roadAddrPart1;
			document.getElementById("addrDetail").value = addrDetail;
			document.getElementById("addrZipNum").value = zipNo;
		}
    </script>

<%@ include file="../include/footer.jsp"%>
