package com.green.mission.game;

import java.util.ArrayList;

public class Thread_runner extends Thread{
	private String name;
	private Thread_run run;
	private ArrayList<String> list;
	
	public Thread_runner(String name, Thread_run run,ArrayList<String> list) {
		this.name = name;
		this.run = run;
		this.list = list;
	}
	
	public void before() {
		System.out.println(name+"번 말 출발선에 섭니다");
	}
	
	@Override
	public void run() {		
		synchronized (this) {						
			run.play(name);	
		}
		if(run.finish(name)) {
			list.add(name);
		}
	}
}
