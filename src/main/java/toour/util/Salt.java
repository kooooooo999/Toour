package toour.util;

import java.security.SecureRandom;
import java.util.Base64;

public class Salt {
    public static String getSalt(){
        SecureRandom sr = null;
        try {
            sr = SecureRandom.getInstanceStrong();// 가장 강력한 알고리즘을 가져옴
        } catch (Exception e) {
            e.printStackTrace();
            sr = new SecureRandom();// 알고리즘을 가져오는데에 실패했을 경우 새로 가져옴
        }
        int saltLength = 16; //16바이트로 salt크기 설정
        byte[] salt = new byte[saltLength];
        sr.nextBytes(salt); // salt 배열에 암호학적으로 안전한 난수를 채워 넣음

        // Base64 형식으로 인코딩하여 문자열 형태로 변환 (기존 호환성 유지)
        String encodedSalt = Base64.getEncoder().encodeToString(salt);
        
        return encodedSalt;
    } 
}
