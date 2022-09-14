package com.green.mission.db;

import lombok.Getter;

@Getter
public class ReplyDTO {
	String id;
	String suggest_num;
	String reply_num;
	String reply_comment;
	String write_date;
	public ReplyDTO(String id,String suggest_num,String reply_num,String reply_comment,String write_date) {
		this.id =id;
		this.suggest_num =suggest_num;
		this.reply_num = reply_num;
		this.reply_comment =reply_comment;
		this.write_date = write_date;
	}
}
