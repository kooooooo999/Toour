package toour.action;

import mybatis.vo.PostVO;
import toour.dao.PostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class ViewAction implements Action{
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

        Object obj = session.getAttribute("read_list");
        ArrayList<PostVO> list = null;
        if(obj == null){
            list = new ArrayList<>();
            session.setAttribute("read_list", list);
        }else
            list = (ArrayList<PostVO>) obj; // 형변환

        PostVO vo = PostDAO.getPost(post_idx); // 사용자가 선택한 게시물을 검색해 온다.

        // 검색된 vo가 처음으로 읽은 게시물인지 판단
        if(checkPost(list, vo)){
            PostDAO.post_views(post_idx);
            list.add(vo);
        }

        request.setAttribute("vo", vo);

        return "view.jsp";
    }
}
