package com.spring.myweb.util;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PageCreator {
	
	private PageVO page;
	private int beginPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	private int pageTotalCount;
	private int pageBtn = 10; //한 화면에 보여질 페이지 버튼 수
	
	private void pageCalc() {
		
		this.endPage = (int) (Math.ceil(page.getPageNum() /(double)pageBtn) * pageBtn);
		this.beginPage = endPage - pageBtn + 1;
		this.prev = (beginPage == 1) ? false : true;
		this.next = pageTotalCount <= (endPage*page.getCountPerPage()) ? false : true;
		
		if(!next) {
			this.endPage = (int) Math.ceil(pageTotalCount / (double)page.getCountPerPage());
		}
	}
	
	/*
	 	컨트롤러가 총 게시물의 개수를 PageCreator에게 전달한 직후에
	 	바로 페이징 버튼 알고리즘이 돌아갈 수 있도록 setter를 커스텀.
	 */
	public void setPageTotalCount(int pageTotalCount) {
		
		this.pageTotalCount = pageTotalCount;
		pageCalc();
		
	}
	
	

}
