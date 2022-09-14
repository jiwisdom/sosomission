package com.green.mission.db;

public class test {

	public static void main(String[] args) {
		System.out.println(Encrypt.encrypt("gogo", "56783"));
		System.out.println(Encrypt.dencrypt("gogo", Encrypt.encrypt("gogo", "56783")));
		
	}

}
