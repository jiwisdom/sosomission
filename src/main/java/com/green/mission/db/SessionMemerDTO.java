package com.green.mission.db;

import lombok.Getter;

@Getter
public class SessionMemerDTO {
	String id;
	String pw;
	String name;
	String tel;
	String email;
	String reg_date;
	String sec_date;

	// 탈퇴 멤버
	public SessionMemerDTO(String id, String pw, String name, String tel, String email, String reg_date,
			String sec_date) {
		this.id = id;
		this.pw = pw;
		this.name = name;
		this.tel = tel;
		this.email = email;
		this.reg_date = reg_date;
		this.sec_date = sec_date;
	}
}
