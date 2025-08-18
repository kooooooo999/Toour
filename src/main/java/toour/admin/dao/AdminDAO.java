package toour.admin.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.post.vo.InquiryVO;

import java.util.List;

public class AdminDAO {
    public static int getMyTotalCount(){
        SqlSession ss = FactoryService.getFactory().openSession();
        int cnt = ss.selectOne("inquiry.myTotalCount");
        ss.close();
        return cnt;
    }

    //문의사항 목록 보여주기
    public static InquiryVO[] QnAList(){
        InquiryVO[] ar = null;

        SqlSession ss = FactoryService.getFactory().openSession();
        List<InquiryVO> list = ss.selectList("inquiry.all");
        if(list.size()>0&&list!=null){
            ar = new InquiryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;

    }
    //한달내의 문의사항 보기
    public static InquiryVO[] OneMonthQnAList(){
        InquiryVO[] ar = null;
        SqlSession ss = FactoryService.getFactory().openSession();
        List<InquiryVO> list = ss.selectList("inquiry.oneMonthInquiry");
        if(list.size()>0&&list!=null){
            ar = new InquiryVO[list.size()];
            list.toArray(ar);
        }
        ss.close();
        return ar;

    }

    //문의사항 답변상태 업데이트


    //문의사항 안읽음>읽음처리


}
