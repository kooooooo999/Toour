package toour.member.action.post;

import toour.action.Action;
import toour.member.dao.AdminPostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import com.google.gson.Gson; // Gson 라이브러리 추가 필요
import toour.post.dao.ReportDAO;

public class GetCommentsByPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String post_idx = request.getParameter("post_idx");
        // String cPage = request.getParameter("cPage"); // 현재는 필요 없지만, 페이징 구현 시 필요

        // AdminPostDAO의 댓글/신고 통합 조회 메서드 호출
        List<Map<String, Object>> commentList = ReportDAO.getCommentListWithReports(post_idx);

        // JSON 형태로 응답을 보냅니다.
        // JSP를 통해 HTML을 보내는 것보다 JSON으로 데이터를 보내는 것이 AJAX 요청에 더 효율적입니다.
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        Gson gson = new Gson();
        String json = gson.toJson(commentList);
        out.print(json);
        out.flush();

        return null; // AJAX 요청이므로 View Path를 반환하지 않습니다.
    }
}