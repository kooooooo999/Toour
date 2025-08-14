package toour.notice.action;

import toour.member.vo.MemberVO;
import toour.post.vo.CommentVO;
import toour.post.vo.FileVO;
import toour.post.dao.FileDAO;
import toour.post.vo.PostVO;
import toour.action.Action;
import toour.post.dao.PostDAO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

public class NoticeViewAction implements Action {
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
        System.out.println("viewAction post_idx = " + post_idx);
        if(post_idx==null||post_idx.isEmpty()){
            return "Controller?type=notice";
        }
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("read_list");

        ArrayList<String> readList = null;
        if(obj == null){
            readList = new ArrayList<>();
            session.setAttribute("read_list", readList);
        }else
            readList = (ArrayList<String>) obj;

        //DB에서 게시물 정보를 한번만 조회한다
        PostVO vo = PostDAO.getPost(post_idx);
        MemberVO member_info = PostDAO.getPostMemberIdx(post_idx);
        request.setAttribute("member_info",member_info);

//        System.out.println("member_info.nickname:"+member_info.getMember_nickname());
        if (vo != null) {
            // 1. post_idx와 연관된 파일 가져오기
            List<FileVO> fileList = FileDAO.getFilesByPost(post_idx);

            // 2. 존재한다면 request에 파일정보를 더한다
            if (fileList != null) {
                request.setAttribute("fileList", fileList);
            }
        }else {
            return "error.jsp";//오류페이지로 보내기 여기는 고쳐야할 부분~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        }

//        System.out.println(vo.getPost_idx());
        // 검색된 vo가 처음으로 읽은 게시물인지 판단
        if(!readList.contains(post_idx)){
            PostDAO.post_views(post_idx);
            readList.add(post_idx);
        }
        CommentVO[] comment_list =PostDAO.getCommentList(post_idx);
        request.setAttribute("comment_list", comment_list);
        request.setAttribute("vo", vo);

        return "notice/noticeview.jsp";
    }
}
