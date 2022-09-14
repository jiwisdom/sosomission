package com.green.mission.db;

import lombok.Getter;

@Getter
public class MissionDTO {
	int num;
	String mission_name;
	String mission_url;
	String insert_date;
//	int success;
//	int fail;
//	int play_count;
//	int percentage;
//	
	
	//미션 전체 가져오기
	public MissionDTO(int num,String mission_name,String mission_url,String insert_date) {
		this.num = num;
		this.mission_name = mission_name;
		this.mission_url = mission_url;
		this.insert_date = insert_date;
	}
}
