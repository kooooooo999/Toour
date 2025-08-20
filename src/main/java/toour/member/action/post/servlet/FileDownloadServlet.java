package toour.member.action.post.servlet;

import toour.action.Action;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/download")

public class FileDownloadServlet implements Action {

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileName = request.getParameter("fileName");

        if (fileName == null || fileName.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "File name is required");
            return null;
        }

        // 파일 경로 지정
        String filePath = request.getServletContext().getRealPath("/bbs_upload") + File.separator + fileName;

        // 파일이 존재하는지 확인
        File file = new File(filePath);
        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
            return null;
        }

        // MIME 타입을 동적으로 설정
        String mimeType = request.getServletContext().getMimeType(fileName);
        if (mimeType == null) {
            mimeType = "application/octet-stream";  // 기본 바이너리 타입
        }
        response.setContentType(mimeType);

        // 파일 다운로드 응답 헤더 설정
        response.setContentLengthLong(file.length());
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        // 파일을 클라이언트로 전송
        try (FileInputStream inStream = new FileInputStream(file);
             OutputStream outStream = response.getOutputStream()) {

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }
        }

        return null; // 필요에 따라 적절한 경로 반환
    }
}
