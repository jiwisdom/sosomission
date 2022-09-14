package com.green.mission.db;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
public class MissionCommentsDTO {
	String id;
	String startDate;
	String startTime;
	String mission_name;
	String comments;
	
	public MissionCommentsDTO(String startDate,String startTime,String mission_name,String comments) {
		this.startDate =startDate;
		this.startTime = startTime;
		this.mission_name= mission_name;
		this.comments =comments;
	}
}

