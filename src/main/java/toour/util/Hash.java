package toour.util;

import java.security.MessageDigest;
import java.nio.charset.StandardCharsets;

public class Hash {
    public static String getHash(String pw){
        StringBuffer result = new StringBuffer();
        try {
            // 디버깅: 입력값 확인
            System.out.println("=== Hash.getHash() 디버깅 ===");
            System.out.println("입력값: " + pw);
            System.out.println("입력값 길이: " + pw.length());
            System.out.println("입력값 바이트: " + java.util.Arrays.toString(pw.getBytes(StandardCharsets.UTF_8)));
            
            // 방식 설정
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // 명시적으로 UTF-8 인코딩 사용
            md.update(pw.getBytes(StandardCharsets.UTF_8));

            byte bytes[] = md.digest();
            // 아래 내용은 굳이 알지 않아도 된다고는 함
            for(int i =0; i<bytes.length;i++){
                result.append(
                        Integer.toString((bytes[i]&0xff)+0x100,16).substring(1)
                );
            }
            
            String hashResult = result.toString();
            System.out.println("해시 결과: " + hashResult);
            System.out.println("해시 결과 길이: " + hashResult.length());
            System.out.println("===============================");
            
            return hashResult;
            
            /*byte[] ar = md.digest();
            for(byte b :ar){
                result.append(
                        Integer.toString((b&0xff)+0x100,16).substring(1)
               );
            }*/
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result.toString();
    }
}
