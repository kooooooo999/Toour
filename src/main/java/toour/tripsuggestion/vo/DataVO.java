package toour.tripsuggestion.vo;

public class DataVO {
    private String title, mapx, mapy, addr1, addr2, firstimage, firstimage2, tel, eventstartdate, eventenddate,
    cat1, cat2, cat3, cat1name,cat2name,cat3name, contentTypeId,contentId, overview, areacode,sigungucode,sigunguname;

    public  DataVO(){

    }

    public DataVO(String title, String mapx, String mapy, String addr1, String addr2, String firstimage, String firstimage2, String tel, String eventstartdate, String eventenddate, String contentTypeId, String contentId, String overview) {
        this.title = title;
        this.mapx = mapx;
        this.mapy = mapy;
        this.addr1 = addr1;
        this.addr2 = addr2;
        this.firstimage = firstimage;
        this.firstimage2 = firstimage2;
        this.tel = tel;
        this.eventstartdate = eventstartdate;
        this.eventenddate = eventenddate;
        this.contentTypeId = contentTypeId;
        this.contentId = contentId;
        this.overview = overview;
    }


    public String getCat1name() {
        return cat1name;
    }

    public void setCat1name(String cat1name) {
        this.cat1name = cat1name;
    }

    public String getCat2name() {
        return cat2name;
    }

    public void setCat2name(String cat2name) {
        this.cat2name = cat2name;
    }

    public String getCat3name() {
        return cat3name;
    }

    public void setCat3name(String cat3name) {
        this.cat3name = cat3name;
    }

    public String getAreacode() {
        return areacode;
    }

    public void setAreacode(String areacode) {
        this.areacode = areacode;
    }

    public String getSigungucode() {
        return sigungucode;
    }

    public void setSigungucode(String sigungucode) {
        this.sigungucode = sigungucode;
    }

    public String getSigunguname() {
        return sigunguname;
    }

    public void setSigunguname(String sigunguname) {
        this.sigunguname = sigunguname;
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
