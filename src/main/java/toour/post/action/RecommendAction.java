package toour.post.action;

import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.post.dao.RecommendDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

public class RecommendAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String member_idx = request.getParameter("member_idx");
        String post_idx = request.getParameter("post_idx");

        Map<String,String> map = new HashMap<>();
        map.put("member_idx",member_idx);
        map.put("post_idx",post_idx);

        boolean already = RecommendDAO.hasUserRecommended(map);
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (already) {
            out.print("{\"success\": false, \"message\": \"이미 추천했습니다.\"}");
            return null;
        }

        int insert = RecommendDAO.insertRecommend(map);
        int update = PostDAO.postLikesUpdate(post_idx);

        if (insert > 0 && update > 0) {
            out.print("{\"success\": true}");
        } else {
            out.print("{\"success\": false}");
        }
        out.flush();
        out.close();

        return null; // Ajax 응답이므로 JSP 이동 없음
    }

}
