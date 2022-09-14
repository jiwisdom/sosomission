package com.green.mission.service;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

import com.green.mission.db.AddMissionDTO;
import com.green.mission.db.DeleteMemberDTO;
import com.green.mission.db.DevelopmentDTO;
import com.green.mission.db.MemberDTO;
import com.green.mission.db.MissionCommentsDTO;
import com.green.mission.db.MissionDTO;
import com.green.mission.db.ProvidedMissionDTO;
import com.green.mission.db.ReplyDTO;
import com.green.mission.db.SuccessDTO;
import com.green.mission.db.SuggestDTO;

@Mapper
public interface IService {
	public String getUserName(String id,String pw);
	public String getAdminName(String id,String pw);
	public String findId(String name, String tel);
	public String findPw(String id, String tel);
	public int idCheck(String id);
	public int regist(String id,String pw,String name,String tel,String email);
	public int alreadyRegist(String name,String tel);
	public ArrayList<MemberDTO> getMyInfo(String id);
	public String getPw(String id);
	public int updateMyInfo(String pw,String name,String tel,String email,String id);
	public int getPoint(String id);
	public int deleteMember(String id);
	public int givePoint(String id);
	//미션
	public int countMission();
	public ArrayList<ProvidedMissionDTO> getMission(String num);
	public int usePoint(String id,String useDay);
	public int minusPoint(String id);
	public  ArrayList<String> usePointList(String month,String id);
	public  ArrayList<String> doMissionList(String month,String id);
	public ArrayList<MissionCommentsDTO> getComments(String startdate,String id);
	public int getTodayMissionCount(String id,String today);
	public int missionPercentage_Fail(String mission_name,int fail);
	public int missionPercentage_Success(String mission_name);
	
	public int writeComment(String id, String startDate, String startTime, String mname,String comment);
//	public int domission(String id, String startDate, String startTime, String mname);
	
	
	public int suggestMission(String id, String title, String suggestion);
	
	public ArrayList<SuggestDTO> mySuggestionList(String id,String page);
	public ArrayList<SuggestDTO> searchMySuggestionList(String mean,String id,String page);
	public int countAllMySuggestion(String id);
	public int countSearchMySuggestion(String mean,String id);
	
	public ArrayList<SuggestDTO> suggestionContent(String suggest_num) ;
	public String getCheck_state(String num);
	public int updateCheck_state(String state,String num);
	public String getTitleByNum(String suggest_num) ;
	public String getTitleByUrl(String url) ;
	public String getSuggestNumByTitle(String title);
	public String getSuggest_num(String title);
	public int updateSuggestion(String title,String contents, String suggest_num);
	public int deleteSuggestion(String suggest_num);
	
	public ArrayList<DevelopmentDTO> getProgressByUrl(String mean);
	public ArrayList<DevelopmentDTO> getProgressByNum(String mean);
	public ArrayList<DevelopmentDTO> getProgressByTitle(String mean);
	
	public int writeReply(String id,String suggest_num,String reply_comment,String title);
	public ArrayList<ReplyDTO> getReply(String title);
	public ArrayList<ReplyDTO> getNewReply(String title);
	public ArrayList<SuccessDTO> getPercentage();
	
	public ArrayList<MemberDTO> allMemberList(String page);
	public ArrayList<MemberDTO> searchIdMemberList(String mean,String page); 
	public ArrayList<MemberDTO> searchNameMemberList(String mean,String page); 
	public int countMemberList();
	public int countSearchIdMemberList(String mean);
	public int countSearchNameMemberList(String mean);
	
	public ArrayList<DeleteMemberDTO> allDeleteMemberList(String page);
	public ArrayList<DeleteMemberDTO> searchIdDeleteMemberList(String mean,String page); 
	public ArrayList<DeleteMemberDTO> searchNameDeleteMemberList(String mean,String page); 
	public int countDeleteMemberList();
	public int countSearchIdDeleteMemberList(String mean);
	public int countSearchNameDeleteMemberList(String mean);
	
	public Integer getNewMissionSuggestNum();
	public String getNewMissionId(int suggest_num);
	public String getNewMissionName();
	
	public ArrayList<MissionDTO> getAllMission(String page);
	
	public ArrayList<SuggestDTO> allSuggestionList(String page);
	public ArrayList<SuggestDTO> searchAllSuggestionList(String mean,String page);
	public int countSearchAllSuggestionList();
	public int countSearchSuggestionList(String mean);
	
	public ArrayList<DevelopmentDTO> allDevelopmentList(String page);
	public ArrayList<DevelopmentDTO> searchTitleDevelopmentList(String page,String mean);
	public ArrayList<DevelopmentDTO> searchIdDevelopmentList(String page,String mean);
	
	public int countAllDevelopmentList();
	public int countSearchIdDevelopmentList(String mean);
	public int countSearchTitleDevelopmentList(String mean);
	public int updateProgressMission(String title,String comment,int html,int css,int js,int java);
	
	public String getUrlFromDevelopment(String title);
	public int addNewMission(String mission_name, String missionUrl);
	public int updateBeforeAdd(String title,String comment);
	public int insertDevelopment(String suggest_num,String title,String url,String id) ;
	public int nameCheckAtDevelop(String title);
	public int nameCheckAtMission(String mission_name);
	
	public int urlCheckAtDevelop(String url);
	public int urlCheckAtMission(String url);
	
	public int deletAtDevelopmet(String title);
	
	public int delteReplyAtDevelopmet(String suggest_num);
	public int insertReplyToAddMission(String reply,String title);
	
	public ArrayList<AddMissionDTO> getAddMissionProgressContent(String title);

	public int updateReply(String comment,String reply_num);
	public int deleteReply(String reply_num);
}
