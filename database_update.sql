-- Toour 데이터베이스 업데이트 스크립트
-- member 테이블에 is_temp_password 컬럼 추가

-- MySQL/MariaDB
ALTER TABLE member ADD COLUMN is_temp_password TINYINT(1) DEFAULT 0 COMMENT '임시 비밀번호 여부 (0: 일반, 1: 임시)';

-- 또는 PostgreSQL의 경우
-- ALTER TABLE member ADD COLUMN is_temp_password BOOLEAN DEFAULT FALSE;

-- 기존 데이터는 일반 비밀번호로 설정
UPDATE member SET is_temp_password = 0 WHERE is_temp_password IS NULL;

-- 인덱스 추가 (선택사항)
-- CREATE INDEX idx_member_temp_password ON member(is_temp_password);
