# Toour 아이디/비밀번호 찾기 기능 구현

## 개요
Toour 프로젝트에 아이디 찾기와 비밀번호 찾기 기능을 추가했습니다.

## 구현된 기능

### 1. 아이디 찾기
- **입력 정보**: 이름, 이메일
- **동작 방식**: 이름과 이메일이 일치하는 회원의 아이디를 화면에 표시
- **접근 경로**: `Controller?type=findId`

### 2. 비밀번호 찾기
- **입력 정보**: 아이디, 이름, 이메일
- **동작 방식**: 
  1. 입력 정보가 일치하는 회원 확인
  2. 8자리 임시 비밀번호 생성
  3. 새로운 salt 생성 후 해시화
  4. DB에 임시 비밀번호 업데이트
  5. 이메일로 임시 비밀번호 전송
- **접근 경로**: `Controller?type=findPassword`

### 3. 임시 비밀번호 관리
- **자동 플래그 설정**: 비밀번호 찾기 시 `is_temp_password = 1`로 설정
- **강제 비밀번호 변경**: 임시 비밀번호로 로그인 시 비밀번호 변경 페이지로 자동 이동
- **플래그 해제**: 새 비밀번호 설정 시 `is_temp_password = 0`으로 자동 변경

## 추가된 파일

### Java 클래스
- `src/main/java/toour/login/action/FindIdAction.java` - 아이디 찾기 Action
- `src/main/java/toour/login/action/FindPasswordAction.java` - 비밀번호 찾기 Action
- `src/main/java/toour/login/action/ChangePasswordAction.java` - 임시 비밀번호 변경 Action

### JSP 페이지
- `src/main/webapp/member/findId.jsp` - 아이디 찾기 페이지
- `src/main/webapp/member/findPassword.jsp` - 비밀번호 찾기 페이지
- `src/main/webapp/member/changePassword.jsp` - 임시 비밀번호 변경 페이지

### 설정 파일
- `src/main/webapp/WEB-INF/action.properties` - Action 매핑 추가
- `src/main/resources/mybatis/mapper/member.xml` - MyBatis 쿼리 추가

## 수정된 파일

### Java 클래스
- `src/main/java/toour/login/dao/MemberDAO.java` - 새로운 메서드 추가
- `src/main/java/toour/util/EmailUtil.java` - 임시 비밀번호 전송 메서드 추가
- `src/main/java/toour/member/vo/MemberVO.java` - is_temp_password 필드 추가
- `src/main/java/toour/login/action/loginAction.java` - 임시 비밀번호 로그인 처리
- `src/main/java/toour/member/action/myInfoAction.java` - 비밀번호 변경 시 플래그 해제

### JSP 페이지
- `src/main/webapp/member/login.jsp` - 아이디/비밀번호 찾기 링크 추가

## 데이터베이스 변경사항

### 새로운 컬럼
- `member.is_temp_password`: 임시 비밀번호 여부 (0: 일반, 1: 임시)

### SQL 스크립트
```sql
ALTER TABLE member ADD COLUMN is_temp_password TINYINT(1) DEFAULT 0 COMMENT '임시 비밀번호 여부 (0: 일반, 1: 임시)';
UPDATE member SET is_temp_password = 0 WHERE is_temp_password IS NULL;
```

## 사용법

### 1. 로그인 페이지에서 링크 클릭
로그인 페이지 하단에 "아이디 찾기"와 "비밀번호 찾기" 링크가 추가되었습니다.

### 2. 아이디 찾기
1. 이름과 이메일 입력
2. "아이디 찾기" 버튼 클릭
3. 일치하는 회원이 있으면 아이디 표시

### 3. 비밀번호 찾기
1. 아이디, 이름, 이메일 입력
2. "임시 비밀번호 발급" 버튼 클릭
3. 일치하는 회원이 있으면 임시 비밀번호를 이메일로 전송
4. 로그인 후 반드시 비밀번호 변경 필요

### 4. 임시 비밀번호 관리
1. 임시 비밀번호로 로그인 시 자동으로 비밀번호 변경 페이지로 이동
2. 새 비밀번호 입력 및 확인
3. 비밀번호 변경 완료 시 `is_temp_password` 플래그가 자동으로 0으로 변경
4. 일반 사용자로 서비스 이용 가능

## 보안 고려사항

1. **임시 비밀번호**: 8자리 랜덤 생성 (영문 대소문자 + 숫자)
2. **Salt 재생성**: 비밀번호 찾기 시마다 새로운 salt 생성
3. **이메일 인증**: 등록된 이메일로만 임시 비밀번호 전송
4. **LOCAL 계정만**: 소셜 로그인 계정은 제외
5. **강제 비밀번호 변경**: 임시 비밀번호 사용자는 반드시 새 비밀번호 설정
6. **자동 플래그 관리**: 비밀번호 변경 시 자동으로 임시 비밀번호 플래그 해제

## 이메일 설정

Gmail SMTP를 사용하여 임시 비밀번호를 전송합니다.
- **SMTP 서버**: smtp.gmail.com
- **포트**: 587
- **보안**: STARTTLS

## 주의사항

1. **임시 비밀번호**: 로그인 후 반드시 변경해야 합니다.
2. **이메일 확인**: 스팸 메일함도 확인해보세요.
3. **계정 타입**: LOCAL 계정만 사용 가능합니다 (소셜 로그인 제외).
4. **자동 리다이렉트**: 임시 비밀번호 사용자는 메인 페이지 접근 시 자동으로 비밀번호 변경 페이지로 이동됩니다.

## 테스트 방법

1. 프로젝트 실행
2. 로그인 페이지 접속
3. "아이디 찾기" 또는 "비밀번호 찾기" 링크 클릭
4. 테스트용 회원 정보로 기능 테스트
5. 임시 비밀번호로 로그인하여 비밀번호 변경 페이지 자동 이동 확인
6. 새 비밀번호 설정 후 일반 사용자로 서비스 이용 확인

## 문제 해결

### 이메일 전송 실패
- Gmail 앱 비밀번호 확인
- SMTP 설정 확인
- 방화벽/보안 소프트웨어 설정 확인

### 데이터베이스 오류
- `is_temp_password` 컬럼 존재 여부 확인
- MyBatis 매퍼 설정 확인
- 데이터베이스 연결 상태 확인

### 임시 비밀번호 관련
- `is_temp_password` 컬럼 값 확인 (0 또는 1)
- 세션에 저장된 회원 정보의 `is_temp_password` 값 확인
- 비밀번호 변경 후 플래그가 0으로 변경되었는지 확인
