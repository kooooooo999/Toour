package toour.search.vo;

// 키워드 검색 조회 (요청 메시지)
public class SearchDataVO {
    private String arrange, keyword, areaCode, sigunguCode, sigunguname, cat1, cat2, cat3,
    lDongRegnCd, lDongSignguCd, lclsSystm1, lclsSystm2, lclsSystm3;

    public SearchDataVO(){

    }

    public SearchDataVO(String arrange, String keyword, String areaCode, String sigunguCode, String cat1, String cat2, String cat3, String lDongRegnCd, String lDongSignguCd, String lclsSystm1, String lclsSystm2, String lclsSystm3){
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
    }


    public String getArrange() {return arrange;}

    public void setArrange(String arrange) {this.arrange = arrange;}

    public String getKeyword() {return keyword;}

    public void setKeyword(String keyword) {this.keyword = keyword;}

    public String getAreaCode() {return areaCode;}

    public void setAreaCode(String areaCode) {this.areaCode = areaCode;}

    public String getSigunguCode() {return sigunguCode;}

    public void setSigunguCode(String sigunguCode) {this.sigunguCode = sigunguCode;}

    public String getSigunguname() {return sigunguname;}

    public void setSigunguname(String sigunguname) {this.sigunguname = sigunguname;}

    public String getCat1() {return cat1;}

    public void setCat1(String cat1) {this.cat1 = cat1;}

    public String getCat2() {return cat2;}

    public void setCat2(String cat2) {this.cat2 = cat2;}

    public String getCat3() {return cat3;}

    public void setCat3(String cat3) {this.cat3 = cat3;}

    public String getlDongRegnCd() {return lDongRegnCd;}

    public void setlDongRegnCd(String lDongRegnCd) {this.lDongRegnCd = lDongRegnCd;}

    public String getlDongSignguCd() {return lDongSignguCd;}

    public void setlDongSignguCd(String lDongSignguCd) {this.lDongSignguCd = lDongSignguCd;}

    public String getLclsSystm1() {return lclsSystm1;}

    public void setLclsSystm1(String lclsSystm1) {this.lclsSystm1 = lclsSystm1;}

    public String getLclsSystm2() {return lclsSystm2;}

    public void setLclsSystm2(String lclsSystm2) {this.lclsSystm2 = lclsSystm2;}

    public String getLclsSystm3() {return lclsSystm3;}

    public void setLclsSystm3(String lclsSystm3) {this.lclsSystm3 = lclsSystm3;
    }

}
