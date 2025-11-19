package toour.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ApiKeyUtil {
    private static Properties properties;
    private static final String PROPERTIES_FILE = "api.properties";

    static {
        properties = new Properties();
        try {
            InputStream inputStream = ApiKeyUtil.class.getClassLoader().getResourceAsStream(PROPERTIES_FILE);
            if (inputStream != null) {
                properties.load(inputStream);
                inputStream.close();
            } else {
                System.err.println("api.properties 파일을 찾을 수 없습니다.");
            }
        } catch (IOException e) {
            System.err.println("api.properties 파일을 로드하는 중 오류가 발생했습니다: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * S 서비스키 반환
     */
    public static String getSeKey() {
        return properties.getProperty("api.service.key.se", "");
    }

    /**
     * B 서비스키 반환
     */
    public static String getBoKey() {
        return properties.getProperty("api.service.key.bo", "");
    }

    /**
     * W 서비스키 반환
     */
    public static String getWaKey() {
        return properties.getProperty("api.service.key.wa", "");
    }

    /**
     * Ju 서비스키 반환
     */
    public static String getJuKey() {
        return properties.getProperty("api.service.key.ju", "");
    }

    /**
     * 기본 서비스키 반환
     */
    public static String getDefaultKey() {
        return properties.getProperty("api.service.key.default", "");
    }

    /**
     * 서비스키를 serviceKey= 형태로 반환
     */
    public static String getServiceKeyParam(String key) {
        return "serviceKey=" + key;
    }

    /**
     * 카카오 맵 API 키 반환
     */
    public static String getKakaoMapAppkey() {
        return properties.getProperty("api.kakao.map.appkey", "");
    }

    /**
     * 카카오 JavaScript 키 반환
     */
    public static String getKakaoJsKey() {
        return properties.getProperty("api.kakao.js.key", "");
    }

    /**
     * 카카오 REST API 키 반환
     */
    public static String getKakaoRestKey() {
        return properties.getProperty("api.kakao.rest.key", "");
    }

    /**
     * 카카오 모바일 API 키 반환
     */
    public static String getKakaoMobileKey() {
        return properties.getProperty("api.kakao.mobile.key", "");
    }

    /**
     * 네이버 Client ID 반환
     */
    public static String getNaverClientId() {
        return properties.getProperty("api.naver.client.id", "");
    }

    /**
     * 네이버 Client Secret 반환
     */
    public static String getNaverClientSecret() {
        return properties.getProperty("api.naver.client.secret", "");
    }
}

