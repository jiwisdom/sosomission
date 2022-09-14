package com.green.mission.db;

import lombok.Getter;

@Getter
public class ProvidedMissionDTO {

	String mission_name;
	String mission_url;

	// 미션 이름+url 가져오기
	public ProvidedMissionDTO(String mission_name,String mission_url) {
			this.mission_name = mission_name;
			this.mission_url = mission_url;
		}
}
