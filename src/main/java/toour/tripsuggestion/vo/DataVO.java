package toour.tripsuggestion.vo;

public class DataVO {
    private String title, mapx, mapy, addr1, addr2, firstimage, firstimage2, tel, eventstartdate, eventenddate,
            cat1, cat2, cat3, contentTypeId,contentId, overview, infocenter, parking, restdate, usetime, cPage
            , homepageUrl, homepageText,subcontentid, subdetailalt, subdetailimg, subdetailoverview, subname, totalCount;
    public DataVO() {}

    public String getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(String totalCount) {
        this.totalCount = totalCount;
    }

    public String getSubcontentid() {
        return subcontentid;
    }

    public void setSubcontentid(String subcontentid) {
        this.subcontentid = subcontentid;
    }

    public String getSubdetailalt() {
        return subdetailalt;
    }

    public void setSubdetailalt(String subdetailalt) {
        this.subdetailalt = subdetailalt;
    }

    public String getSubdetailimg() {
        return subdetailimg;
    }

    public void setSubdetailimg(String subdetailimg) {
        this.subdetailimg = subdetailimg;
    }

    public String getSubdetailoverview() {
        return subdetailoverview;
    }

    public void setSubdetailoverview(String subdetailoverview) {
        this.subdetailoverview = subdetailoverview;
    }

    public String getSubname() {
        return subname;
    }

    public void setSubname(String subname) {
        this.subname = subname;
    }

    public DataVO(String title,String addr1,String overview,String firstimage,String mapx,String mapy,String homepageUrl,String homepageText, String totalCount){
        this.title = title;
        this.addr1 = addr1;
        this.overview = overview;
        this.firstimage = firstimage;
        this.mapx = mapx;
        this.mapy = mapy;
        this.homepageUrl = homepageUrl;
        this.homepageText = homepageText;
        this.totalCount = totalCount;
    }

    public DataVO(String subcontentid, String subdetailalt, String subdetailimg, String subdetailoverview, String subname, String mapx, String mapy, String totalCount) {
        this.subcontentid = subcontentid;
        this.subdetailalt = subdetailalt;
        this.subdetailimg = subdetailimg;
        this.subdetailoverview = subdetailoverview;
        this.subname = subname;
        this.mapx = mapx;
        this.mapy = mapy;
        this.totalCount = totalCount;
    }
    public String getInfocenter() {
        return infocenter;
    }

    public void setInfocenter(String infocenter) {
        this.infocenter = infocenter;
    }

    public String getParking() {
        return parking;
    }

    public void setParking(String parking) {
        this.parking = parking;
    }

    public String getRestdate() {
        return restdate;
    }

    public void setRestdate(String restdate) {
        this.restdate = restdate;
    }

    public String getUsetime() {
        return usetime;
    }

    public void setUsetime(String usetime) {
        this.usetime = usetime;
    }

    public String getcPage() {
        return cPage;
    }

    public void setcPage(String cPage) {
        this.cPage = cPage;
    }

    public String getHomepageUrl() {
        return homepageUrl;
    }

    public void setHomepageUrl(String homepageUrl) {
        this.homepageUrl = homepageUrl;
    }

    public String getHomepageText() {
        return homepageText;
    }

    public void setHomepageText(String homepageText) {
        this.homepageText = homepageText;
    }

    public DataVO(String infocenter, String parking, String restdate, String usetime){
        this.infocenter = infocenter;
        this.parking = parking;
        this.restdate = restdate;
        this.usetime = usetime;
    }

    public DataVO(String title, String addr1, String overview, String firstimage, String mapx, String mapy, String contentTypeId, String contentId, String cPage, String homepageText, String homepageUrl) {
        this.title = title;
        this.addr1 = addr1;
        this.overview = overview;
        this.firstimage = firstimage;
        this.mapx = mapx;
        this.mapy = mapy;
        this.contentTypeId = contentTypeId;
        this.contentId = contentId;
        this.cPage = cPage;
        this.homepageUrl = homepageUrl;
        this.homepageText = homepageText;
    }
    public DataVO(String title, String mapx, String mapy, String addr1, String addr2, String firstimage, String firstimage2, String eventstartdate, String eventenddate, String tel, String contentTypeId, String contentId, String overview){
        this.title = title;
        this.mapx = mapx;
        this.mapy = mapy;
        this.addr1 = addr1;
        this.addr2 = addr2;
        this.firstimage = firstimage;
        this.firstimage2 = firstimage2;
        this.eventstartdate = eventstartdate;
        this.eventenddate = eventenddate;
        this.tel = tel;
        this.overview = overview;
        this.contentTypeId = contentTypeId;
        this.contentId = contentId;
    }
    public DataVO(String title, String mapx, String mapy, String addr1, String addr2, String firstimage, String tel, String contentTypeId, String contentId, String overview, String homepageText, String homepageUrl) {
        this.title = title;
        this.mapx = mapx;
        this.mapy = mapy;
        this.addr1 = addr1;
        this.addr2 = addr2;
        this.firstimage = firstimage;
        this.tel = tel;
        this.contentTypeId = contentTypeId;
        this.contentId = contentId;
        this.overview = overview;
        this.homepageText = homepageText;
        this.homepageUrl = homepageUrl;
    }

    public String getContentId() {
        return contentId;
    }

    public void setContentId(String contentId) {
        this.contentId = contentId;
    }

    public String getOverview() {
        return overview;
    }

    public void setOverview(String overview) {
        this.overview = overview;
    }

    public String getCat1() {
        return cat1;
    }

    public void setCat1(String cat1) {
        this.cat1 = cat1;
    }

    public String getCat2() {
        return cat2;
    }

    public void setCat2(String cat2) {
        this.cat2 = cat2;
    }

    public String getCat3() {
        return cat3;
    }

    public void setCat3(String cat3) {
        this.cat3 = cat3;
    }

    public String getContentTypeId() {
        return contentTypeId;
    }

    public void setContentTypeId(String contentTypeId) {
        this.contentTypeId = contentTypeId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMapx() {
        return mapx;
    }

    public void setMapx(String mapx) {
        this.mapx = mapx;
    }

    public String getMapy() {
        return mapy;
    }

    public void setMapy(String mapy) {
        this.mapy = mapy;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getAddr2() {
        return addr2;
    }

    public void setAddr2(String addr2) {
        this.addr2 = addr2;
    }

    public String getFirstimage() {
        return firstimage;
    }

    public void setFirstimage(String firstimage) {
        this.firstimage = firstimage;
    }

    public String getFirstimage2() {
        return firstimage2;
    }

    public void setFirstimage2(String firstimage2) {
        this.firstimage2 = firstimage2;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEventstartdate() {
        return eventstartdate;
    }

    public void setEventstartdate(String eventstartdate) {
        this.eventstartdate = eventstartdate;
    }

    public String getEventenddate() {
        return eventenddate;
    }

    public void setEventenddate(String eventenddate) {
        this.eventenddate = eventenddate;
    }
}