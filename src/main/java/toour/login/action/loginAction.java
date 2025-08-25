package toour.login.action;


import toour.action.Action;
import toour.member.dao.CourseDAO;
import toour.member.vo.CourseVO;
import toour.member.vo.MemberVO;
import toour.login.dao.MemberDAO;
import toour.util.Hash;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

public class loginAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String viewPath=null;
        String u_id =request.getParameter("u_id");
        if(request.getSession().getAttribute("member")==null){

            //로그인이 안 되어 있을 때
            if(u_id!=null){
                //로그인 성공
                //요청으로부터 id를 잘받아옴
                System.out.println("u_id:"+u_id);
                MemberVO mvo = MemberDAO.getMem(u_id);
                if(mvo!=null){
                    //입력한 id가 db에 있을때
                    String u_pw = request.getParameter("u_pw");
                    String salt = mvo.getMember_salt();

                    // 디버깅: 해시 과정 상세 로깅
                    System.out.println("=== 로그인 해시 디버깅 ===");
                    System.out.println("입력 비밀번호: " + u_pw);
                    System.out.println("DB 저장된 salt: " + salt);
                    System.out.println("salt 길이: " + (salt != null ? salt.length() : "null"));

                    System.out.println("salt + 비밀번호: " + salt + u_pw);
                    System.out.println("salt + 비밀번호 길이: " + (salt + u_pw).length());

                    String hash_pw = Hash.getHash(salt + u_pw);
                    System.out.println("새로 생성된 해시: " + hash_pw);
                    System.out.println("DB 저장된 해시: " + mvo.getMember_password());
                    System.out.println("해시 일치 여부: " + mvo.getMember_password().equals(hash_pw));
                    System.out.println("===============================");
                    if(mvo.getMember_password().equals(hash_pw)){
                        //입력한 비밀번호와 db에 저장된 비밀번호가 같을 때
//                        viewPath = "MainIndex/index.jsp"; -- cornsoup 수정
                        if(mvo.getMember_status().equals("0")) {
                            //회원이 활성화일 때
                            request.getSession().setAttribute("member", mvo);

                            HttpSession session = request.getSession();
                            System.out.println(mvo.getMember_idx());
                            session.setAttribute("member",mvo);
                            session.setAttribute("userIdx", mvo.getMember_idx());
                            session.setAttribute("userId", mvo.getMember_id());
                            session.setAttribute("userNickName", mvo.getMember_nickname());
                            System.out.println("loginAction mvo.nickname="+mvo.getMember_nickname());
                            session.setMaxInactiveInterval(30*60);
                            System.out.println("userNickName:"+session.getAttribute("userNickName"));

                            // 디버깅: 임시 비밀번호 상태 확인
                            System.out.println("=== 로그인 디버깅 정보 ===");
                            System.out.println("member_id: " + mvo.getMember_id());
                            System.out.println("is_temp_password: " + mvo.getIs_temp_password());
                            System.out.println("member_type: " + mvo.getMember_type());
                            System.out.println("==========================");

                            try {
                                int cnt = MemberDAO.updateLastLogin(mvo.getMember_idx());
                                if (cnt > 0) {
                                    mvo.setMember_last_login_at(String.valueOf(new Timestamp(System.currentTimeMillis())));
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                throw new RuntimeException(e);
                            }
                            //cornsoup 수정
                            if(mvo.getMember_type().equals("0")){
                                viewPath = "AdminController?type=AdminMainGo";
                            }
                            else {
                                // 임시 비밀번호로 로그인한 경우 비밀번호 변경 페이지로 이동
                                String isTempPassword = mvo.getIs_temp_password();
                                if (isTempPassword == null) {
                                    // is_temp_password가 null인 경우 0으로 설정 (기존 회원)
                                    isTempPassword = "0";
                                    mvo.setIs_temp_password("0");
                                }

                                if ("1".equals(isTempPassword)) {
                                    System.out.println("임시 비밀번호 사용자 - 비밀번호 변경 페이지로 이동");
                                    viewPath = "member/changePassword.jsp";
                                } else {
                                    System.out.println("일반 사용자 - 메인 페이지로 이동");
                                    viewPath = "gohome";
                                }
                            }
                        }else if(mvo.getMember_status().equals("2")){
                            //회원이 비활성화 일때
                            request.setAttribute("alertLoginText","탈퇴한 회원정보입니다.");
                            viewPath = "member/login.jsp";
                        }else {
                            //회원이 대기일 때
                            request.setAttribute("alertLoginText","휴면 회원정보입니다.");
                            viewPath = "member/login.jsp";

                        }

                    }else {
                        //입력한 비밀번호와 db에 저장된 비밀번호가 다를 때
                        request.setAttribute("alertLoginText","아이디 혹은 비밀번호가 맞지 않습니다.");
                        viewPath = "member/login.jsp";
                    }
                }else{
                    //입력한 id가 db에 없을 때
                    request.setAttribute("alertLoginText", "아이디 혹은 비밀번호가 맞지 않습니다.");
                    viewPath ="member/login.jsp";
                }
            }else {
                viewPath="member/login.jsp";
            }
        }else {
            //로그아웃 눌렀을 때
            System.out.println("logout");
            request.getSession().removeAttribute("member");
            request.getSession().invalidate();
            viewPath="MainIndex/index.jsp";
        }

        //cornsoup 수정
        request.setAttribute("u_id", u_id);

        return viewPath;
    }
}
