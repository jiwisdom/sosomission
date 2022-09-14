package com.green.mission.db;

import lombok.Getter;

@Getter
public class SuggestDTO {
	int suggest_num;
	String id;
	String title;
	String mission;
	String date;
	String check_state;
	
	
	public SuggestDTO(int suggest_num,String id,String title,String mission,String date,String check_state) {
		this.suggest_num = suggest_num;
		this.id = id;
		this.title = title;
		this.mission = mission;
		this.date = date;
		this.check_state = check_state;
		
	}
}
