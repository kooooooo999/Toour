package toour.member.action;

import toour.action.Action;
import toour.member.dao.AdminMemberDAO;
import toour.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

public class MemDelAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath = null;
        String cPage = request.getParameter("cPage");

        //모든값 들고 오기 - member_idx로 체크된 회원 가지고 오기 - 배열
       String[] memberIdxArray = request.getParameterValues("member_idx");

        if(memberIdxArray == null || memberIdxArray.length == 0){
            viewPath = "AdminController?type=adminmemlist&cPage="+cPage;
            return viewPath;
        }

        //배열을 리스트로 바꾸기
        List<String> memberIdxlist = Arrays.asList(memberIdxArray);


        int cnt = AdminMemberDAO.delMem(memberIdxlist);
        viewPath = "AdminController?type=adminmemlist&cPage="+cPage;

//        System.out.println("memberIdxlist:::::::::"+memberIdxlist);

        return viewPath;
    }
}
