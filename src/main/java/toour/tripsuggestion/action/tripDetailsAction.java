package toour.tripsuggestion.action;

import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.input.SAXBuilder;
import toour.action.Action;
import toour.member.dao.ZzimDAO;
import toour.member.vo.MemberVO;
import toour.member.vo.ZzimVO;
import toour.tripsuggestion.vo.DataVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

public class tripDetailsAction implements Action {
    @Override
    public String execute(HttpServletRequest request, HttpServletResponse response) {
        String title = request.getParameter("title");
        String addr1 = request.getParameter("addr1");
        String overview = request.getParameter("overview");
        String firstimage = request.getParameter("firstimage");
        String mapx = request.getParameter("mapx");
        String mapy = request.getParameter("mapy");
        String contentTypeId = request.getParameter("contentTypeId");
        String contentId = request.getParameter("contentId");
        String cPage = request.getParameter("cPage");
        String homepageUrl = request.getParameter("homepageUrl");
        String homepageText = request.getParameter("homepageText");
        DataVO datavo = new DataVO(title, addr1, overview, firstimage, mapx, mapy, contentTypeId, contentId, cPage, homepageText, homepageUrl);

        Object obj1 = request.getAttribute("dataAr");
        DataVO dataArVo = null;
        if (obj1 != null) {
            dataArVo = (DataVO) obj1;
            request.setAttribute("detailsAr", dataArVo);
        } else
            request.setAttribute("detailsAr", datavo);

        //찜 목록에 해당 관광지가 속해 있는지 확인하고 있다면 하트를 채워 놓기 위해 신호를 보내는 곳
        boolean zzim_state = false;
        ZzimVO[] zzim_ar = null;
        if (contentId != null) {
            Object obj = request.getSession().getAttribute("member");
            MemberVO mvo = null;
            if (obj != null) {
                mvo = (MemberVO) obj;
                zzim_ar = ZzimDAO.getZzimAr(mvo.getMember_idx());
                if (zzim_ar != null) {
                    for (ZzimVO zvo : zzim_ar) {
                        if (contentId.equals(zvo.getZzim_content_id())) {
                            zzim_state = true;
                            break;
                        }
                    }
                }
            }
        }
        request.setAttribute("zzim_state", zzim_state);

        //http://apis.data.go.kr/B551011/KorService2/detailIntro2?serviceKey=인증키
        //&MobileApp=AppTest&MobileOS=ETC&pageNo=1&numOfRows=10&_type=json&contentTypeId=12&contentId=
        //126128
        StringBuilder sb = new StringBuilder("http://apis.data.go.kr/B551011/KorService2/detailIntro2?");
        String key = "serviceKey=QZqnwRRbk91dk1rSfVmLByXYHxG5LXUX03kbhu31XCqODQh1%2BJAgNigVraqO%2F1sEZtE3mOCC6FV4JZjPXy73xw%3D%3D";

        sb.append(key);
        sb.append("&MobileApp=AppTest&MobileOS=ETC&pageNo=1");
        sb.append("&numOfRows=5&_type=xml&contentTypeId=");
        sb.append(contentTypeId);
        sb.append("&contentId=");
        sb.append(contentId);
        try {
            URL url = new URL(sb.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestProperty("Content-Type", "application/xml");
            conn.connect();
            SAXBuilder builder = new SAXBuilder();
            Document doc = builder.build(conn.getInputStream());
            Element root = doc.getRootElement();
            Element body = root.getChild("body");
            Element items = body.getChild("items");
            List<Element> itemList = items.getChildren("item");
            DataVO[] dvo = new DataVO[itemList.size()];
            int i = 0;
            DataVO vo = new DataVO();
            for (Element item : itemList) {
                if (contentTypeId.equals("12")) {
                    String accomcount = item.getChildText("accomcount"); //수용인원
                    String chkpet = item.getChildText("chkpet"); //애완동물동반가능정보
                    String expagerange = item.getChildText("expagerange"); //체험가능연령
                    String expguide = item.getChildText("expguide"); //체험안내
                    String opendate = item.getChildText("opendate"); //개장일
                    String infocenter = item.getChildText("infocenter"); //문의안내
                    String parking = item.getChildText("parking"); //주차시설
                    String restdate = item.getChildText("restdate"); //쉬는날
                    String usetime = item.getChildText("usetime"); //이용시간
                    vo.setAccomcount(accomcount);
                    vo.setChkpet(chkpet);
                    vo.setExpagerange(expagerange);
                    vo.setExpguide(expguide);
                    vo.setOpendate(opendate);
                    vo.setInfocenter(infocenter);
                    vo.setParking(parking);
                    vo.setRestdate(restdate);
                    vo.setUsetime(usetime);
                    dvo[i++] = vo;
                }
                if (contentTypeId.equals("14")) {
                    String accomcount = item.getChildText("accomcountculture"); //수용인원
                    String chkbabycarriage = item.getChildText("chkbabycarriageculture"); //유모차대여
                    String chkpetculture = item.getChildText("chkpetculture"); //애완동물동반
                    String infocenter = item.getChildText("infocenterculture"); //문의및안내
                    String parking = item.getChildText("parkingculture"); //주차시설
                    String parkingfee = item.getChildText("parkingfee"); //주차요금
                    String restdate = item.getChildText("restdateculture"); //쉬는날
                    String scale = item.getChildText("scale"); //규모
                    String usetimeculture = item.getChildText("usetimeculture"); //이용시간
                    vo.setAccomcount(accomcount);
                    vo.setChkbabycarriage(chkbabycarriage);
                    vo.setChkpetculture(chkpetculture);
                    vo.setInfocenter(infocenter);
                    vo.setParking(parking);
                    vo.setRestdate(restdate);
                    vo.setUsetime(usetimeculture);
                    vo.setParkingfee(parkingfee);
                    vo.setScale(scale);
                    dvo[i++] = vo;
                }
                if (contentTypeId.equals("15")) {
                    String spendtime = item.getChildText("spendtime"); //관람소요시간
                    String agelimit = item.getChildText("agelimit"); //관람연령
                    String bookingplace = item.getChildText("bookingplace"); //예매처
                    String eventenddate = item.getChildText("eventenddate"); //행사종료일
                    String eventhomepage = item.getChildText("eventhomepage"); //행사홈페이지
                    String eventplace = item.getChildText("eventplace"); //행사장소
                    String eventstartdate = item.getChildText("eventstartdate"); //행사시작일
                    String playtime = item.getChildText("playtime"); //공연시간
                    String program = item.getChildText("program"); //행사프로그램
                    String sponsor1 = item.getChildText("sponsor1"); //주최자정보
                    String sponsor1tel = item.getChildText("sponsor1tel"); //주최자연락처
                    String usetimefestival = item.getChildText("usetimefestival"); //이용요금
                    vo.setSpendtime(spendtime);
                    vo.setAgelimit(agelimit);
                    vo.setBookingplace(bookingplace);
                    vo.setEventenddate(eventenddate);
                    vo.setEventhomepage(eventhomepage);
                    vo.setEventplace(eventplace);
                    vo.setEventstartdate(eventstartdate);
                    vo.setPlaytime(playtime);
                    vo.setProgram(program);
                    vo.setSponsor1tel(sponsor1tel);
                    vo.setUsetimefestival(usetimefestival);
                    vo.setSponsor1(sponsor1);
                    dvo[i++] = vo;
                }//Type(25) 여행코스는 뺄까아아아아????
                if (contentTypeId.equals("28")) {
                    String accomcount = item.getChildText("accomcountleports"); //수용인원
                    String chkbabycarriage = item.getChildText("chkbabycarriageleports"); //유모차대여정보
                    String chkpet = item.getChildText("chkpetleports"); //애완동물
                    String expagerange = item.getChildText("expagerangeleports"); //체험가능연령
                    String infocenter = item.getChildText("infocenterleports"); //문의및안내
                    String openperiod = item.getChildText("openperiod"); //개장기간
                    String parkingfeeleports = item.getChildText("parkingfeeleports"); //주차요금
                    String parkingleports = item.getChildText("parkingleports"); //주차시설
                    String reservation = item.getChildText("reservation"); //예약안내
                    String restdate = item.getChildText("restdateleports"); //쉬는날
                    String usefeeleports = item.getChildText("usefeeleports"); //입장료
                    String usetime = item.getChildText("usetimeleports"); //이용시간
                    vo.setAccomcount(accomcount);
                    vo.setChkbabycarriage(chkbabycarriage);
                    vo.setChkpet(chkpet);
                    vo.setExpagerange(expagerange);
                    vo.setInfocenter(infocenter);
                    vo.setOpenperiod(openperiod);
                    vo.setParkingfeeleports(parkingfeeleports);
                    vo.setParkingleports(parkingleports);
                    vo.setReservation(reservation);
                    vo.setRestdate(restdate);
                    vo.setUsefeeleports(usefeeleports);
                    vo.setUsetime(usetime);
                    dvo[i++] = vo;
                }
                if (contentTypeId.equals("32")) {
                    String roomtype = item.getChildText("roomtype"); //객실유형
                    String checkintime = item.getChildText("checkintime"); //입실시간
                    String checkouttime = item.getChildText("checkouttime"); //퇴실시간
                    String chkcooking = item.getChildText("chkcooking"); //객실내취사여부
                    String infocenter = item.getChildText("infocenterlodging"); //문의및안내
                    String parking = item.getChildText("parkinglodging"); //주차시설
                    String roomcount = item.getChildText("roomcount"); //객실수
                    String reservationurl = item.getChildText("reservationurl"); //예약안내홈페이지
                    String subfacility = item.getChildText("subfacility"); //부대시설
                    vo.setHomepageUrl(reservationurl);
                    vo.setCheckintime(checkintime);
                    vo.setCheckouttime(checkouttime);
                    vo.setChkcooking(chkcooking);
                    vo.setInfocenter(infocenter);
                    vo.setParking(parking);
                    vo.setRoomcount(roomcount);
                    vo.setRoomtype(roomtype);
                    vo.setSubfacility(subfacility);
                    dvo[i++] = vo;
                }
                if (contentTypeId.equals("38")) {
                    String infocenter = item.getChildText("infocentershopping"); //문의및안내
                    String opendateshopping = item.getChildText("opendateshopping"); //개장일
                    String opentime = item.getChildText("opentime"); //영업시간
                    String parking = item.getChildText("parkingshopping"); //주차시설
                    String restdate = item.getChildText("restdateshopping"); //쉬는날
                    String saleitem = item.getChildText("saleitem"); //판매품목
                    vo.setInfocenter(infocenter);
                    vo.setOpendateshopping(opendateshopping);
                    vo.setOpentime(opentime);
                    vo.setParking(parking);
                    vo.setRestdate(restdate);
                    vo.setSaleitem(saleitem);
                    dvo[i++] = vo;
                }
                if (contentTypeId.equals("39")) {
                    String firstmenu = item.getChildText("firstmenu"); //대표메뉴
                    String infocenter = item.getChildText("infocenterfood"); //문의및안내
                    String opentimefood = item.getChildText("opentimefood"); //영업시간
                    String packing = item.getChildText("packing"); //포장가능
                    String parking = item.getChildText("parkingfood"); //주차시설
                    String seat = item.getChildText("seat"); //좌석수
                    vo.setFirstmenu(firstmenu);
                    vo.setInfocenter(infocenter);
                    vo.setOpentimefood(opentimefood);
                    vo.setParking(parking);
                    vo.setSeat(seat);
                    vo.setPacking(packing);
                    dvo[i++] = vo;
                }


            }
            request.setAttribute("detailsAr_2", dvo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "tripDetails.jsp";
    }
}
