package toour.post.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.post.vo.ReportVO;

public class ReportDAO {
    // 신고 등록 (DB 저장)
    public static int insertReport(String reporter_idx, String reported_idx, String post_idx,
                                   String report_content) {

        // 파라미터를 맵에 담아서 전달
        Map<String, String> map = new HashMap<>();
        map.put("reporter_idx", reporter_idx);   // 신고한 사람
        map.put("reported_idx", reported_idx);   // 신고당한 사람
        map.put("post_idx", post_idx);           // 신고 대상 게시글 ID
        map.put("report_content", report_content); // 신고 내용
        System.out.println("report_content"+report_content);
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("report.insertWriteReport", map); // report.xml에 있는 insertReport 실행

        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
        return cnt;
    }

    public static int insertCommentReport(String reporter_idx, String reported_idx, String post_idx,
                                   String comment_idx,String report_content) {

        // 파라미터를 맵에 담아서 전달
        Map<String, String> map = new HashMap<>();
        map.put("reporter_idx", reporter_idx);   // 신고한 사람
        map.put("reported_idx", reported_idx);   // 신고당한 사람
        map.put("post_idx", post_idx);           // 게시글 ID
        map.put("comment_idx", comment_idx);    //신고 대상의 댓글 idx
        map.put("report_content", report_content); // 신고 내용
        System.out.println("report_content"+report_content);
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("report.insertCommentReport", map); // report.xml에 있는 insertReport 실행

        if (cnt > 0)
            ss.commit();
        else
            ss.rollback();

        ss.close();
        return cnt;
    }
    //모든 신고목록 가져오기
    public static ReportVO[] getReport() {
        ReportVO[] reportVO = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<ReportVO> list = ss.selectList("report.getReportList");
        if (list != null && list.size() > 0) {
            reportVO = new ReportVO[list.size()];
            list.toArray(reportVO);
        }
        return  reportVO;
    }

    //모든 신고글 수 가져오기
    public static int getReportCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.ReportCountAll");
        ss.close();
        return cnt;
    }



}
