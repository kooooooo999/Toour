package toour.util;

import java.security.MessageDigest;

public class Hash {
    public static String getHash(String pw){
        StringBuffer result = new StringBuffer();
        try {
            // 방식 설정
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            md.update(pw.getBytes());

            byte bytes[] = md.digest();
            // 아래 내용은 굳이 알지 않아도 된다고는 함
            for(int i =0; i<bytes.length;i++){
                result.append(
                        Integer.toString((bytes[i]&0xff)+0x100,16).substring(1)
                );
            }
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
