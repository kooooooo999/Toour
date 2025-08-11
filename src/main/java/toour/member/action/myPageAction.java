package toour.member.action;

import toour.action.Action;
import toour.member.dao.CourseDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.CourseVO;
import toour.member.vo.ZzimVO;
import toour.tripsuggestion.vo.DataVO;
import toour.util.GetAPIData;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class myPageAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        int cnt = 4;

        DataVO[] tour_ar = new DataVO[cnt];
        CourseVO[] course_ar = new CourseVO[cnt];

        Object obj = request.getSession().getAttribute("user");
        if(obj !=null){
            MemberVO mvo = (MemberVO) obj;

            int tour_cnt =0;
            int course_cnt =0;

            for(ZzimVO zvo :mvo.getZzimlist()) {
                String zzimType = zvo.getZzim_type();
                // 관광지를 담는 배열에 최대 4개만 담는 문장
                if (zzimType.equals("tour")) {
                    if (tour_cnt < cnt) {
                        tour_ar[tour_cnt] = GetAPIData.getDataVO(zvo.getZzim_content_id());
                        tour_cnt++;
                    }
                }

                
                // 코스를 담는 배열에 최대 4개만 담는 문장


                // 둘 다 4가 되었다면 그것은 두 배열이 완성되었으므로 for문 종료
                if(tour_cnt >= cnt && course_cnt >= cnt){
                    break;
                }

            }//for문 끝
            
            //회원의 코스를 4개만 가져옴
            for (int i = 0;i<cnt;i++){
                if(i<mvo.getCourselist().length) {
                    course_ar[i] = mvo.getCourselist()[i];
                }else
                    break;
            }
            
            //request에 배열 2개 저장해서 마이페이지로 이동
            request.setAttribute("tour_ar", tour_ar);
            request.setAttribute("course_ar", course_ar);
        }
        return "member/myPage.jsp";
    }
}
