package toour.member.action;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import toour.action.Action;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;

public class AdminNoticeSaveImgAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        ServletContext application = request.getServletContext();
        String realPath = application.getRealPath("/editor_img");

        try{
            MultipartRequest mr = new MultipartRequest(request, realPath, 1024*1024*5, "utf-8", new DefaultFileRenamePolicy());
            File f = mr.getFile("upload");
            String f_name = null;
            if(f != null){
                f_name = f.getName();
                request.setAttribute("f_name", f_name);//저장된 파일명
            }
            request.setAttribute("contextPath", request.getContextPath());

        } catch (Exception e) {
            e.printStackTrace();
        }
        return "admin/admin_notice_saveImg.jsp";

    }
}
