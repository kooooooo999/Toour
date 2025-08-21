package toour.action;

import toour.notice.vo.PostVO;
import toour.notice.dao.NoticeDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class IndexAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        // 최신 공지 4개 가져오기
        List<PostVO> list = NoticeDAO.selectLatestNotice(4);
        request.setAttribute("noticeMainAr", list);
        return "/MainIndex/index.jsp";
    }
}
