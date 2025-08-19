package toour.member.action;

import toour.action.Action;
import toour.member.dao.CourseDAO;
import toour.member.dao.ZzimDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.CourseVO;
import toour.member.vo.ZzimVO;
import toour.post.dao.PostDAO;
import toour.post.vo.PostVO;
import toour.tripsuggestion.vo.DataVO;
import toour.util.GetAPIData;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class myPageAction implements Action {
    static int BEGIN=1;
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        int cnt = 4;


        DataVO[] tour_ar = new DataVO[cnt];
        CourseVO[] course_ar = new CourseVO[cnt];

        Object obj = request.getSession().getAttribute("member");
        if(obj !=null){
            MemberVO mvo = (MemberVO) obj;

            int tour_cnt =0;
            int course_cnt =0;
            ZzimVO[] zzim_ar= ZzimDAO.getZzimAr(mvo.getMember_idx());
            if(zzim_ar!=null) {
                for (ZzimVO zvo : zzim_ar) {
                    String zzimType = zvo.getZzim_type();
                    // 관광지를 담는 배열에 최대 4개만 담는 문장
                    if (zzimType.equals("tour")) {
                        if (tour_cnt < cnt) {
                            tour_ar[tour_cnt] = GetAPIData.getDataVO(zvo.getZzim_content_id());
                            tour_cnt++;
                            System.out.println("tour_cnt:" + tour_cnt);
                        }
                    }

                    // 둘 다 4가 되었다면 그것은 두 배열이 완성되었으므로 for문 종료
                    if (tour_cnt >= cnt && course_cnt >= cnt) {
                        break;
                    }

                }//for문 끝
            }

            List<CourseVO> cvo_list = CourseDAO.getCourseVOList(mvo.getMember_idx());
            if(cvo_list!=null) {
                //회원의 코스를 4개만 가져옴
                for (int i = 0; i < cnt; i++) {
                    if (i < cvo_list.size()) {
                        course_ar[i] = cvo_list.get(i);
                    } else
                        break;
                }
            }

            //내 게시글 설정
            // 처음 마이 페이지로 가므로 1~6으로
            Paging page = new Paging(5, 5);
            PostVO[] myPost = PostDAO.getMyList(mvo.getMember_idx(),1,5);
            page.setTotalCount(PostDAO.getMyTotalCount(mvo.getMember_idx()));
            page.setNowPage(1);

            //request에 page 값 저장
            request.setAttribute("page",page);
            request.setAttribute("myPost_ar",myPost);

            //request에 배열 2개 저장해서 마이페이지로 이동
            request.setAttribute("zzim_ar",zzim_ar);
            request.setAttribute("tour_ar", tour_ar);
            request.setAttribute("course_ar", course_ar);

        }
        return "member/myPage.jsp";
    }
}
