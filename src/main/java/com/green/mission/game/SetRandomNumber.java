package com.green.mission.game;

import java.util.HashSet;
import java.util.Random;
import java.util.Set;

public class SetRandomNumber {
	public static String[] random() {
		Set<String> set = new HashSet<>();
		Random rd = new Random();
		
		while(true) {
			int rd_num=rd.nextInt(100)+1;
			set.add(String.valueOf(rd_num));
			if(set.size()==5) break;
		}
		String[] s =set.stream().toArray(String[]::new);
	
		return s;
	}

}

