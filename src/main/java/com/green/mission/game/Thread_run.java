package com.green.mission.game;

public class Thread_run {
	public void start(String name) {
		System.out.println(name+"번 말 출발합니다");
	}
	
	public void run(String name) {
		System.out.println(name+"번 말 달립니다.");
	}
	
	public boolean finish(String name) {
		System.out.println(name+"번 말 도착합니다");
		return true;
	}
	
	public void play(String name) {				
		start(name);
		run(name);				
		
	}
}
