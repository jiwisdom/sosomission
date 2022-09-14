package com.green.mission.db;

import lombok.Getter;

@Getter
public class UsePointDTO {
	String usePointDate;
	//포인트 사용
	public UsePointDTO(String usePointDate) {
		this.usePointDate =usePointDate;
	}
}
