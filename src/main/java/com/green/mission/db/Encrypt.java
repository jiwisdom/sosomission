package com.green.mission.db;

public class Encrypt {

	public static String encrypt(String id,String pw) {
		char pw_array[] = pw.toCharArray();
		int sum = 0;
		// id를 char배열에 넣어줌
		char ids[] = id.toCharArray();
		// 문자를 아스키 코드로 변환해서 총합을 구함
		for (int i = 0; i < ids.length; i++) {
			sum += ids[i];
		}
		int pre = sum / ids.length;
		int post = sum * ids.length;
		String pws = String.valueOf(pre);
		//String pws = pre_st;
		// 문자를 아스키 코드로 변환후 붙여줌
		for (int i = 0; i < pw_array.length; i++) {
			pws += (int) pw_array[i] + "";
		}
		String realPw = pre + "" + pws + "" + post;
		return realPw;
	}
	
	public static String dencrypt(String id,String pw) {
		int sum = 0;
		char ids[] = id.toCharArray();

		for (int i = 0; i < ids.length; i++) {
			sum += ids[i];
		}
		int pre = sum / ids.length;
		int post = sum * ids.length;

		String pre_st = String.valueOf(pre);
		String post_st = String.valueOf(post);

		String enPw = pw.substring(
				pre_st.length()*2,(pw.length()-post_st.length()));
		
		char c[] = enPw.toCharArray();
		String ASCII[] = new String[c.length/2];
		
		for(int i=0;i<c.length;) {
			for(int n=0;n<ASCII.length;n++) {
				ASCII[n] = c[i]+""+c[i+1];
				i+=2;
			}
		}
		String nulldePw = null;
		for(int i=0;i<ASCII.length;i++) {
			nulldePw+=(char)Integer.parseInt(ASCII[i]);
		}
		
		String dePw = nulldePw.substring(4);
		return dePw;
	}
}
