package toour.post.action;

import toour.action.Action;
import toour.post.dao.PostDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class DeleteAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

            String post_idx = request.getParameter("post_idx");

            //Db에서 post_status 변경
            int cnt = PostDAO.deleteUpdate(post_idx);
            if(cnt>0){
                System.out.println("delete success: post_status change");
            }else {
                System.out.println("delete failed: not change");
            }

            return  "Controller?type=list";

    }
}
