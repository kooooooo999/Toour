#!/bin/bash

echo "========================================"
echo "환경 설정 파일 생성"
echo "========================================"
echo ""

# API 키 설정 파일 생성
if [ -f "src/main/resources/api.properties" ]; then
    echo "[경고] api.properties 파일이 이미 존재합니다."
    echo "기존 파일을 덮어쓰시겠습니까? (y/N)"
    read -r overwrite
    if [ "$overwrite" = "y" ] || [ "$overwrite" = "Y" ]; then
        cp "src/main/resources/api.properties.example" "src/main/resources/api.properties"
        if [ $? -eq 0 ]; then
            echo "[성공] api.properties 파일이 생성되었습니다."
        else
            echo "[오류] api.properties 파일 복사에 실패했습니다."
        fi
    else
        echo "api.properties 파일 생성을 건너뜁니다."
    fi
else
    cp "src/main/resources/api.properties.example" "src/main/resources/api.properties"
    if [ $? -eq 0 ]; then
        echo "[성공] api.properties 파일이 생성되었습니다."
    else
        echo "[오류] api.properties 파일 복사에 실패했습니다."
    fi
fi

echo ""

# 데이터베이스 설정 파일 생성
if [ -f "src/main/resources/db.properties" ]; then
    echo "[경고] db.properties 파일이 이미 존재합니다."
    echo "기존 파일을 덮어쓰시겠습니까? (y/N)"
    read -r overwrite
    if [ "$overwrite" = "y" ] || [ "$overwrite" = "Y" ]; then
        cp "src/main/resources/db.properties.example" "src/main/resources/db.properties"
        if [ $? -eq 0 ]; then
            echo "[성공] db.properties 파일이 생성되었습니다."
        else
            echo "[오류] db.properties 파일 복사에 실패했습니다."
        fi
    else
        echo "db.properties 파일 생성을 건너뜁니다."
    fi
else
    cp "src/main/resources/db.properties.example" "src/main/resources/db.properties"
    if [ $? -eq 0 ]; then
        echo "[성공] db.properties 파일이 생성되었습니다."
    else
        echo "[오류] db.properties 파일 복사에 실패했습니다."
    fi
fi

echo ""
echo "========================================"
echo "설정 완료"
echo "========================================"
echo "다음 파일들을 열어서 실제 값을 입력하세요:"
echo "- src/main/resources/api.properties"
echo "- src/main/resources/db.properties"
echo ""

