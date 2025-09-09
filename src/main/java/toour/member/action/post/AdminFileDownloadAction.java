package toour.member.action.post;

import toour.action.Action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

public class AdminFileDownloadAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String f_name = request.getParameter("f_name"); // 요청 파라미터로 파일명 받음

        ServletContext application = request.getServletContext();
        String realPath = application.getRealPath("/bbs_upload/" + f_name);

        File f = new File(realPath);

        if (f.exists()) {
            byte[] buf = new byte[4096];
            int size;

            BufferedInputStream bis = null;
            FileInputStream fis = null;
            BufferedOutputStream bos = null;
            OutputStream sos = null;

            try {
                // 다운로드 응답 헤더
                response.setContentType("application/x-msdownload");
                response.setHeader(
                        "Content-Disposition",
                        "attachment; filename=" + new String(f_name.getBytes("UTF-8"), "ISO-8859-1")
                );
                response.setHeader("Content-Length", String.valueOf(f.length()));

                fis = new FileInputStream(f);
                bis = new BufferedInputStream(fis);

                sos = response.getOutputStream();
                bos = new BufferedOutputStream(sos);

                while ((size = bis.read(buf)) != -1) {
                    bos.write(buf, 0, size);
                }
                bos.flush();

            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (bos != null) bos.close();
                    if (sos != null) sos.close();
                    if (bis != null) bis.close();
                    if (fis != null) fis.close();
                } catch (Exception e2) {
                    e2.printStackTrace();
                }
            }
        } else {
            try {
                response.setContentType("text/html; charset=UTF-8");
                response.getWriter().println("<script>alert('파일이 존재하지 않습니다.');history.back();</script>");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return null; // 파일 직접 전송했으므로 JSP 포워딩 안 함
    }
}
