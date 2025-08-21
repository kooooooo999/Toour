package toour.post.action;

import toour.action.Action;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class RecommendCancelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String member_idx = request.getParameter("member_idx");
        String post_idx = request.getParameter("post_idx");

        Map<String,String> map = new HashMap<>();
        map.put("member_idx",member_idx);
        map.put("post_idx",post_idx);



        return "";
    }
}
