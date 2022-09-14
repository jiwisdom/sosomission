package com.green.mission.db;

import lombok.Getter;

@Getter
public class AddMissionDTO {
	String suggeset_num;
	String title;
	String url;
	String startDate;
	String updateDate;
	String id;
	String comments;
	String insertDate;
	String reply;
	
	public AddMissionDTO(String suggest_num,String title,String url,String startDate,String updateDate,String id,String comments,String insertDate,String reply) {
		this.suggeset_num=suggest_num;
		this.title= title;
		this.url = url;
		this.startDate= startDate;
		this.updateDate = updateDate;
		this.id = id;
		this.comments =comments;
		this.insertDate = insertDate;
		this.reply =reply;
	}
}
