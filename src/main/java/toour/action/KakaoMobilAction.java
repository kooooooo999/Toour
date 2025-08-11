package toour.action;

import com.mysql.cj.xdevapi.JsonArray;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class KakaoMobilAction implements Action{
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        try {
            request.setCharacterEncoding("utf-8");

        StringBuffer sb = new StringBuffer();
        String APIkey = "41924af6fe5d95bebf4d8ddf6fca8d8c";
        try {
            URL url = new URL("https://apis-navi.kakaomobility.com/v1/waypoints/directions");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // 요청 방식과 헤더 설정
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "KakaoAK "+APIkey);
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);

            // 요청 본문 (JSON) 설정
                sb.append("{");

                sb.append("\"origin\": {");
                sb.append("    \"x\": \"126.9718732\",");
                sb.append("    \"y\": \"37.556074\",");
                sb.append("    \"angle\": 270");
                sb.append("},");

                sb.append("\"destination\": {");
                sb.append("    \"x\": \"126.964775\",");
                sb.append("    \"y\": \"37.52989\"");
                sb.append("},");


                // 경유지 추가할 때마다 waypoints 늘어나게 for문 돌려야 됨
                sb.append("\"waypoints\": [");
                sb.append("    {");
                sb.append("        \"x\": 126.9771397,");
                sb.append("        \"y\": 37.5366059");
                sb.append("    }");


                sb.append("],");
                sb.append("\"priority\": \"DISTANCE\",");
                sb.append("\"car_fuel\": \"GASOLINE\",");
                sb.append("\"car_hipass\": false,");
                sb.append("\"alternatives\": false,");
                sb.append("\"road_details\": false,");
                sb.append("\"summary\": false");
                sb.append("}");
            // 요청 보내기
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = sb.toString().getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // 응답 받기
            int responseCode = conn.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
                StringBuilder response1 = new StringBuilder();
                String responseLine;

                while ((responseLine = br.readLine()) != null) {
                    response1.append(responseLine.trim());
                }

                System.out.println("응답 결과:");
                System.out.println(response1);

                ArrayList<Object> vertex_y = new ArrayList<>();
                ArrayList<Object> vertex_x = new ArrayList<>();

                request.setAttribute("result", response1);
                JSONObject jsonObject = new JSONObject(response1.toString());
                JSONObject route =  jsonObject.getJSONArray("routes").getJSONObject(0);
                JSONArray sections =  route.getJSONArray("sections");
                    //경우지 있을 경우 뭐 더 해야함
                    for (int j = 0; j < sections.length(); j++) {
                        JSONObject section = route.getJSONArray("sections").getJSONObject(j);
                        JSONArray roads = section.getJSONArray("roads");
                        for (int i = 0; i < roads.length(); i++) {
                            JSONObject road = section.getJSONArray("roads").getJSONObject(i);
                            JSONArray vertexes = road.getJSONArray("vertexes");
                            //점 하나하나 나누기 - 사용 불가
                        /* int count = vertexs.length()/2;
                        for(int k =0;k<count;k++){
                            //점 만들기
                            Object[] xy = new Object[2];
                            xy[0]=vertexs.get(k*2);
                            xy[1]=vertexs.get(k*2+1);
                            //점 하나씩 저장
                            vertex_list.add(xy);
                        }*/
                            for (int k = 0; k < vertexes.length(); k++) {
                                Object vertex = road.getJSONArray("vertexes").get(k);
                                if (k % 2 == 0) {
                                    vertex_y.add(vertex);
                                } else
                                    vertex_x.add(vertex);
                            }
                        }
                    }

                request.setAttribute("vertex_x",vertex_x);
                request.setAttribute("vertex_y",vertex_y);
            } else {
                System.out.println("API 호출 실패. HTTP 응답 코드: " + responseCode);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }

        return "kakaojson.jsp";
    }
}
