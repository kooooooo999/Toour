package toour.post.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.post.vo.InquiryVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class InquiryDAO {
    
    // 문의 등록
    public static int insertInquiry(String member_idx, String category, String title, 
                                   String content, String file_path, String status) {
        Map<String, Object> map = new HashMap<>();
        map.put("member_idx", member_idx);
        map.put("category", category);
        map.put("title", title);
        map.put("content", content);
        map.put("file_path", file_path);
        map.put("status", "대기");

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.insert("Inquiry.insertInquiry", map);
        
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        
        return cnt;
    }

    public static InquiryVO[] getByMember_idx(String member_idx) {
        InquiryVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<InquiryVO> list =ss.selectList("Inquiry.selectByMember", member_idx);
        if (list != null && list.size() > 0) {
            ar = new InquiryVO[list.size()];
            ar = list.toArray(ar);

        }
        return  ar;
    }

    // 문의 목록 조회 (페이징)
    public static InquiryVO[] getInquiryList(String member_idx, String category,
                                           String searchType, String searchValue,
                                           int begin, int end) {
        InquiryVO[] ar=null;
        Map<String, Object> map = new HashMap<>();
        if (member_idx != null && !member_idx.isEmpty()) {
            map.put("member_idx", member_idx);
        }
        if (category != null && !category.isEmpty()) {
            map.put("category", category);
        }
        if (searchType != null && searchValue != null) {
            map.put("searchType", searchType);
            map.put("searchValue", searchValue);
        }
        map.put("begin", begin);
        map.put("end", end);

        SqlSession ss = FactoryService.getFactory().openSession();
        List<InquiryVO> list = ss.selectList("Inquiry.getInquiryList", map);
        if(list.size()>0&&list!=null){
            ar=new InquiryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        
        return ar;
    }

    // 문의 상세 조회 (본인 확인 포함)
    public static Map<String, Object> getInquiryDetail(String inquiry_idx, String member_idx) {
        Map<String, Object> map = new HashMap<>();
        map.put("inquiry_idx", inquiry_idx);
        map.put("member_idx", member_idx);
        
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, Object> inquiry = ss.selectOne("Inquiry.getInquiryDetailByMember", map);
        ss.close();
        return inquiry;
    }
    
    // 문의 상세 조회 (관리자용 - 모든 문의 조회 가능)
    public static Map<String, Object> getInquiryDetail(String inquiry_idx) {
        SqlSession ss = FactoryService.getFactory().openSession();
        Map<String, Object> inquiry = ss.selectOne("Inquiry.getInquiryDetail", inquiry_idx);
        ss.close();
        return inquiry;
    }

    // 문의 수정
    public static int updateInquiry(String inquiry_idx, String member_idx, String category, 
                                   String title, String content, String file_path) {
        Map<String, Object> map = new HashMap<>();
        map.put("inquiry_idx", inquiry_idx);
        map.put("member_idx", member_idx);
        map.put("category", category);
        map.put("title", title);
        map.put("content", content);
        map.put("file_path", file_path);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("Inquiry.updateInquiry", map);
        
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        
        return cnt;
    }

    // 문의 상태 변경 (관리자용)
    public static int updateInquiryStatus(String inquiry_idx, String status) {
        Map<String, Object> map = new HashMap<>();
        map.put("inquiry_idx", inquiry_idx);
        map.put("status", status);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("Inquiry.updateInquiryStatus", map);
        
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        
        return cnt;
    }

    // 문의 삭제 (논리적 삭제)
    public static int deleteInquiry(String inquiry_idx, String member_idx) {
        Map<String, Object> map = new HashMap<>();
        map.put("inquiry_idx", inquiry_idx);
        map.put("member_idx", member_idx);

        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.update("Inquiry.deleteInquiry", map);
        
        if (cnt > 0) {
            ss.commit();
        } else {
            ss.rollback();
        }
        ss.close();
        
        return cnt;
    }

    // 전체 문의 수 조회
    public static int getTotalCount(String member_idx, String category, 
                                   String searchType, String searchValue) {
        Map<String, Object> map = new HashMap<>();
        if (member_idx != null && !member_idx.isEmpty()) {
            map.put("member_idx", member_idx);
        }
        if (category != null && !category.isEmpty()) {
            map.put("category", category);
        }
        if (searchType != null && searchValue != null) {
            map.put("searchType", searchType);
            map.put("searchValue", searchValue);
        }

        SqlSession ss = FactoryService.getFactory().openSession();
        int count = ss.selectOne("Inquiry.getTotalCount", map);
        ss.close();
        
        return count;
    }

    // 문의 유형별 통계
    public static List<Map<String, Object>> getInquiryStats() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<Map<String, Object>> stats = ss.selectList("Inquiry.getInquiryStats");
        ss.close();
        return stats;
    }

    // 상태별 문의 수
    public static List<Map<String, Object>> getStatusCount() {
        SqlSession ss = FactoryService.getFactory().openSession();
        List<Map<String, Object>> statusCount = ss.selectList("Inquiry.getStatusCount");
        ss.close();
        return statusCount;
    }

    public static int getSearchTotalCount(String searchType,String searchValue){
        SqlSession ss = FactoryService.getFactory().openSession();

        Map<String, Object> map = new HashMap<>();
        if (searchType != null && !searchType.isEmpty()) {
            map.put("searchType", searchType);
        }
        if (searchValue != null && !searchValue.isEmpty()) {
            map.put("searchValue", searchValue);
        }

      int cnt  = ss.selectOne("Inquiry.searchTotalCount", map);
        ss.close();
        return cnt;

    }

    public static InquiryVO[] getMyInquiryList(String member_idx){
        InquiryVO[] ar=null;
        Map<String, String> map = new HashMap<>();
        map.put("member_idx", member_idx);
        SqlSession ss = FactoryService.getFactory().openSession();
        List<InquiryVO> list = ss.selectList("Inquiry.getMyInquiryList", map);
        if(list!=null&&list.size()>0){
            ar=list.toArray(new InquiryVO[list.size()]);

        }
        ss.close();
        return ar;
    }
    public static int getMyInquiryListCount(String member_idx){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt =ss.selectOne("Inquiry.getMyInquiryListCount", member_idx);

        ss.close();
        return cnt;
    }

}
