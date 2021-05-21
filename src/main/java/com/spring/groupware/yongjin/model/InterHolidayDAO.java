package com.spring.groupware.yongjin.model;

import java.util.List;
import java.util.Map;

import com.spring.groupware.mina.model.AttendanceVO;

public interface InterHolidayDAO {

	// 휴가 내역 count
	int historyNumber(Map<String, String> paraMap);

	// 휴가 내역 목록
	List<AttendanceVO> historyList(Map<String, String> paraMap);

}
