package toour.member.action;

import toour.member.dao.AdminPostDAO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class AdminNoticeViewAction implements Action {
    public boolean checkPost(List<PostVO> list, PostVO vo){
        boolean value = true;
        // list에 vo가 있는지 판단하는 반복문
        for (PostVO pvo:list){
            if(pvo.getPost_idx().equals(vo.getPost_idx())){
                value = false;
                break;
            }
        } // for의 끝

        return value;
    }

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String post_idx = request.getParameter("post_idx");
        HttpSession session = request.getSession();
//        System.out.println("post_idx:"+post_idx);
        Object obj = session.getAttribute("read_list");
        ArrayList<PostVO> list = null;
        if(obj == null){
            list = new ArrayList<>();
            session.setAttribute("read_list", list);
        }else
            list = (ArrayList<PostVO>) obj; // 형변환

        PostVO vo = AdminPostDAO.getPost(post_idx); // 사용자가 선택한 게시물을 검색해 온다.
        System.out.println(vo.getPost_idx());
        // 검색된 vo가 처음으로 읽은 게시물인지 판단
        if(checkPost(list, vo)){
            AdminPostDAO.post_views(post_idx);
            list.add(vo);
        }

        request.setAttribute("vo", vo);

        return "admin/admin_notice_view.jsp";
    }
}
