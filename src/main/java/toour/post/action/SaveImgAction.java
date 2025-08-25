package toour.post.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.json.simple.JSONObject;
import toour.action.Action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.PrintWriter;

public class SaveImgAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        response.setContentType("application/json;charset=utf-8");

        ServletContext application = request.getServletContext();

        try {
            String realPath = application.getRealPath("/editor_img");
            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // MultipartRequest를 사용하여 파일 업로드
            // 이때 파일은 이미 지정된 폴더에 저장됩니다.
            MultipartRequest mr = new MultipartRequest(
                    request,
                    realPath,
                    1024 * 1024 * 10, // 10MB
                    "utf-8",
                    new DefaultFileRenamePolicy()
            );

            // 저장된 파일명을 얻어냅니다.
            File f = mr.getFile("upload");
            if (f != null) {
                String fileName = f.getName();

                // Summernote가 요구하는 이미지 URL을 만듭니다.
                String fileUrl = request.getContextPath() + "/editor_img/" + fileName;

                // JSON 객체 생성
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("img_url", fileUrl);

                // JSON 응답을 클라이언트로 보냅니다.
                PrintWriter out = response.getWriter();
                out.print(jsonObject.toJSONString());
                out.flush();
                out.close();
            }

        } catch (Exception e) {
            e.printStackTrace();
            // 오류 발생 시 JSON 형식으로 에러 메시지 반환
            try {
                PrintWriter out = response.getWriter();
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("error", "Image upload failed: " + e.getMessage());
                out.print(jsonObject.toJSONString());
                out.flush();
                out.close();
            } catch(Exception ex) {
                ex.printStackTrace();
            }
        }

        // JSP로 포워딩하지 않고, null을 반환하여 요청을 종료합니다.
        return null;
    }
}
