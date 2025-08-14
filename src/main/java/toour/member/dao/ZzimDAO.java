package toour.member.dao;

import mybatis.service.FactoryService;
import org.apache.ibatis.session.SqlSession;
import toour.member.vo.ZzimVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ZzimDAO {
    public static int addZzim(String member_idx, String zzim_type,String contentId){
        int cnt =0;
        if(contentId!=null){
            SqlSession ss = FactoryService.getFactory().openSession();
            Map<String, String> map = new HashMap<>();
            map.put("member_idx", member_idx);
            map.put("zzim_type",zzim_type);
            map.put("zzim_content_id", contentId);
            cnt = ss.insert("zzim.add",map);
            if(cnt>0)
                ss.commit();
            else
                ss.rollback();
            ss.close();
        }

        return cnt;
    }
    public static ZzimVO[] getZzimAr(String member_idx){
        SqlSession ss= FactoryService.getFactory().openSession();
        List<ZzimVO> zzim_list = ss.selectList("zzim.get",member_idx);
        ZzimVO[] zzim_ar = null;
        if(zzim_list!=null && !zzim_list.isEmpty()){
            zzim_ar = new ZzimVO[zzim_list.size()];
            zzim_list.toArray(zzim_ar);
        }
        return zzim_ar;
    }
}
