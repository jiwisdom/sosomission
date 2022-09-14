package com.green.mission.db;

import lombok.Getter;

@Getter
public class SuccessDTO {

	String mission_name;
	int percentage;

	// 미션 성공률
	public SuccessDTO(String mission_name, int percentage) {
		this.mission_name = mission_name;
		this.percentage = percentage;
	}
}
