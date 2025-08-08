package toour.search.vo;

// 키워드 검색 조회 (요청 메시지)
public class SearchDataVO {
    // 검색 조건 관련 필드
    private String arrange, keyword, areaCode, sigunguCode, sigunguname,
                   cat1, cat2, cat3,
                   lDongRegnCd, lDongSignguCd,
                   lclsSystm1, lclsSystm2, lclsSystm3,
                   title, addr1, firstimage, mapx, mapy, contentid;

    // 기본 생성자
    public SearchDataVO(){

    }

    // 모든 필드를 포함한 생성자
    public SearchDataVO(String arrange, String keyword, String areaCode, String sigunguCode, String sigunguname,
                        String cat1, String cat2, String cat3,
                        String lDongRegnCd, String lDongSignguCd,
                        String lclsSystm1, String lclsSystm2, String lclsSystm3,
                        String title, String addr1, String firstimage,
                        String mapx, String mapy, String contentid) {

        this.arrange = arrange;
        this.keyword = keyword;
        this.areaCode = areaCode;
        this.sigunguCode = sigunguCode;
        this.sigunguname = sigunguname;
        this.cat1 = cat1;
        this.cat2 = cat2;
        this.cat3 = cat3;
        this.lDongRegnCd = lDongRegnCd;
        this.lDongSignguCd = lDongSignguCd;
        this.lclsSystm1 = lclsSystm1;
        this.lclsSystm2 = lclsSystm2;
        this.lclsSystm3 = lclsSystm3;
        this.title = title;
        this.addr1 = addr1;
        this.firstimage = firstimage;
        this.mapx = mapx;
        this.mapy = mapy;
        this.contentid = contentid;
    }

    public String getArrange() {
        return arrange;
    }

    public void setArrange(String arrange) {
        this.arrange = arrange;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getAreaCode() {
        return areaCode;
    }

    public void setAreaCode(String areaCode) {
        this.areaCode = areaCode;
    }

    public String getSigunguCode() {
        return sigunguCode;
    }

    public void setSigunguCode(String sigunguCode) {
        this.sigunguCode = sigunguCode;
    }

    public String getSigunguname() {
        return sigunguname;
    }

    public void setSigunguname(String sigunguname) {
        this.sigunguname = sigunguname;
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

    public String getlDongRegnCd() {
        return lDongRegnCd;
    }

    public void setlDongRegnCd(String lDongRegnCd) {
        this.lDongRegnCd = lDongRegnCd;
    }

    public String getlDongSignguCd() {
        return lDongSignguCd;
    }

    public void setlDongSignguCd(String lDongSignguCd) {
        this.lDongSignguCd = lDongSignguCd;
    }

    public String getLclsSystm1() {
        return lclsSystm1;
    }

    public void setLclsSystm1(String lclsSystm1) {
        this.lclsSystm1 = lclsSystm1;
    }

    public String getLclsSystm2() {
        return lclsSystm2;
    }

    public void setLclsSystm2(String lclsSystm2) {
        this.lclsSystm2 = lclsSystm2;
    }

    public String getLclsSystm3() {
        return lclsSystm3;
    }

    public void setLclsSystm3(String lclsSystm3) {
        this.lclsSystm3 = lclsSystm3;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }

    public String getFirstimage() {
        return firstimage;
    }

    public void setFirstimage(String firstimage) {
        this.firstimage = firstimage;
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

    public String getContentid() {
        return contentid;
    }

    public void setContentid(String contentid) {
        this.contentid = contentid;
    }
}
// API 응답을 자바 객체 형태로 담기 위한 VO
// 관광지 검색 조건 + 결과 데이터를 한꺼번에 담을 수 있음
// GetAPISearchData 클래스 등에서 이 VO를 이용해 응답 데이터를 생성하고 SearchResponseVO로 묶어서 응답
