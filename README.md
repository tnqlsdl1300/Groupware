# Osung Groupware

_오성 그룹웨어 프로젝트_

<img src="https://github.com/tnqlsdl1300/GitHub/blob/4c558df33f6c5ccd341e0a94b98d0393926cfafa/groupware_src/osunglogo2.png" width="200" />

## 소개

- 회사 내 일정, 전자결재, 사내 쪽지, 근태 관리 등을 한번에 처리해 업무 효율을 높일 수 있게 해주는 그룹웨어 서비스 입니다.
- 개발기간: 2020.11.24 ~ 2021.01.03 (약 4주)
- 개발인원: 5명

## 기술스택

> Back-end/Server

- Java
- Spring MVC
- Jsp
- Apache Tomcat v8.5
- OracleDB
- Mybatis 

> Front-end

- Javascript
- JQuery
- HTML 5 & CSS3
- Bootstrap 3

> Devops

- Maven
- STS 3
- Git
- Github

## DB 구조

`전체`

![exerd](https://github.com/tnqlsdl1300/GitHub/blob/53c364534ed30e39a1cd205162dc4c4b28687415/groupware_src/exerd.PNG)

`부분(본인 구현 파트)`

![exerd_mypart](https://github.com/tnqlsdl1300/GitHub/blob/53c364534ed30e39a1cd205162dc4c4b28687415/groupware_src/exerd_mypart.PNG)

## 기능

본인이 구현한 기능은 **굵게** 강조했습니다.

* 쪽지
  * 쪽지쓰기
  * 보낸/받은 쪽지함
  * 중요/임시/예약 보관함
  * 휴지통
* 전자결재
  * 새결재진행
  * 결재 대기/진행/완료 문서
* 근태관리
  * 연차신청
  * 승인 대기/진행/완료 문서
  * 출퇴근현황
* **ToDo+**
  * **보드 생성 / 삭제 / 수정**
  * **보드 즐겨찾기**
* **일정 관리**
  * **일정 캘린더**
    * **open source library fullcalendar 사용**
    * **캘린더를 통한 일정 조회**
    * **일정 등록 / 삭제 / 수정**
    * **초대받은 일정 캘린더**
      * **일정 등록자의 경우 수정 / 삭제 가능**
      * **초대받은 사원일 경우 수정 / 삭제 불가능**
  * **내 캘린더 관리**
    * **캘린더 등록 / 삭제 / 수정**
      * **캘린더 삭제 시 해당하는 일정들도 함께 삭제**
* **자원 예약**
  * **예약 캘린더**
    * **open source library fullcalendar 사용**
    * **캘린더를 통한 예약 조회**
    * **예약 등록 / 취소**
  * **나의 예약 목록**
    * **유효한 자원 정보 및 예약 조회**
    * **예약 취소**

* 게시판
  * 공지 게시판
  * 일반 게시판
  * 자료실
* 주소록
  * 전사 주소록
  * 개인 주소록
* 조직도

## 시연영상(ToDo+/일정/예약 - 본인 구현 파트)

<a href="https://youtu.be/D9VRsz97MsY">
  <img src="https://github.com/tnqlsdl1300/GitHub/blob/3077e311452d75c3a9e0dda766989ca66ceded03/groupware_src/calendar.PNG" width="500" />
</a>

`기능 설명을 위한 자막이 있습니다. 유튜브 자막을 켜주시길 바랍니다.` 

## 수정사항

- ToDo+ 기존의 페이지 이동 방식에서 모든 처리를 Ajax로 변경

  `변경전`
  <img src = "https://github.com/tnqlsdl1300/GitHub/blob/9d5b60bf910b8e6924c77d6f768041e743980c14/groupware_src/todoAjaxX.gif" width="500">

  `변경후`

  <img src = "https://github.com/tnqlsdl1300/GitHub/blob/72fcf1dac77540b03d90df8340abb640b5c6f067/groupware_src/todoAjaxO.gif" width="500">

