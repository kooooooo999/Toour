package toour.course.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.CourseInVO;
import toour.member.vo.CourseVO;
import toour.member.vo.MemberVO;
import toour.tripsuggestion.vo.DataVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AddCourseDAO {

    public static CourseVO[] searchCourse(String member_idx) {
        CourseVO[] course_ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseVO> list = ss.selectList("course.get", member_idx);
        if (list != null) {
            course_ar = new CourseVO[list.size()];
            list.toArray(course_ar);
        }
        ss.close();
        return course_ar;
    }

    public static int courseAdd(String member_idx, String course_name, String course_summary) {
        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        Map<String, String> map = new HashMap<>();
        map.put("member_idx", member_idx);
        map.put("course_name", course_name);
        map.put("course_summary", course_summary);

        cnt = ss.insert("course.addCourse", map);

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }

    public static String courseDateAdd(String date, String course_idx, String date_title, List<DataVO> list) {
        int dateCnt = 0;
        int inCnt = 0;
        int inCnts = 0;
        String result = null;
        SqlSession ss = FactoryService.getFactory().openSession();

        Map<String, String> map = new HashMap<>();
        map.put("date", date);
        map.put("course_idx", course_idx);
        map.put("date_title", date_title);
        dateCnt = ss.insert("course.courseDateAdd", map);

        String courseDate_idx = String.valueOf(map.get("courseDate_idx"));
        if (dateCnt > 0) {
            for (DataVO dvo : list) {
                CourseInVO cvo = new CourseInVO();
                cvo.setCourseDate_idx(courseDate_idx);
                cvo.setContentId(dvo.getContentId());
                cvo.setContentTypeId(dvo.getContentTypeId());
                cvo.setTitle(dvo.getTitle());
                cvo.setAddr1(dvo.getAddr1());
                cvo.setMapx(dvo.getMapx());
                cvo.setMapy(dvo.getMapy());
                inCnt = ss.insert("course.courseInAdd",cvo);
                if (inCnt > 0) {
                    inCnts++;
                }
            }
        }

        if (inCnts == list.size()) {
            ss.commit();
            result = "성공";
        } else {
            ss.rollback();
            result = "실패";
        }

        ss.close();
        return result;
    }

    public static CourseInVO[] myDayList(String courseDate_idx) {
        CourseInVO[] courseIn_ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<CourseInVO> list = ss.selectList("course.getCourseIn", courseDate_idx);

        if (list != null) {
            courseIn_ar = new CourseInVO[list.size()];
            list.toArray(courseIn_ar);
        }

        ss.close();
        return courseIn_ar;
    }

    public static int deleteCourse(String courseDate_idx) {
        int cnt = 0;

        SqlSession ss = FactoryService.getFactory().openSession();

        try{
            cnt = ss.delete("course.deleteCourse", courseDate_idx);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }

    public static int addCourseIn(String courseDate_idx, List<DataVO> list) {


        int cnt = 0;
        SqlSession ss = FactoryService.getFactory().openSession();

        for (DataVO dvo : list) {
            CourseInVO cvo = new CourseInVO();
            cvo.setCourseDate_idx(courseDate_idx);
            cvo.setContentId(dvo.getContentId());
            cvo.setContentTypeId(dvo.getContentTypeId());
            cvo.setTitle(dvo.getTitle());
            cvo.setAddr1(dvo.getAddr1());
            cvo.setMapx(dvo.getMapx());
            cvo.setMapy(dvo.getMapy());
            int cnt2 = ss.insert("course.courseInAdd",cvo);
            if (cnt2 > 0) {
                cnt++;
            }
        }

        if (cnt == list.size()) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }

    public static int totalDeleteCourse(String course_idx) {
        int cnt = 0;

        SqlSession ss = FactoryService.getFactory().openSession();

        try{
            cnt = ss.delete("course.totalDeleteCourse", course_idx);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }

    public static int deleteCourseDate(String courseDate_idx) {
        int cnt = 0;

        SqlSession ss = FactoryService.getFactory().openSession();

        try{
            cnt = ss.delete("course.deleteCourseDate", courseDate_idx);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }

        ss.close();
        return cnt;
    }
}
