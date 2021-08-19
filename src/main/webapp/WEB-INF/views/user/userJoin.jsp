<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jsp"%>


<section>
	<div class="container">
		<div class="row">
			<div class="col-lg-6 col-md-9 col-sm-12 join-form">
				<div class="titlebox">회원가입</div>
				<form action="<c:url value='/user/join' />" method="post"
					id="joinForm">
					<div class="form-group">
						<!--사용자클래스선언-->
						<label for="id">아이디</label>
						<div class="input-group">
							<!--input2탭의 input-addon을 가져온다 -->
							<input type="text" class="form-control" id="userId" name="userId" placeholder="아이디를 (영문포함 4~12자 이상)">
							<div class="input-group-addon">
								<button type="button" id="idCheckBtn" class="btn btn-primary">아이디중복체크</button>
							</div>
						</div>
						<span id="msgId"></span>
						<!--자바스크립트에서 추가-->
					</div>
					<div class="form-group">
						<!--기본 폼그룹을 가져온다-->
						<label for="password">비밀번호</label> 
						<input type="password" class="form-control" id="userPw" name="userPw" placeholder="비밀번호 (영 대/소문자, 숫자 조합 8~16자 이상)"> 
						<span id="msgPw"></span>
						<!--자바스크립트에서 추가-->
					</div>
					<div class="form-group">
						<label for="password-confrim">비밀번호 확인</label> 
						<input type="password" class="form-control" id="pwConfirm" placeholder="비밀번호를 확인해주세요."> <span id="msgPw-c"></span>
						<!--자바스크립트에서 추가-->
					</div>
					<div class="form-group">
						<label for="name">이름</label> 
						<input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요.">
					</div>
					<!--input2탭의 input-addon을 가져온다 -->
					<div class="form-group">
						<label for="hp">휴대폰번호</label>
						<div class="input-group">
							<select class="form-control phone1" id="userPhone1" name="userPhone1">
								<option>010</option>
								<option>011</option>
								<option>017</option>
								<option>018</option>
							</select> 
							<input type="text" class="form-control phone2" id="userPhone2" name="userPhone2" placeholder="휴대폰번호를 입력하세요.">
							<div class="input-group-addon">
								<button type="button" class="btn btn-primary">본인인증</button>
							</div>
						</div>
					</div>
					<div class="form-group email-form">
						<label for="email">이메일</label><br> 
						<input type="text" class="form-control" id="userEmail1" name="userEmail1" placeholder="이메일"> 
						<select class="form-control" id="userEmail2" name="userEmail2">
							<option>@naver.com</option>
							<option>@daum.net</option>
							<option>@gmail.com</option>
							<option>@hanmail.com</option>
							<option>@yahoo.co.kr</option>
						</select>
					</div>
					<!--readonly 속성 추가시 자동으로 블락-->
					<div class="form-group">
						<label for="addr-num">주소</label>
						<div class="input-group">
							<input type="text" class="form-control" id="addrZipNum" name="addrZipNum" placeholder="우편번호" readonly>
							<div class="input-group-addon">
								<button type="button" class="btn btn-primary" onclick="goPopup()">주소찾기</button>
							</div>
						</div>
					</div>
					<div class="form-group">
						<input type="text" class="form-control" id="addrBasic" name="addrBasic" placeholder="기본주소">
					</div>
					<div class="form-group">
						<input type="text" class="form-control" id="addrDetail" name="addrDetail" placeholder="상세주소">
					</div>

					<!--button탭에 들어가서 버튼종류를 확인한다-->
					<div class="form-group">
						<button type="button" id="joinBtn"
							class="btn btn-lg btn-success btn-block">회원가입</button>
					</div>

					<div class="form-group">
						<button type="button" class="btn btn-lg btn-info btn-block">로그인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<%@ include file="../include/footer.jsp"%>

<script>
	//아이디 중복 체크
	$('#idCheckBtn').click(function() {
		if ($('#userId').val() === '') {
			alert('아이디는 필수 입력값 입니다.');
			return;
		}

		//아이디값은 받아와서 비동기 통신을 통해 서버와 통신
		//중복되었다면 '중복된 아이디입니다.'
		//아니라면 '사용 가능한 아이디입니다.'라고 화면에 작성
		//attr()이용해서 readonly 속성을 true를 주기. 

		const userId = $('#userId').val();

		$.ajax({
			type : "POST",
			url : "<c:url value='/user/userIdCheck' />",
			headers : {
				"Content-Type" : "application/json"
			},
			dataType : "text",
			data : userId, //controller에 보낼 데이터
			success : function(result) {
				if (result == "duplication") {
					alert('중복된 아이디입니다.');
				} else {
					$('#msgId').html('사용 가능한 아이디입니다.');
					$('#userId').attr('readonly', 'true');
				}
			},
			error : function() {
				alert("통신 실패. 관리자에게 문의하세요.")

			}

		}); //아이디 중복 체크 비동기 끝

	}); //아이디 중복 체크 끝

	//폼 데이터 검증 (회원가입 버튼을 눌렀을 시)
	$('#joinBtn').click(
			function() {
				if (!$('#userId').attr('readonly')) {
					alert('아이디 중복체크는 필수 입니다.');
					return;
				} else if ($('#userPw').val() === ''
						|| $('#userPw').val() !== $('#pwConfirm').val()) {
					alert('비밀번호 규칙을 확인하세요.');
					$('#userPw').focus();
					return;
				} else if ($('#userName').val() === '') {
					alert('이름은 필수 입니다.');
					$('#userName').focus();
					return;
				} else {
					$('#joinForm').submit();
				}

			}); //회원가입 버튼 끝

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

	/*아이디 형식 검사 스크립트*/
	var id = document.getElementById("userId");
	id.onkeyup = function() {
		/*자바스크립트의 정규표현식 입니다*/
		/*test메서드를 통해 비교하며, 매칭되면 true, 아니면 false반*/
		var regex = /^[A-Za-z0-9+]{4,12}$/;
		if (regex.test(document.getElementById("userId").value)) {
			document.getElementById("userId").style.borderColor = "green";
			document.getElementById("msgId").innerHTML = "아이디중복체크는 필수 입니다";

		} else {
			document.getElementById("userId").style.borderColor = "red";
			document.getElementById("msgId").innerHTML = "4글자 이상, 12글자 이하로 작성하세요.";
		}
	}
	/*비밀번호 형식 검사 스크립트*/
	var pw = document.getElementById("userPw");
	pw.onkeyup = function() {
		var regex = /^[A-Za-z0-9+]{8,16}$/;
		if (regex.test(document.getElementById("userPw").value)) {
			document.getElementById("userPw").style.borderColor = "green";
			document.getElementById("msgPw").innerHTML = "사용가능합니다";
		} else {
			document.getElementById("userPw").style.borderColor = "red";
			document.getElementById("msgPw").innerHTML = "";
		}
	}
	/*비밀번호 확인검사*/
	var pwConfirm = document.getElementById("pwConfirm");
	pwConfirm.onkeyup = function() {
		var regex = /^[A-Za-z0-9+]{8,16}$/;
		if (document.getElementById("pwConfirm").value == document
				.getElementById("userPw").value) {
			document.getElementById("pwConfirm").style.borderColor = "green";
			document.getElementById("msgPw-c").innerHTML = "비밀번호가 일치합니다";
		} else {
			document.getElementById("pwConfirm").style.borderColor = "red";
			document.getElementById("msgPw-c").innerHTML = "비밀번호 확인란을 확인하세요";
		}
	}
</script>
