package com.green.mission.controller;

import java.io.FileWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.green.mission.db.AddMissionDTO;
import com.green.mission.db.DeleteMemberDTO;
import com.green.mission.db.DevelopmentDTO;
import com.green.mission.db.Encrypt;
import com.green.mission.db.MemberDTO;
import com.green.mission.db.MissionCommentsDTO;
import com.green.mission.db.MissionDTO;
import com.green.mission.db.ProvidedMissionDTO;
import com.green.mission.db.ReplyDTO;
import com.green.mission.db.SuccessDTO;
import com.green.mission.db.SuggestDTO;
import com.green.mission.game.SetRandomNumber;
import com.green.mission.game.Thread_run;
import com.green.mission.game.Thread_runner;
import com.green.mission.service.IService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MissionController {

	@Autowired
	IService service;

	@RequestMapping("/")
	public String root() {
		return "login";
	}

	@RequestMapping("/mission_practice2")
	public String mission_example() {
		return "mission_practice2";
	}

	// 미션
	@RequestMapping("/mission_arithmetic")
	public String mission_arithmetic() {
		return "mission_arithmetic";
	}

	@RequestMapping("/mission_arithmetic2")
	public String mission_arithmetic2() {
		return "mission_arithmetic2";
	}

	@RequestMapping("/mission_clean")
	public String mission_clean() {
		return "mission_clean";
	}

	@RequestMapping("/mission_findLocation")
	public String mission_findLocation() {
		return "mission_findLocation";
	}

	@RequestMapping("/mission_RSP")
	public String mission_RSP() {
		return "mission_RSP";
	}

	@RequestMapping("/mission_HangMan")
	public String mission_HangMan() {
		return "mission_HangMan";
	}

	@RequestMapping("/mission_horse")
	public String mission_horse() {
		return "mission_horse";
	}

	@RequestMapping("/batting")
	public @ResponseBody String batting() {

		ArrayList<String> list = new ArrayList<>();

		Thread_run run = new Thread_run();
		Thread_runner runner1 = new Thread_runner("1", run, list);
		Thread_runner runner2 = new Thread_runner("2", run, list);
		Thread_runner runner3 = new Thread_runner("3", run, list);

		runner1.before();
		runner2.before();
		runner3.before();

		runner1.start();
		runner2.start();
		runner3.start();
		try {
			runner1.join();
			runner2.join();
			runner3.join();

		} catch (InterruptedException e) {

			e.printStackTrace();
		}
		log.info("우승자 : " + list.get(0));

		return list.get(0) + list.get(1) + list.get(2);
	}

	@RequestMapping("/mission_remember")
	public String mission_remember() {
		return "mission_remember";
	}

	@RequestMapping("/hashSet")
	public @ResponseBody String hashSet() {
		String[] set = SetRandomNumber.random();
		JSONArray array = new JSONArray();
		for (int i = 0; i < set.length; i++) {
			JSONObject obj = new JSONObject();
			obj.put("num", set[i]);
			array.put(obj);
		}
		return array.toString();
	}

	@RequestMapping("/mission_stretching")
	public String mission_stretching() {
		return "mission_stretching";
	}
	
	@RequestMapping("/mission_bomb")
	public String mission_bomb() {
		return "mission_bomb";
	}

	// logout
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "login";
	}

	// 로그인 페이지
	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	// 이름 가져오기
	@RequestMapping("/getName")
	public @ResponseBody String getName(HttpServletRequest request) {
		String realPw = Encrypt.encrypt(request.getParameter("id"), request.getParameter("pw"));

		String user = service.getUserName(request.getParameter("id"), realPw);
		String admin = service.getAdminName(request.getParameter("id"), realPw);

		System.out.println("user :" + user);
		System.out.println("admin :" + admin);

		if (user != null)
			return user;
		else if (admin != null)
			return admin;
		else
			return "없음";
	}

	// 로그인
	@RequestMapping("/login.do")
	public @ResponseBody String login_do(HttpServletRequest request) {

		HttpSession session = request.getSession();

		String realPw = Encrypt.encrypt(request.getParameter("id"), request.getParameter("pw"));

		String user = service.getUserName(request.getParameter("id"), realPw);
		String admin = service.getAdminName(request.getParameter("id"), realPw);

		if (user != null) {
			session.setAttribute("admin", "no");
			session.setAttribute("name", user);
			session.setAttribute("id", request.getParameter("id"));
			session.setAttribute("pw", realPw);
			return user + "회원님 환영합니다.";

		} else if (admin != null) {
			session.setAttribute("admin", "admin");
			session.setAttribute("name", admin);
			session.setAttribute("id", request.getParameter("id"));
			session.setAttribute("pw", realPw);
			return admin + "관리자님 환영합니다.";

		} else
			return "회원이 아닙니다. 회원 가입해주세요.";

	}

	// id 찾기 페이지
	@RequestMapping("/findId")
	public String findId() {
		return "findId";
	}

	// pw 찾기 페이지
	@RequestMapping("/findPw")
	public String findPw() {
		return "findPw";
	}

	// id찾기
	@RequestMapping("/findId.do")
	public @ResponseBody String findId(HttpServletRequest request) {

		String id = service.findId(request.getParameter("name"), request.getParameter("tel"));
		System.out.println(id);
		if (id != null)
			return "id는 " + id + "입니다.";
		else
			return "가입된 정보가 없습니다.";
	}

	// pw 찾기
	@RequestMapping("/findPw.do")
	public @ResponseBody String findPw(HttpServletRequest request) {
		String enpw = service.findPw(request.getParameter("id"), request.getParameter("tel"));

		if (enpw != null) {
			String depw = Encrypt.dencrypt(request.getParameter("id"), enpw);
			return "pw는 " + depw + "입니다.";
		} else
			return "가입된 정보가 없습니다.";

	}

	// 회원가입 페이지
	@RequestMapping("/regist")
	public String regist() {
		return "regist";
	}

	// id 중복확인
	@RequestMapping("/idCheck")
	public @ResponseBody String idCheck(HttpServletRequest request) {
		int rs = service.idCheck(request.getParameter("id"));
		if (rs == 1)
			return "이미 사용 중인 아이디입니다.";
		else
			return "사용가능한 아이디입니다";
	}

	// 회원가입
	@RequestMapping("/reigst.do")
	public @ResponseBody String registMember(HttpServletRequest request) {

		int rs2 = service.alreadyRegist(request.getParameter("name"), request.getParameter("tel"));

		System.out.println(rs2);
		if (rs2 != 1) {

			String enpw = Encrypt.encrypt(request.getParameter("id"), request.getParameter("pw"));
			int rs = service.regist(request.getParameter("id"), enpw, request.getParameter("name"),
					request.getParameter("tel"), request.getParameter("email"));
			if (rs == 1)
				return "회원가입되셨습니다!. 로그인 화면으로 이동합니다.";
		} else if (rs2 == 1)
			return "이미 가입된 회원입니다. id/pw찾기를 사용하세요";
		return "다시 확인해주세요.";
	}

	// userMain 화면
	@RequestMapping("/userMain")
	public String userMain() {
		return "userMain";
	}

	// 개인정보 페이지
	@RequestMapping("/myInfo")
	public String getMyInfo(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		ArrayList<MemberDTO> list = service.getMyInfo((String) session.getAttribute("id"));
		ArrayList<MemberDTO> list2 = new ArrayList<>();

		list2 = list;
		list2.get(0).setPw(Encrypt.dencrypt(list.get(0).getId(), list.get(0).getPw()));

		model.addAttribute("list", list2);
		return "myInfo";
	}

	// 비밀번호 확인
	@RequestMapping("/CheckPw")
	public @ResponseBody String checkPw(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String enpw = service.getPw((String) session.getAttribute("id"));
		String depw = Encrypt.dencrypt((String) session.getAttribute("id"), enpw);
		System.out.println(depw);
		if (depw.equals(request.getParameter("pw")))
			return "확인되었습니다";
		else
			return "비밀번호를 다시 확인해주세요";
	}

	// 개인정보 수정
	@RequestMapping("/updateMyInfo")
	public @ResponseBody String updateMyInfo(HttpServletRequest request) {
		HttpSession session = request.getSession();

		int rs = service.updateMyInfo(Encrypt.encrypt((String) session.getAttribute("id"), request.getParameter("pw")),
				request.getParameter("Myname"), request.getParameter("tel"), request.getParameter("email"),
				(String) session.getAttribute("id"));

		if (rs == 1)
			return "수정되었습니다";
		else
			return "다시 확인해주세요";
	}

	// 미션 제공
	@RequestMapping("/getMission")
	public @ResponseBody String getMission(HttpServletRequest request) {
		int allMission = service.countMission();

		Random rd = new Random();
		int num = rd.nextInt(allMission) + 1;

		ArrayList<ProvidedMissionDTO> list = service.getMission(String.valueOf(num));
		HttpSession session = request.getSession();
		session.setAttribute("mission_name", list.get(0).getMission_name());

		return list.get(0).getMission_url();
	}

	// 포인트 가져오기
	@RequestMapping("/getPoint")
	public @ResponseBody int getPoint(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int point = service.getPoint((String) session.getAttribute("id"));
		return point;
	}

	// 포인트 사용
	@RequestMapping("/usePoint")
	public @ResponseBody String usePoint(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int rs = service.usePoint((String) session.getAttribute("id"), request.getParameter("useDay"));

		int minus = service.minusPoint((String) session.getAttribute("id"));
		if (rs == 1 && minus == 1)
			return "포인트 사용!";
		else
			return "다시 확인";
	}

	// 미션 수행 날짜 가져오기
	@RequestMapping("/doMissionList")
	public @ResponseBody String doMissionList(HttpServletRequest request) throws ParseException {
		HttpSession session = request.getSession();
		ArrayList<String> list = service.doMissionList(request.getParameter("month"),
				(String) session.getAttribute("id"));
		JSONArray array = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();
			Date date = sdf.parse(list.get(i));
			String startDate = sdf.format(date);
			obj.put("startDate", startDate);
			array.put(obj);
		}
		return array.toString();
	}

	// 포인트 사용 날짜 가져오기
	@RequestMapping("/usePointList")
	public @ResponseBody String usePointList(HttpServletRequest request) throws ParseException {
		HttpSession session = request.getSession();
		ArrayList<String> list = service.usePointList(request.getParameter("month"),
				(String) session.getAttribute("id"));
		JSONArray array = new JSONArray();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-d");
		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();
			Date date = sdf.parse(list.get(i));
			String usePointDate = sdf.format(date);
			obj.put("usePointDate", usePointDate);
			array.put(obj);
		}
		return array.toString();
	}

	// 미션 후기 가져오기
	@RequestMapping("/comment")
	public void comment(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		ArrayList<MissionCommentsDTO> list = service.getComments(request.getParameter("send_date"),
				(String) session.getAttribute("id"));

		model.addAttribute("list", list);
	}

	// 탈퇴하기

	@RequestMapping("/deleteMember")
	public String deleteMember() {
		return "deleteMember";
	}

	@RequestMapping("/delete")
	public @ResponseBody String delete(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int rs = service.deleteMember((String) session.getAttribute("id"));
		if (rs == 1)
			return "회원 탈퇴되었습니다.";
		else
			return "다시 확인";
	}

	@RequestMapping("/pwCheck")
	public @ResponseBody String pwCheck(HttpServletRequest request) {
		HttpSession session = request.getSession();

		String enpw = service.getPw((String) session.getAttribute("id"));
		String depw = Encrypt.dencrypt((String) session.getAttribute("id"), enpw);

		System.out.println(depw);
		if (depw.equals(request.getParameter("pw")))
			return "확인되었습니다";
		else
			return "비밀번호를 다시 확인해주세요";
	}

	@RequestMapping("/setComment")
	public String setComment() {
		return "setComment";
	}

	@RequestMapping("/writeComment")
	public @ResponseBody String writeComment(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String fail = request.getParameter("fail");
		Calendar calendar = Calendar.getInstance();
		Date day = new Date(calendar.getTimeInMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		String today = sdf.format(day);

		int count = service.getTodayMissionCount((String) session.getAttribute("id"), today);

		if (count == 2) {
			service.givePoint((String) session.getAttribute("id"));
		}
		System.out.println("fail :" + Integer.parseInt(fail));

		String comments = request.getParameter("comments");

		if (request.getParameter("comments") == "")
			comments = "후기 없음";

		int result = service.writeComment((String) session.getAttribute("id"), request.getParameter("date"),
				request.getParameter("time"),

				(String) session.getAttribute("mission_name"), comments);

		log.info("result : " + result);

		// 순서 왜인지 모르겠지만 중요...
		int fail_check = service.missionPercentage_Fail((String) session.getAttribute("mission_name"),
				Integer.parseInt(fail));
		int success_check = service.missionPercentage_Success((String) session.getAttribute("mission_name"));

		if (result == 1 && success_check == 1 && fail_check == 1) {
			return "메인 화면으로 이동합니다.";

		} else {
			return "망망";
		}
	}

	// 미션 제안하기
	@RequestMapping("/missionSuggest")
	public String missionSuggest() {
		return "/missionSuggest";
	}

	@RequestMapping("/suggestMission")
	public @ResponseBody String suggestMission(HttpServletRequest request) {

		HttpSession session = request.getSession();

		int rs = service.suggestMission((String) session.getAttribute("id"), request.getParameter("title"),
				request.getParameter("mission"));

		if (rs == 1)
			return "등록되었습니다";
		else
			return "다시확인..";
	}

	// 사용자가 제시한 미션 제안 목록보기
	@RequestMapping("/showMySuggestion")
	public String showMySuggestion() {
		return "/showMySuggestion";
	}

	@RequestMapping("/MySuggestionList")
	public @ResponseBody String MySuggestionList(HttpServletRequest request) {
		HttpSession session = request.getSession();

		int count = 0;
		ArrayList<SuggestDTO> list = new ArrayList<>();

		if (request.getParameter("search").equals("all")) {
			list = service.mySuggestionList((String) session.getAttribute("id"), request.getParameter("page"));
			count = service.countAllMySuggestion((String) session.getAttribute("id"));
		} else {
			list = service.searchMySuggestionList(request.getParameter("search"), (String) session.getAttribute("id"),
					request.getParameter("page"));
			count = service.countSearchMySuggestion(request.getParameter("search"),
					(String) session.getAttribute("id"));
		}
		JSONArray array = new JSONArray();

		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				JSONObject obj = new JSONObject();

				obj.put("suggest_num", list.get(i).getSuggest_num());
				obj.put("id", list.get(i).getId());
				obj.put("title", list.get(i).getTitle());
				obj.put("suggest_date", list.get(i).getDate());
				obj.put("check_state", list.get(i).getCheck_state());
				obj.put("count", count);

				array.put(obj);
			}

		} else {
			JSONObject obj = new JSONObject();
			obj.put("suggest_num", "");
			obj.put("id", "");
			obj.put("title", "");
			obj.put("suggest_date", "");
			obj.put("check_state", "");
			obj.put("count", 0);

			array.put(obj);
		}
		log.info("count:" + count);
		return array.toString();
	}

	@RequestMapping("/suggestionContent")
	public void suggestionContent(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();

		ArrayList<SuggestDTO> list = new ArrayList<>();

		list = service.suggestionContent(request.getParameter("num"));

		String state = service.getCheck_state(request.getParameter("num"));

		String admin = (String) session.getAttribute("admin");

		if (admin.equals("admin")) {
			if (state.equals("미확인")) {
				service.updateCheck_state("확인", request.getParameter("num"));
				request.setAttribute("state", "확인");

			} else if (state.equals("확인")) {
				request.setAttribute("state", "확인");

			} else if (state.equals("검토")) {
				request.setAttribute("state", "검토");
				request.setAttribute("reply", "검토중..");

			} else if (state.equals("추가")) {
				request.setAttribute("reply", "미션 업데이트..");
			} else if (state.equals("보류")) {
				request.setAttribute("reply", "보류함..");
			} else if (state.equals("개발")) {
				request.setAttribute("state", "개발");
				request.setAttribute("reply", "개발중!");
			}
			request.setAttribute("admin", "admin");
		} else {

			if (state.equals("미확인")) {
				request.setAttribute("state", "미확인");
			} else if (state.equals("검토")) {
				request.setAttribute("reply", "좋은 미션 제안 감사드립니다. 현재 검토중입니다.");
			} else if (state.equals("추가")) {
				request.setAttribute("reply", "미션이 업데이트 되었습니다.");
			} else if (state.equals("보류")) {
				request.setAttribute("reply",
						"좋은 미션 제안 감사드립니다." + "<br>신중하게 검토한 결과 귀하의 제안을 받아들이기가 어려운 실정입니다." + "<br> 이 점 널리 양해해 주시기 바랍니다.");
			} else if (state.equals("개발")) {
				request.setAttribute("state", "개발");
				request.setAttribute("reply", "제안해주신 미션이 현재 개발 중입니다. 개발 진행 상황을 확인해보세요:)");
			}
		}

		request.setAttribute("title", list.get(0).getTitle());
		request.setAttribute("date", list.get(0).getDate());
		request.setAttribute("mission", list.get(0).getMission());
		request.setAttribute("id", list.get(0).getId());
		request.setAttribute("suggest_num", list.get(0).getSuggest_num());
	}

	// 제안 업데이트
	@RequestMapping("/updateSuggestion")
	public @ResponseBody String updateSuggestion(HttpServletRequest request) {
		int rs = service.updateSuggestion(request.getParameter("title"), request.getParameter("contents"),
				request.getParameter("suggest_num"));
		if (rs == 1)
			return "수정되었습니다.";
		else
			return "다시 확인..";
	}

	// 제안 삭제
	@RequestMapping("/deleteSuggestion")
	public @ResponseBody String deleteSuggestion(HttpServletRequest request) {

		int rs = service.deleteSuggestion(request.getParameter("suggest_num"));

		if (rs == 1)
			return "삭제되었습니다.";

		return "다시 확인..";
	}

	// 개발 중인 미션 진행 상황 보기
	@RequestMapping("/showDevelopmentContent")
	public void showDevelopmentContent(HttpServletRequest request) {

		HttpSession session = request.getSession();

		String admin = (String) session.getAttribute("admin");

		if (admin.equals("admin")) {
			request.setAttribute("admin", "admin");
		}
		String suggest_num = request.getParameter("suggest_num");
		String url = request.getParameter("url");

		ArrayList<DevelopmentDTO> list = new ArrayList<>();
		ArrayList<ReplyDTO> replyList = new ArrayList<>();

		log.info("request - suggest_num :" + suggest_num);

		// 개발자 화면에서 들어갈 때
		// 개발 페이지에서 개발 진행 상황 페이지로 갈 때
		if (suggest_num == null) {

			list = service.getProgressByUrl(url);

			// 관리자 화면에서 제안서가 사용자가 제안한 건지 아닌 지 구분
			// 관리자가 개별 등록한 애들의 제안번호는 다 0!
			String check_suggestNum = service.getSuggestNumByTitle(service.getTitleByUrl(url));

			if (check_suggestNum.equals("0")) {
				request.setAttribute("suggest_num", "0");
				log.info("suggest_num :" + request.getAttribute("suggest_num"));
			} else {
				replyList = service.getNewReply(service.getTitleByUrl(url));
			}

			// 사용자 화면에서 들어갈 때
		} else {
			list = service.getProgressByNum(suggest_num);
			replyList = service.getNewReply(service.getTitleByNum(suggest_num));
		}
		// 코멘트가 null이 아닌 경우
		if (list.get(0).getComment() != null) {
			request.setAttribute("comment", list.get(0).getComment());
		}

		request.setAttribute("title", list.get(0).getTitle());
		request.setAttribute("html", list.get(0).getHtml());
		request.setAttribute("css", list.get(0).getCss());
		request.setAttribute("js", list.get(0).getJs());
		request.setAttribute("java", list.get(0).getJava());
//		request.setAttribute("progresssDate", list.get(0).getUpdateDate());

		// 댓글이 없을 경우
		if (replyList.size() == 0) {
			request.setAttribute("noReply", "noReply");
			// 댓글이 있는 경우
		} else {
			request.setAttribute("newReply", replyList.get(0).getReply_comment());
			request.setAttribute("writer", replyList.get(0).getId());
			request.setAttribute("write_date", replyList.get(0).getWrite_date());
			request.setAttribute("reply_num", replyList.get(0).getReply_num());
			request.setAttribute("id", session.getAttribute("id"));
		}
	}

	// 댓글 작성
	@RequestMapping("/insertReply")
	public @ResponseBody String insertReply(HttpServletRequest request) {

		HttpSession session = request.getSession();

		String suggest_num = service.getSuggest_num(request.getParameter("title"));

		int rs = service.writeReply((String) session.getAttribute("id"), suggest_num, request.getParameter("reply"),
				request.getParameter("title"));

		if (rs == 1)
			return "작성되었습니다.";
		else
			return "다시 확인하세요.";
	}

	// 댓글 가져오기
	@RequestMapping("/getReplyList")
	public @ResponseBody String getReplyList(HttpServletRequest request) {

		ArrayList<ReplyDTO> list = service.getReply(request.getParameter("title"));
		JSONArray array = new JSONArray();

		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("id", list.get(i).getId());
			obj.put("suggest_num", list.get(i).getSuggest_num());
			obj.put("reply_num", list.get(i).getReply_num());
			obj.put("reply_comment", list.get(i).getReply_comment());
			obj.put("write_date", list.get(i).getWrite_date());
			array.put(obj);
		}
		return array.toString();
	}

	// 댓글 수정
	@RequestMapping("/updateReply")
	public @ResponseBody String updateReply(HttpServletRequest request) {
		int rs = service.updateReply(request.getParameter("reply_comment"), request.getParameter("reply_num"));
		if (rs == 1)
			return "수정되었습니다.";
		else
			return "다시 확인>>";

	}

	// 댓글 삭제
	@RequestMapping("/deleteReply")
	public @ResponseBody String deleteReply(HttpServletRequest request) {
		int rs = service.deleteReply(request.getParameter("reply_num"));
		if (rs == 1)
			return "삭제되었습니다.";
		else
			return "다시 확인>>";

	}

	// 관리자 메인
	@RequestMapping("/adminMain")
	public String adminMain() {
		return "adminMain";
	}

	// 미션 이름들 가져오기
	@RequestMapping("/GetMissionName")
	public @ResponseBody String GetMissionName(HttpServletRequest request) {
		HttpSession session = request.getSession();

		ArrayList<SuccessDTO> list = service.getPercentage();

		JSONArray array = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("mname", list.get(i).getMission_name());
			array.put(obj);
		}
		session.setAttribute("list", array.toString());
		return array.toString();
	}

	// 미션 성공률 가져오기
	@RequestMapping("/GetMissionPercentage")
	public @ResponseBody String GetMissionPercentage(HttpServletRequest request) {
		HttpSession session = request.getSession();

		ArrayList<SuccessDTO> list = service.getPercentage();
		JSONArray array = new JSONArray();
		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();
			obj.put("percentage", list.get(i).getPercentage());
			array.put(obj);
		}
		session.setAttribute("list", array.toString());
		return array.toString();
	}

	// 회원 정보
	@RequestMapping("/memberList")
	public String memberList() {
		return "/memberList";
	}

	@RequestMapping("/getMemberList")
	public @ResponseBody String getMemberList(HttpServletRequest request) {
		ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();

		String page = (request.getParameter("page"));
		String column = request.getParameter("column");
		String mean = request.getParameter("mean");
		int count = 0;

		if (column.equals("all")) {
			list = service.allMemberList(page);
			count = service.countMemberList();
		} else if (column.equals("id")) {
			list = service.searchIdMemberList(mean, page);
			count = service.countSearchIdMemberList(mean);
		} else if (column.equals("name")) {
			list = service.searchNameMemberList(mean, page);
			count = service.countSearchNameMemberList(mean);
		}

		JSONArray array = new JSONArray();

		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				JSONObject obj = new JSONObject();

				obj.put("id", list.get(i).getId());
				obj.put("pw", list.get(i).getPw());
				obj.put("name", list.get(i).getName());
				obj.put("tel", list.get(i).getTel());
				obj.put("email", list.get(i).getEmail());
				obj.put("reg_date", list.get(i).getReg_date());
				obj.put("count", count);
				array.put(obj);
			}

		} else {
			JSONObject obj = new JSONObject();
			obj.put("id", "");
			obj.put("pw", "");
			obj.put("name", "");
			obj.put("tel", "");
			obj.put("email", "");
			obj.put("reg_date", "");
			obj.put("count", 0);
			array.put(obj);

		}

		return array.toString();
	}

	// 탈퇴 회원 정보
	@RequestMapping("/memberDeleteList")
	public String memberDeleteList() {
		return "/memberDeleteList";
	}

	@RequestMapping("/getMemberDeleteList")
	public @ResponseBody String getMemberDeleteList(HttpServletRequest request) {

		String page = (request.getParameter("page"));
		String column = request.getParameter("column");
		String mean = request.getParameter("mean");
		int count = 0;
		ArrayList<DeleteMemberDTO> list = new ArrayList<DeleteMemberDTO>();

		if (column.equals("all")) {
			list = service.allDeleteMemberList(page);
			count = service.countDeleteMemberList();
		} else if (column.equals("id")) {
			list = service.searchIdDeleteMemberList(mean, page);
			count = service.countSearchIdDeleteMemberList(mean);
		} else if (column.equals("name")) {
			list = service.searchNameDeleteMemberList(mean, page);
			count = service.countSearchNameDeleteMemberList(mean);
		}

		JSONArray array = new JSONArray();

		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				JSONObject obj = new JSONObject();

				obj.put("id", list.get(i).getId());
				obj.put("pw", list.get(i).getPw());
				obj.put("name", list.get(i).getName());
				obj.put("tel", list.get(i).getTel());
				obj.put("email", list.get(i).getEmail());
				obj.put("reg_date", list.get(i).getReg_date());
				obj.put("sec_date", list.get(i).getSec_date());
				obj.put("count", count);
				array.put(obj);
			}

		} else {
			JSONObject obj = new JSONObject();

			obj.put("id", "");
			obj.put("pw", "");
			obj.put("name", "");
			obj.put("tel", "");
			obj.put("email", "");
			obj.put("reg_date", "");
			obj.put("sec_date", "");
			obj.put("count", 0);
			array.put(obj);
		}

		return array.toString();
	}

	// 새로운 미션 알리기
	@RequestMapping("/alterNewMission")
	public @ResponseBody String alterNewMission() {

		Integer suggest_num = service.getNewMissionSuggestNum();
		String mission_name = service.getNewMissionName();

		if (suggest_num == null) {
			return "랜덤으로 게임을 즐겨보세요~~";
		} else if (suggest_num != 0) {
			String id = service.getNewMissionId(suggest_num);
			return id + "님이 제안해주신 미션 [" + mission_name + "] 새로 등록되었습니다!";
		} else if (suggest_num == 0) {
			return "미션 [" + mission_name + "] 새로 등록되었습니다!";
		}
		return "pass";
	}

	// 미션 리스트 가져오기
	@RequestMapping("/missionList")
	public String missionList() {
		return "missionList";
	}

	@RequestMapping("/getMissionList")
	public @ResponseBody String getMissionList(HttpServletRequest request) {

		ArrayList<MissionDTO> list = service.getAllMission(request.getParameter("page"));

		JSONArray array = new JSONArray();
		int count = service.countMission();
		for (int i = 0; i < list.size(); i++) {
			JSONObject obj = new JSONObject();

			obj.put("page", list.get(i).getMission_url());
			obj.put("num", list.get(i).getNum());
			obj.put("name", list.get(i).getMission_name());
			obj.put("date", list.get(i).getInsert_date());
			obj.put("count", count);
			array.put(obj);
		}
		return array.toString();
	}

	// 제안서 리스트 가져오기
	@RequestMapping("/suggestionList")
	public String suggestinList() {
		return "suggestionList";
	}

	@RequestMapping("/getSuggestionList")
	public @ResponseBody String getSuggestionList(HttpServletRequest request) {
		ArrayList<SuggestDTO> list = new ArrayList<>();

		String search = request.getParameter("search");
		String page = request.getParameter("page");
		int count = 0;
		if (search.equals("all")) {
			list = service.allSuggestionList(page);
			count = service.countSearchAllSuggestionList();
		} else {
			list = service.searchAllSuggestionList(search, page);
			count = service.countSearchSuggestionList(search);
		}
		log.info("mean :" + search);

		JSONArray array = new JSONArray();

		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				JSONObject obj = new JSONObject();
				obj.put("suggest_num", list.get(i).getSuggest_num());
				obj.put("id", list.get(i).getId());
				obj.put("title", list.get(i).getTitle());
				obj.put("suggest_date", list.get(i).getDate());
				obj.put("check_state", list.get(i).getCheck_state());
				obj.put("count", count);

				array.put(obj);
			}

		} else {
			JSONObject obj = new JSONObject();
			obj.put("suggest_num", "");
			obj.put("id", "");
			obj.put("title", "");
			obj.put("suggest_date", "");
			obj.put("check_state", "");
			obj.put("count", 0);

			array.put(obj);
		}

		log.info("count :" + count);
		return array.toString();
	}

	// 개발 목록 가져오기
	@RequestMapping("/developmentList")
	public String developmentList() {
		return "developmentList";
	}

	@RequestMapping("/getDevelopmentList")
	public @ResponseBody String getDevelopmentList(HttpServletRequest request) throws ParseException {

		ArrayList<DevelopmentDTO> list = new ArrayList<>();
		String page = request.getParameter("page");
		String column = request.getParameter("column");
		String mean = request.getParameter("mean");
		int count = 0;

		if (column.equals("all")) {
			list = service.allDevelopmentList(page);
			count = service.countAllDevelopmentList();
		} else if (column.equals("id")) {
			list = service.searchIdDevelopmentList(mean, page);
			count = service.countSearchIdDevelopmentList(mean);
		} else if (column.equals("title")) {
			list = service.searchTitleDevelopmentList(mean, page);
			count = service.countSearchTitleDevelopmentList(mean);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		JSONArray array = new JSONArray();

		if (list.size() != 0) {
			for (int i = 0; i < list.size(); i++) {
				JSONObject obj = new JSONObject();
				Date start_date = sdf.parse(list.get(i).getStartDate());
				String startDate = sdf.format(start_date);

				Date update_date = sdf.parse(list.get(i).getUpdateDate());
				String updateDate = sdf.format(update_date);

				obj.put("title", list.get(i).getTitle());
				obj.put("url", list.get(i).getUrl());
				obj.put("startDate", startDate);
				obj.put("updateDate", updateDate);
				obj.put("id", list.get(i).getId());
				obj.put("count", count);
				int html = list.get(i).getHtml();
				int css = list.get(i).getCss();
				int js = list.get(i).getJs();
				int java = list.get(i).getJava();
				int rs = (html + css + js + java) / 4;

				obj.put("avg", rs);
				array.put(obj);
			}

		} else {
			JSONObject obj = new JSONObject();

			obj.put("title", "");
			obj.put("count", 0);
			array.put(obj);

		}
		log.info("array :" + array.toString());
		return array.toString();
	}

	// progress bar 보기
	@RequestMapping("/progressBar")
	public void getProgressBar(HttpServletRequest request) {

		log.info("title :" + request.getParameter("title"));
		ArrayList<DevelopmentDTO> list = service.getProgressByTitle(request.getParameter("title"));

		request.setAttribute("title", request.getParameter("title"));
		request.setAttribute("html", list.get(0).getHtml());
		request.setAttribute("css", list.get(0).getCss());
		request.setAttribute("js", list.get(0).getJs());
		request.setAttribute("java", list.get(0).getJava());

	}

	// 진행 상황 업데이트
	@RequestMapping("/updateProgressContent")
	public @ResponseBody String updateProgressContent(HttpServletRequest request) {

		int rs = service.updateProgressMission(request.getParameter("title"), request.getParameter("comment"),
				Integer.parseInt(request.getParameter("html")), Integer.parseInt(request.getParameter("css")),
				Integer.parseInt(request.getParameter("js")), Integer.parseInt(request.getParameter("java")));

		if (rs == 1)
			return "수정되었습니다!";
		else
			return "다시 확인>>";
	}

	// 새 미션 추가 + 파일 처리
	@RequestMapping("/addNewMission")
	public @ResponseBody String addNewMission(HttpServletRequest request) {

		String url = service.getUrlFromDevelopment(request.getParameter("title"));
		String suggest_num = service.getSuggest_num(request.getParameter("title"));

		int updateComment = service.updateBeforeAdd(request.getParameter("title"), request.getParameter("comment"));
		int deleteCheck = service.deletAtDevelopmet(request.getParameter("title"));
		int insertReply = service.insertReplyToAddMission(request.getParameter("reply"), request.getParameter("title"));
		int deleteReply = service.delteReplyAtDevelopmet(suggest_num);
		int addMission = service.addNewMission(request.getParameter("title"), url);

		ArrayList<AddMissionDTO> list = service.getAddMissionProgressContent(request.getParameter("title"));

		log.info("updateComment :" + updateComment);
		log.info("deleteCheck :" + deleteCheck);
		log.info("insertReply :" + insertReply);
		log.info("deleteReply :" + deleteReply);
		log.info("addMission :" + addMission);

		String filePath = "C:\\dev\\progressContent\\";

		for (int i = 0; i < list.size(); i++) {
			// 파일 만들기
			try {
				// 파일안에 문자열 쓰기
				FileWriter fw = new FileWriter(filePath + request.getParameter("title") + " 개발일지");
				fw.write("제안 번호 :" + list.get(0).getSuggeset_num() + "\n");
				fw.write("개발 담당자 :" + list.get(0).getId() + "\n");
				fw.write("미션 명 :" + list.get(0).getTitle() + "\n");
				fw.write("미션 주소 :" + list.get(0).getUrl() + "\n");
				fw.write("개발 시작 일 :" + list.get(0).getStartDate() + "\n");
				fw.write("개발 종료 일 :" + list.get(0).getUpdateDate() + "\n");
				fw.write("미션 등록 일 :" + list.get(0).getInsertDate() + "\n");
				fw.write("개발 일지 :" + list.get(0).getComments() + "\n");
				fw.write("미션 기획자 대화 :" + list.get(0).getReply() + "\n");
				fw.flush();
				// 객체 닫기
				fw.close();
				log.info("파일 생성");

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		if (!suggest_num.equals("0")) {
			int checkState = service.updateCheck_state("추가", suggest_num);
			log.info("checkState :" + checkState);

			if (updateComment == 1 && addMission == 1 && checkState == 1 && deleteCheck == 1 && insertReply == 1
					&& deleteReply >= 0)
				return "미션 추가되었습니다.";
		} else {

			if (updateComment == 1 && addMission == 1 && deleteCheck == 1 && insertReply == 1 && deleteReply >= 0)
				return "미션 추가되었습니다.";
		}
		return "다시 확인>>";
	}

	// 검토로 바꾸기
	@RequestMapping("/examine")
	public @ResponseBody String examine(HttpServletRequest request) {

		int rs = service.updateCheck_state("검토", request.getParameter("num"));
		if (rs == 1)
			return "변경되었습니다.";
		else
			return "다시 확인해보세요";
	}

	// 보류로 바꾸기
	@RequestMapping("/withhold")
	public @ResponseBody String withhold(HttpServletRequest request) {
		int rs = service.updateCheck_state("보류", request.getParameter("num"));
		if (rs == 1)
			return "변경되었습니다.";
		else
			return "다시 확인해보세요";
	}

	// 개발 등록
	@RequestMapping("/developmentInsert")
	public String developmentInsert() {
		return "developmentInsert";
	}

	// 개발할 미션 등록
	@RequestMapping("/insertDevelopment")
	public @ResponseBody String insertDevelopment(HttpServletRequest request) {
		HttpSession session = request.getSession();

		String url = request.getParameter("url");

		int rs = service.insertDevelopment(request.getParameter("suggest_num"), request.getParameter("title"), url,
				(String) session.getAttribute("id"));

		int check = service.updateCheck_state("개발", request.getParameter("suggest_num"));

		if (rs == 1 || check == 1)
			return "등록되었습니다";
		else
			return "다시 확인해보세요";
	}

	// 미션 이름 중복확인
	@RequestMapping("/developmentNameCheck")
	public @ResponseBody String developmentNameCheck(HttpServletRequest request) {

		int developCheck = service.nameCheckAtDevelop(request.getParameter("mission_name"));
		int missionCheck = service.nameCheckAtMission(request.getParameter("mission_name"));

		System.out.println(developCheck);
		System.out.println(missionCheck);

		if (developCheck == 1 || missionCheck == 1)
			return "이미 사용중인 미션명입니다.";
		else
			return "사용 가능한 미션명입니다.";

	}

	// 미션 주소 체크
	@RequestMapping("/developmentUrlCheck")
	public @ResponseBody String developmentUrlCheck(HttpServletRequest request) {

		int developCheck = service.urlCheckAtDevelop(request.getParameter("mission_url"));
		int missionCheck = service.urlCheckAtMission(request.getParameter("mission_url"));
		log.info("url :" + request.getParameter("mission_url"));
		log.info("developCheck :" + developCheck);
		log.info("missionCheck :" + missionCheck);

		if (developCheck == 1 || missionCheck == 1)
			return "이미 사용중인 미션주소입니다.";
		else
			return "사용 가능한 미션주소입니다.";
	}

	// 개발 중인 미션 페이지로 이동
	@RequestMapping("/moveMissionDevelopPage")
	public String moveMissionDevelopPage(HttpServletRequest request) {

		String url = service.getUrlFromDevelopment(request.getParameter("title"));
		log.info("url :" + url);

		return "redirect:" + url;
	}

}