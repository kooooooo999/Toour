@echo off
echo ========================================
echo 환경 설정 파일 생성
echo ========================================
echo.

REM API 키 설정 파일 생성
if exist "src\main\resources\api.properties" (
    echo [경고] api.properties 파일이 이미 존재합니다.
    echo 기존 파일을 덮어쓰시겠습니까? (Y/N)
    set /p overwrite=
    if /i not "%overwrite%"=="Y" (
        echo api.properties 파일 생성을 건너뜁니다.
    ) else (
        copy "src\main\resources\api.properties.example" "src\main\resources\api.properties"
        if %errorlevel% equ 0 (
            echo [성공] api.properties 파일이 생성되었습니다.
        ) else (
            echo [오류] api.properties 파일 복사에 실패했습니다.
        )
    )
) else (
    copy "src\main\resources\api.properties.example" "src\main\resources\api.properties"
    if %errorlevel% equ 0 (
        echo [성공] api.properties 파일이 생성되었습니다.
    ) else (
        echo [오류] api.properties 파일 복사에 실패했습니다.
    )
)

echo.

REM 데이터베이스 설정 파일 생성
if exist "src\main\resources\db.properties" (
    echo [경고] db.properties 파일이 이미 존재합니다.
    echo 기존 파일을 덮어쓰시겠습니까? (Y/N)
    set /p overwrite=
    if /i not "%overwrite%"=="Y" (
        echo db.properties 파일 생성을 건너뜁니다.
    ) else (
        copy "src\main\resources\db.properties.example" "src\main\resources\db.properties"
        if %errorlevel% equ 0 (
            echo [성공] db.properties 파일이 생성되었습니다.
        ) else (
            echo [오류] db.properties 파일 복사에 실패했습니다.
        )
    )
) else (
    copy "src\main\resources\db.properties.example" "src\main\resources\db.properties"
    if %errorlevel% equ 0 (
        echo [성공] db.properties 파일이 생성되었습니다.
    ) else (
        echo [오류] db.properties 파일 복사에 실패했습니다.
    )
)

echo.
echo ========================================
echo 설정 완료
echo ========================================
echo 다음 파일들을 열어서 실제 값을 입력하세요:
echo - src\main\resources\api.properties
echo - src\main\resources\db.properties
echo.

pause

