<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp" %>
<section>
	<div class="container-fluid">
		<div class="row">
			<!--lg에서 9그리드, xs에서 전체그리드-->
			<div class="col-lg-9 col-xs-12 board-table">
				<div class="titlebox">
					<p>자유게시판</p>
				</div>
				<hr>

				<!--form select를 가져온다 -->
				<form action='<c:url value="/freeBoard/freeList" />'>
					<div class="search-wrap">
						<button type="submit" class="btn btn-info search-btn">검색</button>
						<input type="text" class="form-control search-input" name="keyword" value=${pc.page.keyword }> 
						<select
							class="form-control search-select" name="condition">
							<option value="title" ${pc.page.condition == 'title' ? 'selected' : '' }>제목</option>
							<option value="content" ${pc.page.condition == 'content' ? 'selected' : '' }>내용</option>
							<option value="writer" ${pc.page.condition == 'writer' ? 'selected' : '' }>작성자</option>
							<option value="titleContent" ${pc.page.condition == 'titleContent' ? 'selected' : '' }>제목+내용</option>
						</select>
					</div>
				</form>

				<table class="table table-bordered">
					<thead>
						<tr>
							<th>번호</th>
							<th class="board-title">제목</th>
							<th>작성자</th>
							<th>등록일</th>
							<th>수정일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="article" items="${boardList }">
							<tr>
								<td>${article.bno }</td>
								<td>
									<a href='<c:url value="/freeBoard/freeDetail?bno=${article.bno}&pageNum=${pc.page.pageNum }&keywrod=${pc.page.keyword }&condition=${pc.page.condition }"/>'>${article.title }</a>
									<c:if test="${article.newmark }">
										<img alt="뉴마크" src='<c:url value="/resources/img/new.gif"/>'>
									</c:if>	
								</td>
								<td>${article.writer }</td>
								<td>
									<fmt:formatDate value="${article.regdate }" pattern="yyyy년 MM월 dd일 HH:mm" />
								</td>
								<td>
									<fmt:formatDate value="${article.updatedate }" pattern="yyyy년  MM월 dd일 HH:mm"/>
								</td>
							</tr>
						
						</c:forEach>
					</tbody>

				</table>


				<!--페이지 네이션을 가져옴-->
				<form action="<c:url value='/freeBoard/freeList' />" name="pageForm">
					<div class="text-center">
                    <hr>
                    
                    <!-- 페이지 관련 버튼들이 ul 태그로 감싸져 있음 -->
                    <ul class="pagination pagination-sm" id="pagination">
                       
                       <c:if test="${pc.prev}">
                       		<li><a href="#" data-pageNum="${pc.beginPage-1 }">이전</a></li>
                       </c:if>
                       
                       <c:forEach var="i" begin="${pc.beginPage }" end="${pc.endPage}">
                        <li  class="${pc.page.pageNum == i ? 'active' : '' }"><a href='#' data-pageNum="${i}">${i}</a></li>
                       </c:forEach>
                       
                        <c:if test="${pc.next}">
                        	<li><a href="#" data-pageNum="${pc.endPage+1}">다음</a></li>
                        </c:if>
                        
                    </ul>
                    
                    <!-- 페이지 관련 버튼을 클릭 시 숨겨서 보낼 값 -->
                    <input type="hidden" name="pageNum" value="${pc.page.pageNum }">
                    <input type="hidden" name="countPerPage" value="${pc.page.countPerPage}">
                    <input type="hidden" name="keyword" value="${pc.page.keyword}">
                    <input type="hidden" name="condition" value="${pc.page.condition}">
                    
                    <button type="button" class="btn btn-info" onclick="location.href='<c:url value="/freeBoard/freeRegist" />'">글쓰기</button>
                    </div>
				</form>

			</div>
		</div>
	</div>
</section>

<script>

	if("${msg}" === "delete") {
		alert('삭제가 완료되었습니다.');
	}
	
	//사용자가 페이지 관련 버튼 클릭 시 버튼에 맞는 페이지 정보를 -> input page value를 수정
	const pagination = document.getElementById('pagination');
	pagination.onclick = function(e) {
		e.preventDefault(); //버튼의 고유 이벤트 속성 중지
		
		//현재 이벤트가 발생한 요소(페이지 관련 버튼 클릭의 주체)의
		//data-pageNum의 값을 얻어서 변수에 저장하는 행위
		const value = e.target.dataset.pagenum;
		
		//페이지 버튼들을 감싸고 있는 form태그를 name으로 지목하여
		//그 안에 있는 pageNum이라는 input태그의 value에 data-pageNum의 값 삽입
		document.pageForm.pageNum.value = value;
		document.pageForm.submit();
		
	}

</script>


<%@ include file="../include/footer.jsp" %>

