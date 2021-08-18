<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp"%>


<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<div class="titlebox">
					<p>상세보기</p>
				</div>

				<form id="article">
					<div>
						<label>DATE</label>
						<p>${article.regdate }</p>
					</div>
					<div class="form-group">
						<label>번호</label> <input class="form-control" name='bno'
							value="${article.bno }" readonly>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name='writer'
							value="${article.writer }" readonly>
					</div>
					<div class="form-group">
						<label>제목</label> <input class="form-control" name='title'
							value="${article.title }" readonly>
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea class="form-control" rows="10" name='content' readonly>${article.content }</textarea>
					</div>

					<button type="button" id="modify-btn" class="btn btn-primary">변경</button>
					<button type="button" id="list-btn" class="btn btn-dark">목록</button>
				</form>
			</div>
		</div>
	</div>
</section>

<section style="margin-top: 80px;">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<form class="reply-wrap">
					<div class="reply-image">
						<img src="../resources/img/profile.png">
					</div>
					<!--form-control은 부트스트랩의 클래스입니다-->
					<div class="reply-content">
						<textarea class="form-control" rows="3" id="reply"></textarea>
						<div class="reply-group">
							<div class="reply-input">
								<input type="text" class="form-control" id="replyId" placeholder="이름"> 
								<input type="password" class="form-control" id="replyPw" placeholder="비밀번호">
							</div>

							<button type="button" class="right btn btn-info" id="replyRegist">등록하기</button>
						</div>

					</div>
				</form>

				<!--여기에접근 반복-->
				<div id="replyList">
					<!-- ajax함수를 통해 작성되는 태그들
					<div class='reply-wrap'>
						<div class='reply-image'>
							<img src='../resources/img/profile.png'>
						</div>
						<div class='reply-content'>
							<div class='reply-group'>
								<strong class='left'>honggildong</strong> 
								<small class='left'>2019/12/10</small>
								<a href='#' class='right'><span class='glyphicon glyphicon-pencil'></span>수정</a> 
								<a href='#' class='right'><span class='glyphicon glyphicon-remove'></span>삭제</a>
							</div>
							<p class='clearfix'>여기는 댓글영역</p>
						</div>
					</div>
					-->
				</div>
				<button class="form-control" id="moreList">더보기(페이징)</button>
			</div>
		</div>
	</div>
</section>

<!-- 모달 -->
<div class="modal fade" id="replyModal" role="dialog">
	<div class="modal-dialog modal-md">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn btn-default pull-right"
					data-dismiss="modal">닫기</button>
				<h4 class="modal-title">댓글수정</h4>
			</div>
			<div class="modal-body">
				<!-- 수정폼 id값을 확인하세요-->
				<div class="reply-content">
					<textarea class="form-control" rows="4" id="modalReply" placeholder="내용입력"></textarea>
					<div class="reply-group">
						<div class="reply-input">
							<input type="hidden" id="modalRno"> 
							<input type="password" class="form-control" placeholder="비밀번호" id="modalPw">
						</div>
						<button class="right btn btn-info" id="modalModBtn">수정하기</button>
						<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
					</div>
				</div>
				<!-- 수정폼끝 -->
			</div>
		</div>
	</div>
</div>


<script>
	//jquery start
	$(function() {

		//목록 버튼 클릭 이벤트
		$('#list-btn')
				.click(
						function() {
							location.href = "<c:url value='/freeBoard/freeList?pageNum=${p.pageNum}&keyword=${p.keyword}&condition=${p.condition}' />";
						});

		//수정 버튼 클릭 이벤트
		$('#modify-btn')
				.click(
						function() {
							const article = $('#article');

							article
									.attr('action',
											'<c:url value="/freeBoard/freeModify?bno=${article.bno}" />')
							article.attr('method', 'get');
							article.submit();

						});

		//댓글 등록		
		$('#replyRegist').click(function() {

			const reply = $('#reply').val();
			const id = $('#replyId').val();
			const pw = $('#replyPw').val();
			const bno = '${article.bno}';

			if (reply === '') {
				alert('내용을 입력해 주세요.');
				return;
			} else if (id === '') {
				alert('아이디를 입력해 주세요.');
				return;
			} else if (pw === '') {
				alert('비밀번호를 입력해 주세요.');
				return;
			} else {

				const reInfo = {
					"reply" : reply,
					"replyId" : id,
					"replyPw" : pw,
					"bno" : bno
				};

				//댓글 등록 비동기 통신 시작
				$.ajax({
					type : "POST",
					url : "<c:url value='/reply/replyRegist' />",
					headers : {
						"Content-Type" : "application/json"
					},
					dataType : "text", //서버로부터 어떤 형식으로 받을지 (생략 가능)
					data : JSON.stringify(reInfo),
					success : function(result) {
						console.log("통신성공!");
						if (result === 'success') {
							console.log('댓글 등록 성공');
							$('#reply').val('');
							$('#replyId').val('');
							$('#replyPw').val('');
							getList(1, true);
						} else {
							console.log('댓글 등록 실패');
						}
					},
					error : function() {
						console.log('통신 실패');
					}

				}); //댓글 등록 비동기 통신 끝
			} //else end

		}); //댓글 등록 이벤트 끝
		
		//더보기 버튼 이벤트 처리(클릭시 전역변수 페이지번호에 +1 값 전달)
		$('#moreList').click(function() {
			
			getList(++page, false);
		})
		
		//목록 요청
		let page = 1; //페이지 번호
		let strAdd = ""; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수

		getList(1, true); //상세화면 처음 진입 시 리스트 목록 가져옴
		//화면을 리셋할 것인지의 여부를 bool타입으로 받음 (페이지가 전환이 안되어 댓글이 계속 밑에 쌓이지 때문)
		function getList(pageNum, reset) {

			const bno = '${article.bno}';

			//getJSON 함수를 통해 JSON형식의 파일을 읽어올 수 있음
			//get방식의 요청을 통해 서버로부터 받은 JSON 데이터 로드
			//$.JSON(url, [DATA], [통신 성공 여부])

			//댓글 목록 비동기 시작
			$.getJSON(
							"../reply/getList/" + bno + "/" + pageNum,
							function(data) {
								console.log(data);
								
								let total = data.total; //총 댓글 수
								let list = data.list; //댓글 리스트
								
								//페이지번호 * 데이터수가 전체 게시글 개수보다 작으면 더보기 버튼 없애기
								if(total <= page * 10) {
									$('#moreList').css('display', 'none');
								} else {
									$('#moreList').css('display', 'block');
								}

								//insert, update, delete 작업 뒤에는
								//댓글을 누적하고 있는 strAdd 변수 초기화
								if (reset === true) {
									strAdd = '';
								}
								
								//응답 데이터의 길이가 0보다 작으면 함수 종료
								if(list.length <= 0) {
									return; //함수 종료
								}

								for (let i = 0; i < list.length; i++) {
									strAdd += "<div class='reply-wrap' style='display:none;'>";
									strAdd += "<div class='reply-image'>";
									strAdd += "<img src='../resources/img/profile.png'>";
									strAdd += "</div>";
									strAdd += "<div class='reply-content'>";
									strAdd += "<div class='reply-group'>";
									strAdd += "<strong class='left'>"
											+ list[i].replyId + "</strong>";
									strAdd += "<small class='left'>"
											+ timeStamp(list[i].replyDate) + "</small>"
									strAdd += "<a href='" + list[i].rno + "' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>";
									strAdd += "<a href='" + list[i].rno + "' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a>";
									strAdd += "</div>";
									strAdd += "<p class='clearfix'>"
											+ list[i].reply + "</p>";
									strAdd += "</div>";
									strAdd += "</div>";
								}

								$('#replyList').html(strAdd); //replyList영역에 문자열 형식으로 모든 댓글 추가
								//화면에 댓글을 표현할 때 reply-wrap을 display: none으로 선언하고,
								//jQuery fadeIn 함수로 서서히 드러나도록 처리
								$('.reply-wrap').fadeIn(500);

							} //getJSON 통신 성공 함수

					); //end getJSON

		} //댓글 목록 끝
		
		//날짜 처리 함수
		function timeStamp(millis) {
			const date = new Date(); //현재 날짜
			//현재 날짜를 밀리초로 변환 - 등록일 밀리초 -> 시간차
			const gap = date.getTime() - millis;
			
			let time; //리턴할 시간
			if(gap < 60* 60 * 24 * 1000) { //1일 미만인 경우
				if(gap < 60 * 60 * 1000) { //1시간 미만인 경우
					time = '방금 전'
				} else { //1시간 이상일 경우
					time = parseInt(gap / (1000 * 60 * 60)) + '시간 전';
				}
			} else { //1일 이상일 경우
				const today = new Date(millis);
				const year = today.getFullYear();
				const month = today.getMonth() + 1;
				const day = today.getDate();
				const hour = today.getHours();
				const minute = today.getMinutes();
				
				time = year + '년 ' + month + '월' + day + '일 ' + hour + '시' + minute + '분';
			}
			
			return time;
		}
		
		//수정 삭제
		/*
		ajax함수의 실행이 더 늦게 완료가 되기 때문에, 실제 이벤트 선언이 먼저 실행되게 됨
		이런 상황에서는 화면에 댓글 관련 창은 아무것도 등록되지 않은 형태이므로, 
		일반 클릭이벤트가 발동하지 않음.
		이런 경우에는, 이미 존재하는 #replyList에 이벤트를 등록하고, 이벤트를 자식에게 전파시켜
		사용하는 제이쿼리의 이벤트 위임 함수를 반드시 사용해야 함
		*/
		$('#replyList').on('click', 'a', function(e) {
			e.preventDefault(); //태그의 고유 기능 중지
			//1. a태그가 두 개(수정, 삭제)이므로 버튼부터 확인
			const rno = $(this).attr('href');
			$('#modalRno').val(rno);
			
			//hasClass()는 클래스 이름에 매개값이 포함되어 있으면 true, 없으면 false
			if($(this).hasClass('replyModify')) {
				//수정버튼 클릭
				$('.modal-title').html('댓글 수정');
				$('#modalReply').css('display', 'inline');
				$('#modalModBtn').css('display', 'inline');
				$('#modalDelBtn').css('display', 'none'); //수정이므로 삭제 버튼 숨김
				$('#replyModal').modal('show');
			} else {
				//삭제버튼 클릭
				$('.modal-title').html('댓글 삭제');
				$('#modalReply').css('display', 'none');
				$('#modalModBtn').css('display', 'none'); //삭제이므로 수정 버튼 숨김
				$('#modalDelBtn').css('display', 'inline');
				//모달 창 열기/닫기('show' / 'hide')
				$('#replyModal').modal('show');
			}
			
		}); //수정 삭제 이벤트 끝
		
		//수정 처리 함수
		$('#modalModBtn').click(function() {
			/*
			1. 모달창에 rno값, 수정한 댓글 내용(reply), replyPw값을 얻습니다.
			2. ajax함수를 이용해서 post방식으로 reply/update 요청,
			필요한 값은 JSON형식으로 처리해서 요청.
			3. 서버에서는 요청받을 메서드 선언해서 비밀번호 확인하고, 비밀번호가 맞다면
			 수정을 진행하세요. 만약 비밀번호가 틀렸다면 "pwFail"을 반환해서
			 '비밀번호가 틀렸습니다.' 경고창을 띄우세요.
			4. 업데이트가 진행된 다음에는 modal창의 모든 값을 ''로 처리해서 초기화 시키시고
			 modal창을 닫으세요.
			 수정된 댓글 내용이 반영될 수 있도록 댓글 목록을 다시 불러 오세요.
			*/
			let reply = $('#modalReply').val();
			let rno = $('#modalRno').val();
			let pw = $('#modalPw').val();
			
			const modInfo = {
				"reply" : reply,
				"rno" : rno,
				"replyPw" : pw
			};
			
			if(reply === '') {
				alert('내용을 입력해 주세요.');
				return;
			} else if(pw === '') {
				alert('비밀번호를 입력해 주세요.');
				return;
			} else{
				$.ajax({
					type: "POST",
					url: "<c:url value='/reply/update' />",
					headers: {
						"Content-Type" : "application/json"
					},
					dataType: "text",
					data: JSON.stringify(modInfo),
					success: function(result) {
						if(result === "pwFail") {
							alert('비밀번호가 틀렸습니다.');
							$('#modalPw').val('');
						} else {
							alert('수정이  완료되었습니다.');
							$('#modalReply').val('');
							$('#modalPw').val('');
							$('#replyModal').modal('hide');
							getList(1, true);
						}
					},
					error: function() {
						alert('통신 실패');
					}
			
			}); //수정 비동기 끝
			
			}
			
		}); //수정 함수 끝
		
		//삭제 처리 함수
		$('#modalDelBtn').click(function() {
			const rno = $('#modalRno').val();
			let pw = $('#modalPw').val();
			
			//삭제 비동기
			$.ajax({
				type: "POST",
				url: "<c:url value='/reply/delete' />",
				headers: {
					"Content-Type" : "application/json"
				},
				dataType: "text",
				data: JSON.stringify(
					{
						"rno": rno,
						"replyPw": pw
					}		
				),
				success: function(result) {
					if(result === 'success') {
						alert('삭제가 완료 되었습니다.');
						$('#modalPw').val('');
						$('#replyModal').modal('hide');
						getList(1, true);
					} else {
						alert('비밀번호가 틀렸습니다.');
					}
				},
				error: function() {
					alert('통신 실패');
				}
				
				
			}); //삭제 비동기 끝
			
		}); //삭제 함수 끝
		

	}); //jquery end

	
	if ("${msg}" === "modify") {
		alert('게시글 수정이 정상 처리되었습니다.');
	}
</script>

<%@ include file="../include/footer.jsp"%>