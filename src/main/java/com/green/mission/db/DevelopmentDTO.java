package com.green.mission.db;

import lombok.Getter;

@Getter
public class DevelopmentDTO {

		int suggest_num;
		String title;
		String url;
		String startDate;
		String updateDate;
		String id;
		String comment;
		int html;
		int css;
		int js;
		int java;
		
		//개발 세부 상황
		public DevelopmentDTO(int suggest_num,String title,String url,String startDate,String updateDate,String id,String comment,int html
				,int css,int js,int java) {
			this.suggest_num = suggest_num;
			this.title= title;
			this.url = url;
			this.startDate= startDate;
			this.updateDate = updateDate;
			this.id = id;
			this.comment =comment;
			this.html = html;
			this.css = css;
			this.js = js;
			this.java = java;
		}
		//개발 진행 목록
//		public DevelopmentDTO(String title,String url,String startDate,String endDate,String id) {
//			this.title= title;
//			this.url = url;
//			this.startDate= startDate;
//			this.endDate = endDate;
//			this.id = id;
//		}

}
