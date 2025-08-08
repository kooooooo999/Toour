package toour.login.action;


import toour.action.Action;
import toour.member.dao.CourseDAO;
import toour.member.vo.CourseVO;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import toour.util.Hash;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class loginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath=null;
        String u_id =request.getParameter("u_id");
        if(request.getSession().getAttribute("user")==null){
            System.out.println("if");
            //로그인이 안 되어 있을 때
            if(u_id!=null){
                //요청으로부터 id를 잘받아옴
                MemberVO mvo = MemberDAO.getMem(u_id);
                if(mvo!=null){
                    //입력한 id가 db에 있을때
                    String u_pw = request.getParameter("u_pw");
                    String salt = mvo.getMember_salt();
                    String hash_pw =Hash.getHash(salt+u_pw);
                    if(mvo.getMember_password().equals(hash_pw)){
                        //입력한 비밀번호와 db에 저장된 비밀번호가 같을 때
//                        viewPath = "MainIndex/index.jsp"; -- cornsoup 수정
                        
                        // 로그인이 승인 됐을 때 회원의 코스를 가져와 mvo에 저장
                        CourseVO[] cvo_ar = CourseDAO.getCourseVO(mvo.getMember_idx());
                        mvo.setCourselist(cvo_ar);
                        request.getSession().setAttribute("user",mvo);


                        //cornsoup 수정
                        if(mvo.getMember_type().equals("0")){
                            viewPath = "admin/admin_main.jsp";
                        }
                        else
                            viewPath = "MainIndex/index.jsp";
                    }else
                        //입력한 비밀번호와 db에 저장된 비밀번호가 다를 때
                        viewPath ="member/login.jsp";
                }else
                    //입력한 id가 db에 없을 때
                    viewPath ="member/login.jsp";
            }else {
                viewPath="MainIndex/index.jsp";
            }
        }else {
            //로그아웃 눌렀을 때
            System.out.println("else");
            request.getSession().removeAttribute("user");
        }

        //cornsoup 수정
        request.setAttribute("u_id", u_id);

        return viewPath;
    }
}
