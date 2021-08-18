<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="../include/header.jsp"%>

<section>
	<div class="container">
		<div class="row">
			<div class="col-xs-12 content-wrap">
				<div class="titlebox">
					<p>자유게시판</p>
				</div>
				<form id="registForm" method="post">
					<table class="table">
						<tbody class="t-control">
							<tr>
								<td class="t-title">NAME</td>
								<td><input id="writer" class="form-control input-sm"
									name="writer"></td>
							</tr>
							<tr>
								<td class="t-title">TITLE</td>
								<td><input id="title" class="form-control input-sm"
									name="title"></td>
							</tr>
							<tr>
								<td class="t-title">CONTENT</td>
								<td><textarea id="content" class="form-control"
										name="content" rows="7"></textarea></td>
							</tr>
						</tbody>
					</table>

					<div class="titlefoot">
						<button type="button" id="regist-btn" class="btn">등록</button>
						<button type="button" id="list-btn" class="btn">목록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</section>

<script>
	//jquery start
	$(function() {

		//등록 버튼
		$('#regist-btn').click(function() {
			
			if ($('#writer').val() === '') {
				alert('작성자를 입력해 주세요.');
				return;
			} else if ($('#title').val() === '') {
				alert('제목을 입력해 주세요.');
				return;
			} else if ($('#content').val() === '') {
				alert('내용을 입력해 주세요.');
				return;
			} else {
				$('#registForm').submit();
			}
		});

		//목록 버튼
		$('#list-btn').click(function() {
			location.href = '<c:url value="/freeBoard/freeList" />';
		});

	})
</script>

<%@ include file="../include/footer.jsp"%>

