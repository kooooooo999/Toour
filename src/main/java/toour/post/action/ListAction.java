package toour.post.action;

import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ListAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String cPageParam = request.getParameter("cPage");
        int cPage = 1;
        try {
            cPage = Integer.parseInt(cPageParam);
            if (cPage < 1) cPage = 1; // 음수나 0 방지
        } catch (NumberFormatException e) {
            cPage = 1;
        }

        Paging paging = new Paging(10, 5);
        String category_idx = request.getParameter("category_idx");
        if (category_idx == null) category_idx = "2";

        int totalCount = PostDAO.getTotalCount(category_idx);
        paging.setTotalCount(totalCount);

        paging.setNowPage(cPage);

        int begin = paging.getBegin();
        int numPerPage = paging.getNumPerPage(); // getEnd() 대신 개수로 사용
        if (begin < 1) begin = 1;


        String sort = request.getParameter("sort"); // "latest", "likes", "popular"
        List<PostVO> posts = null;

        switch (sort != null ? sort : "latest") {
            case "likes":
                // Paging 객체를 likes 정렬에 맞게 설정하고 게시물을 가져옵니다.
                // PostDAO.getPostsByLikes() 메서드가 begin과 end를 사용하도록 수정 필요
                posts = PostDAO.getPostsByLikes(paging.getBegin(), paging.getEnd());
                break;
            case "popular":
                // Paging 객체를 popular 정렬에 맞게 설정하고 게시물을 가져옵니다.
                // PostDAO.getPostsByPopularity() 메서드가 begin과 end를 사용하도록 수정 필요
                posts = PostDAO.getPostsByPopularity(paging.getBegin(), paging.getEnd());
                break;
            case "latest":
                PostVO[] arr = PostDAO.getList(category_idx, paging.getBegin(), paging.getEnd());
                posts = arr != null ? Arrays.asList(arr) : new ArrayList<>();
                break;
        }
        request.setAttribute("ar", posts);
        request.setAttribute("page", paging);
        request.setAttribute("sort", sort != null ? sort : "latest");
        request.setAttribute("nowPage", paging.getNowPage());
        request.setAttribute("totalCount", totalCount);

        return "post/list.jsp";
    }
}
