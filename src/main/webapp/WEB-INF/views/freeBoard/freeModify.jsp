<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<%@ include file="../include/header.jsp"%>


<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-9 write-wrap">
				<div class="titlebox">
					<p>수정하기</p>
				</div>

				<form action='<c:url value="/freeBoard/freeDelete?bno=${article.bno }" /> ' id="modifyForm" method="post">
					<div>
						<label>DATE</label>
						<p>${article.regdate }</p>
					</div>
					<div class="form-group">
						<label>번호</label> <input class="form-control" name='bno' value="${article.bno}" readonly>
					</div>
					<div class="form-group">
						<label>작성자</label> <input class="form-control" name='writer' value="${article.writer}" readonly>
					</div>
					<div class="form-group">
						<label>제목</label> <input id="title" class="form-control" name='title' value="${article.title}">
					</div>

					<div class="form-group">
						<label>내용</label>
						<textarea id="content" class="form-control" rows="10" name='content'>${article.content}</textarea>
					</div>

					<button id="list-btn" type="button" class="btn btn-dark">목록</button>
					<button id="modify-btn" type="button" class="btn btn-primary">변경</button>
					<button id="delete-btn" type="submit" class="btn btn-info">삭제</button>
				</form>

			</div>
		</div>
	</div>
</section>

<script>
	
	$(function() {
		
		//목록 이동
		$('#list-btn').click(function() {
			location.href='<c:url value="/freeBoard/freeList" />';
		});
		
		//수정 버튼 이벤트
		$('#modify-btn').click(function() {
			
			if($('#title').val() === '') {
				alert('제목을 입력해 주세요.');
				document.updateForm.title.focus();
				return;
			} else if($('#content').val() === '') {
				alert('내용을 입력해 주세요.');
				document.updateForm.content.focus();
				return;
			} else {
				$('#modify-btn').attr('type', 'submit');
				$('#modifyForm').attr('action', '<c:url value="/freeBoard/freeUpdate" />');
				$('#modifyForm').attr('method', 'get');
				$('#modifyForm').submit();
			}
		});
		
		//삭제 버튼 이벤트
		
		
	}); //jQuery end
	
</script>

<%@ include file="../include/footer.jsp"%>

