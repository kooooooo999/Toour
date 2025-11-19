package toour.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.member.vo.MemberVO;
import toour.search.util.GetAPISearchData;
import toour.search.vo.SearchDataVO;
import toour.tripsuggestion.vo.DataVO;
import toour.util.ApiKeyUtil;
import toour.util.Paging;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class SearchResultAction implements Action{
    List<DataVO> srlist = new ArrayList<>();
    List<DataVO> courseList = new ArrayList<>();

    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {

        MemberVO mvo = null;
        Object obj = request.getSession().getAttribute("member");
        if (obj != null) {
            mvo = (MemberVO) obj;
        }
        String courseDate_idx = request.getParameter("courseDate_idx");
        System.out.println("sraCourseDate_idx : " + courseDate_idx);

        String viewPath = null;
        String contentTypeid = request.getParameter("contentTypeId"); //관광타입ID (12:관광지, 14:문화시설, 15:축제공연행사, 25:여행코스, 28:레포츠, 32:숙박, 38:쇼핑, 39:음식점)
        String areaCode = request.getParameter("areaCode"); //지역코드
        String sigunguCode = request.getParameter("sigunguCode"); //시군구코드
        String cat1 = request.getParameter("cat1"); //대분류
        String cat2 = request.getParameter("cat2"); //중분류
        String cat3 = request.getParameter("cat3"); //소분류
        String cPage = request.getParameter("cPage"); //지금페이지
        String key = ApiKeyUtil.getServiceKeyParam(ApiKeyUtil.getSeKey());

        Paging page = new Paging(7, 3);

        String addTitle = request.getParameter("title"); // 코스 짜는 창에 넣을 때 넘어오는 title 이름
        String removeTitle = request.getParameter("removeTitle"); // 코스 짜는 창에서 목록 삭제할 때 넘어오는 title

        // 내코스 버튼 눌렀을때 전달 받을 값
        String myCourse = null;
        Object mycourse = request.getAttribute("myCourse");
        if (mycourse != null) {
            myCourse = (String) mycourse;
        }

        System.out.println("myCourse:"+myCourse);
        request.setAttribute("myCourse", myCourse);

        // 요청시 contentType을 얻어낸다. get방식은 null값
        String enc_type = request.getContentType();

        String index = request.getParameter("index");
        int index1 = 0;
        if (index != null) {
            index1 = Integer.valueOf(index); // 넘어오는 index 값
        }
        String keyword = request.getParameter("keyword"); //키워드
        String encodedKeyword =null;
        if(keyword != null) {
            try {
                encodedKeyword = URLEncoder.encode(keyword, "UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException(e);
            }
            System.out.println(keyword);
        }
        Object obj1 =request.getAttribute("F5");
        String f5 = null;
        if(obj1!=null){
            f5 = String.valueOf(obj1);
        }

        System.out.println("here1");

        if (f5 != null) {
            //나만의 코스를 눌렀을 때 혹은 F5로 새로고침을 했을 경우
            if(request.getParameter("result")==null)
                mvo.getCourseList().clear();
            viewPath = "findWay.jsp";
            System.out.println("f5 : "+f5 );
        } else {
            // 코스에 관광지를 추가하거나 삭제 했을 경우 , [+] or [-]
            System.out.println("f5 : null" );
            if (addTitle != null && !addTitle.trim().isEmpty() && removeTitle == null && myCourse == null) {
                System.out.println("myCourse : " + myCourse);
                System.out.println("here2");
                // + 버튼 눌렀을 때 수행

                System.out.println("myCourse x");
                mvo.getCourseList().add(srlist.get(index1));

                request.setAttribute("addTitle", addTitle);

                viewPath = "addList.jsp";

            } else if (removeTitle != null && !removeTitle.trim().isEmpty() && addTitle == null) {
            // - 버튼 눌렀을 때 수행
            System.out.println("here3");
            System.out.println(removeTitle);

//          courseList.remove(index1);
            mvo.getCourseList().remove(index1);


//          request.setAttribute("courseList", courseList);

            viewPath = "addList.jsp";
        } else if (myCourse!=null&&myCourse.equals("myCourse")) {
            // 내코스 눌렀을 때 코스리스트 창으로 바로 반환

            System.out.println("here4");
            viewPath = "addList.jsp";
        } else {
            // 검색창에 검색했을 때 수행
            System.out.println("here?");
            System.out.println(keyword);
                if (keyword != null) {
                    request.setAttribute("keyword", keyword);
                }
            SearchDataVO[] data = GetAPISearchData.getSearch(request, encodedKeyword);
            request.setAttribute("data", data);
            viewPath = "searchReturn.jsp";

                String code = request.getParameter("areaCode");
                if (code == null) {
                    areaCode = "0";
                    if (areaCode == null) {
                        areaCode = "1";
                    }

                    if (cPage == null) {
                        cPage = "1";
                    }
//          https://apis.data.go.kr/B551011/KorService2/searchKeyword2?serviceKey=서비스인증키
//          &MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&keyword=시장&
//          cat1=A04&cat2=A0401&cat3=A04010100&arrange=C&areaCode=39&sigunguCode=3&_type=json
//          &lDongRegnCd=50&lDongSignguCd=130&lclsSystm1=SH&lclsSystm2=SH06&lclsSystm3=SH060100

                    //관광타입(12: 관광지, 14: 문화시설, 15: 축제공연 행사, 25: 여행코스, 28: 레포츠, 32: 숙박, 38: 쇼핑, 39: 음식점) ID

                    //세빈 변경 (공공 API 요청 URL 구성 (searchKeyword2))
                    StringBuilder sb = new StringBuilder("https://apis.data.go.kr/B551011/KorService2/searchKeyword2?");
                    sb.append(key);
                    sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=");
                    sb.append(cPage);
                    sb.append("&numOfRows=");
                    sb.append("7");
                    sb.append("&keyword=");
                    sb.append(encodedKeyword);
                    if (cat1 != null && !cat1.equals("0")) {//0이 전부를 뜻함
                        sb.append("&cat1=");//자연/인문~
                        sb.append(cat1);
                        if (cat2 != null && !cat2.equals("0")) {
                            sb.append("&cat2=");//자연에서는 자연관광w/관광자원
                            sb.append(cat2);//인문에서는 역사 휴양 어쩌고 많음
                            if (cat3 != null && !cat3.equals("0")) {
                                sb.append("&cat3=");
                                sb.append(cat3);
                            }
                        }
                    }
                    sb.append("&arrange=A");
                    if (sigunguCode != null && !sigunguCode.equals("0")) {
                        sb.append("&sigunguCode=");
                        sb.append(sigunguCode);
                    }
                    sb.append("&_type=xml");
                    System.out.println("sb1:" + sb);
                    try {
                        URL url1 = new URL(sb.toString());
                        HttpURLConnection conn1 = (HttpURLConnection) url1.openConnection();
                        conn1.setRequestProperty("Content-Type", "application/xml");
                        conn1.connect();
                        SAXBuilder builder = new SAXBuilder();
                        Document doc = builder.build(conn1.getInputStream());
                        Element root = doc.getRootElement();
                        Element body = root.getChild("body");

                        Element totalCount = body.getChild("totalCount");
                        String totalCountStr = totalCount.getText();

                        Element items = body.getChild("items");
                        List<Element> item_list = items.getChildren("item");

                        DataVO[] ar = new DataVO[item_list.size()];

                        int i = 0;

                        srlist.clear();
                        //응답 메시지
                        for (Element item : item_list) {
                            String addr1 = item.getChildText("addr1");
                            String addr2 = item.getChildText("addr2");
                            String zipcode = item.getChildText("zipcode");
                            String voCat1 = item.getChildText("cat1");
                            String voCat2 = item.getChildText("cat2");
                            String voCat3 = item.getChildText("cat3");
                            String contentid = item.getChildText("contentid");
                            String contenttypeid = item.getChildText("contenttypeid");
                            String createdtime = item.getChildText("createdtime");
                            String firstimage = item.getChildText("firstimage");
                            System.out.println(firstimage);
                            if (Objects.equals(firstimage, ""))
                                firstimage = "./css/images/noImages.png";
                            String firstimage2 = item.getChildText("firstimage2");
                            String cpyrhtDivCd = item.getChildText("cpyrhtDivCd");
                            String mapx = item.getChildText("mapx");
                            String mapy = item.getChildText("mapy");
                            String mlevel = item.getChildText("mlevel");
                            String modifiedtime = item.getChildText("modifiedtime");
                            String sigungucode = item.getChildText("sigungucode");
                            String tel = item.getChildText("tel");
                            String title = item.getChildText("title"); //자식 태그 안의 문자열
                            String lDongRegnCd = item.getChildText("lDongRegnCd");
                            String lDongSignguCd = item.getChildText("lDongSignguCd");
                            String lclsSystm1 = item.getChildText("lclsSystm1");
                            String lclsSystm2 = item.getChildText("lclsSystm2");
                            String lclsSystm3 = item.getChildText("lclsSystm3");

//https://apis.data.go.kr/B551011/KorService2/detailCommon2?serviceKey=인증키
// &MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&contentId=126128&_type=json

                            //결과 객체 생성
                            DataVO srvo = new DataVO();
                            srvo.setAddr1(addr1);
                            srvo.setFirstimage(firstimage);
                            srvo.setTitle(title);
                            srvo.setMapx(mapx);
                            srvo.setMapy(mapy);
                            srvo.setContentId(contentid);
                            srvo.setContentTypeId(contenttypeid);

                            page.setTotalCount(Integer.parseInt(totalCountStr));
                            page.setNowPage(Integer.parseInt(cPage));


                            ar[i++] = srvo;

                            srlist.add(srvo);
                        }
                        // 최종적으로 배열을 dataAr 라는 이름으로 JSP에 전달
                        request.setAttribute("resultAr", ar);
                        request.setAttribute("mapPage", page);

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }

                //공공데이터 openAPI 호출하는 경로
                //http://apis.data.go.kr/B551011/KorService2/areaBasedList2?serviceKey=서비스인증키

            }

        }
        System.out.println("sraCourseDate_idx2 :" +courseDate_idx);
        // DB에서 코스 수정하기 위해 idx값 전달
        request.setAttribute("courseDate_idx", courseDate_idx);
        return viewPath;
    }

}
