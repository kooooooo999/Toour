# Toour 프로젝트

## 프로젝트 설정

### 1. API 키 설정

이 프로젝트는 외부 API 키가 필요합니다. 다음 단계를 따라 설정하세요:

1. `src/main/resources/api.properties.example` 파일을 `api.properties`로 복사합니다:
   ```bash
   # Windows (PowerShell)
   Copy-Item src\main\resources\api.properties.example src\main\resources\api.properties
   
   # Windows (CMD)
   copy src\main\resources\api.properties.example src\main\resources\api.properties
   
   # Mac/Linux
   cp src/main/resources/api.properties.example src/main/resources/api.properties
   ```

2. `src/main/resources/api.properties` 파일을 열고 실제 API 키 값을 입력하세요:
   - 공공데이터 포털 서비스 인증키
   - 카카오 API 키
   - 네이버 API 키

**⚠️ 중요**: `api.properties` 파일은 Git에 커밋되지 않습니다. 각 개발자는 자신의 API 키를 설정해야 합니다.

### 2. 데이터베이스 설정

1. `src/main/resources/db.properties.example` 파일을 `db.properties`로 복사합니다:
   ```bash
   # Windows (PowerShell)
   Copy-Item src\main\resources\db.properties.example src\main\resources\db.properties
   
   # Windows (CMD)
   copy src\main\resources\db.properties.example src\main\resources\db.properties
   
   # Mac/Linux
   cp src/main/resources/db.properties.example src/main/resources/db.properties
   ```

2. `src/main/resources/db.properties` 파일을 열고 실제 데이터베이스 연결 정보를 입력하세요:
   - 데이터베이스 호스트 주소
   - 데이터베이스 이름
   - 데이터베이스 사용자명
   - 데이터베이스 비밀번호

**⚠️ 중요**: `db.properties` 파일은 Git에 커밋되지 않습니다. 각 개발자는 자신의 데이터베이스 정보를 설정해야 합니다.

### 3. 필요한 API 키

- **공공데이터 포털 서비스 인증키**: 한국관광공사 Tour API
- **카카오 API 키**: 
  - Map Appkey (카카오 맵)
  - JavaScript Key (카카오 로그인)
  - REST API Key (카카오 로그인)
  - Mobile Key (카카오 모빌리티)
- **네이버 API 키**:
  - Client ID (네이버 로그인)
  - Client Secret (네이버 로그인)

## 빌드 및 실행

```bash
mvn clean install
mvn tomcat7:run
```

## 주의사항

- `api.properties` 파일은 `.gitignore`에 포함되어 있어 Git에 커밋되지 않습니다.
- 실제 API 키는 절대 공개 저장소에 커밋하지 마세요.
