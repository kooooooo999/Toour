package toour.post.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.MemberVO;
import toour.post.vo.CommentVO;
import toour.post.vo.PostVO;
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
        System.out.println("report_content" + report_content);
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
                                          String comment_idx, String report_content) {

        // 파라미터를 맵에 담아서 전달
        Map<String, String> map = new HashMap<>();
        map.put("reporter_idx", reporter_idx);   // 신고한 사람
        map.put("reported_idx", reported_idx);   // 신고당한 사람
        map.put("post_idx", post_idx);           // 게시글 ID
        map.put("comment_idx", comment_idx);    //신고 대상의 댓글 idx
        map.put("report_content", report_content); // 신고 내용
        System.out.println("report_content" + report_content);
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
    public static ReportVO[] getReport(String report_idx,int begin,int end) {
        ReportVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("begin",begin);
        map.put("end",end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<ReportVO> list = ss.selectList("report.getReportList", map);
        if(list.size()>0&& list!=null){
            ar= new ReportVO[list.size()];
            list.toArray(ar);
        }
        ss.close();

        return ar;
    }

    //신고정보 검색
    public static ReportVO[] search(String searchType, int begin, int end){
        ReportVO[] ar = null;
        Map<String,Object> map = new HashMap<String,Object>();
        if(searchType!=null)
            map.put("searchType", searchType);
        map.put("begin",begin);
        map.put("end",end);


        SqlSession ss = FactoryService.getFactory().openSession();
        List<ReportVO> list = ss.selectList("report.report_search",map);
        if(list!=null&&list.size()>0){
            ar= new ReportVO[list.size()];
            list.toArray(ar);
        } else {
            // 검색 결과가 없을 때 빈 배열을 반환하도록 수정
            ar = new ReportVO[0];
        }
        ss.close();
        return ar;
    }

    // 게시물에서 검색결과 수를 반환
    public static int getSearchTotalCount(String searchType){
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, String> map = new HashMap<>();
        if(searchType!=null)
            map.put("searchType", searchType);

        int cnt = ss.selectOne("report.searchTotalCount",searchType);
        ss.close();
        return cnt;
    }



    //총 신고글 수 가져오기
    public static int TotalCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.TotalCount");
        ss.close();
        return cnt;
    }


    //30일동안의  신고글 수 가져오기
    public static int getReportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.ReportCountAll");
        ss.close();
        return cnt;
    }

    //    신고수 가지고 오기
    public static int reportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.reportCount");
        ss.close();
        return cnt;
    }

    //    게시물 신고수 가지고 오기
    public static int PostreportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.PostreportCount");
        ss.close();
        return cnt;
    }

    //    댓글 신고수 가지고 오기
    public static int CommentreportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.CommentreportCount");
        ss.close();
        return cnt;
    }

    //    미처리된 신고수 가지고 오기
    public static int UnprocessedreportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.UnprocessedreportCount");
        ss.close();
        return cnt;
    }

    //    처리된 신고수 가지고 오기
    public static int processedreportCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("report.processedreportCount");
        ss.close();
        return cnt;
    }
    public static List<Map<String ,Object>> getCommentListWithReports(String post_idx) {
        Map<String,Object> map = new HashMap<>();
        map.put("post_idx", post_idx);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<Map<String ,Object>> list = ss.selectList("report.getCommentListWithReports",map);
        ss.close();
        return list;
    }

    // 신고 상태 바꾸기
    public static int reportstatus(String report_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("adminpost.reportstatus", report_idx);
        if(cnt > 0){
            ss.commit();
        }else{
            ss.rollback();
        }
        ss.close();
        return cnt;

    }

    public static PostVO getpostWithReports(String post_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        PostVO post = ss.selectOne("report.getpostWithReports", post_idx);

        ss.close();
        return post;
    }


}
