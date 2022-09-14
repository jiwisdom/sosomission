package com.green.mission.db;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {
	String id;
	String pw;
	String name;
	String tel;
	String email;
	String reg_date;
	int point;
	String sec_date;
	
	//기본 
	public MemberDTO(String id,String pw,String name,String tel,String email,String reg_date) {
		this.id=id;
		this.pw= pw;
		this.name= name;
		this.tel = tel;
		this.email = email;
		this.reg_date = reg_date;
	}
	
}
