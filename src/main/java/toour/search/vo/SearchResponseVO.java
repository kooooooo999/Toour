package toour.search.vo;

public class SearchResponseVO {
    private String
            addr1,addr2,areacode,cat1, cat2, cat3, contentid, contenttypeid, createdtime,
            firstimage, firstimage2, cpyrhtDivCd,mapx, mapy, mlevel, modifiedtime,
            sigungucode, tel, title, lDongRegnCd, lDongSignguCd, lclsSystm1,
            lclsSystm2,lclsSystm3,zipcode, overview;

    public SearchResponseVO(){

    }
    public SearchResponseVO(String title, String addr1, String overview, String firstimage) {
        this.title = title;
        this.addr1 = addr1;
        this.overview = overview;
        this.firstimage = firstimage;
    }
    public SearchResponseVO( String addr1, String addr2, String areacode, String cat1, String cat2, String cat3, String contentid, String contenttypeid, String createdtime,
                             String firstimage, String firstimage2, String cpyrhtDivCd,String mapx, String mapy, String mlevel, String modifiedtime,
                             String sigungucode, String tel, String title, String lDongRegnCd, String lDongSignguCd, String lclsSystm1,
                             String lclsSystm2, String lclsSystm3, String zipcode, String overview){

        this.addr1 = addr1;
        this.addr2 = addr2;
        this.areacode = areacode;
        this.cat1 = cat1;
        this.cat2 = cat2;
        this.cat3 = cat3;
        this.contentid = contentid;
        this.contenttypeid = contenttypeid;
        this.createdtime = createdtime;
        this.firstimage = firstimage;
        this.firstimage2 = firstimage2;
        this.cpyrhtDivCd = cpyrhtDivCd;
        this.mapx = mapx;
        this.mapy = mapy;
        this.mlevel = mlevel;
        this.modifiedtime = modifiedtime;
        this.sigungucode = sigungucode;
        this.tel = tel;
        this.title = title;
        this.lDongRegnCd = lDongRegnCd;
        this.lDongSignguCd = lDongSignguCd;
        this.lclsSystm1 = lclsSystm1;
        this.lclsSystm2 = lclsSystm2;
        this.lclsSystm3 = lclsSystm3;
        this.zipcode = zipcode;
        this.overview = overview;
    }

    public String getOverview() {
        return overview;
    }

    public void setOverview(String overview) {
        this.overview = overview;
    }

    public String getAddr1() {return addr1;}

    public void setAddr1(String addr1) {this.addr1 = addr1;}

    public String getAddr2() {return addr2;}

    public void setAddr2(String addr2) {this.addr2 = addr2;}

    public String getAreacode() {return areacode;}

    public void setAreacode(String areacode) {this.areacode = areacode;}

    public String getCat1() {return cat1;}

    public void setCat1(String cat1) {this.cat1 = cat1;}

    public String getCat2() {return cat2;}

    public void setCat2(String cat2) {this.cat2 = cat2;}

    public String getCat3() {return cat3;}

    public void setCat3(String cat3) {this.cat3 = cat3;}

    public String getContentid() {return contentid;}

    public void setContentid(String contentid) {this.contentid = contentid;}

    public String getContenttypeid() {return contenttypeid;}

    public void setContenttypeid(String contenttypeid) {this.contenttypeid = contenttypeid;}

    public String getCreatedtime() {return createdtime;}

    public void setCreatedtime(String createdtime) {this.createdtime = createdtime;}

    public String getFirstimage() {return firstimage;}

    public void setFirstimage(String firstimage) {this.firstimage = firstimage;}

    public String getFirstimage2() {return firstimage2;}

    public void setFirstimage2(String firstimage2) {this.firstimage2 = firstimage2;}

    public String getCpyrhtDivCd() {return cpyrhtDivCd;}

    public void setCpyrhtDivCd(String cpyrhtDivCd) {this.cpyrhtDivCd = cpyrhtDivCd;}

    public String getMapx() {return mapx;}

    public void setMapx(String mapx) {this.mapx = mapx;}

    public String getMapy() {return mapy;}

    public void setMapy(String mapy) {this.mapy = mapy;}

    public String getMlevel() {return mlevel;}

    public void setMlevel(String mlevel) {this.mlevel = mlevel;}

    public String getModifiedtime() {return modifiedtime;}

    public void setModifiedtime(String modifiedtime) {this.modifiedtime = modifiedtime;}

    public String getSigungucode() {return sigungucode;}

    public void setSigungucode(String sigungucode) {this.sigungucode = sigungucode;}

    public String getTel() {return tel;}

    public void setTel(String tel) {this.tel = tel;}

    public String getTitle() {return title;}

    public void setTitle(String title) {this.title = title;}

    public String getlDongRegnCd() {return lDongRegnCd;}

    public void setlDongRegnCd(String lDongRegnCd) {this.lDongRegnCd = lDongRegnCd;}

    public String getlDongSignguCd() {return lDongSignguCd;}

    public void setlDongSignguCd(String lDongSignguCd) {this.lDongSignguCd = lDongSignguCd;}

    public String getLclsSystm1() {return lclsSystm1;}

    public void setLclsSystm1(String lclsSystm1) {this.lclsSystm1 = lclsSystm1;}

    public String getLclsSystm2() {return lclsSystm2;}

    public void setLclsSystm2(String lclsSystm2) {this.lclsSystm2 = lclsSystm2;}

    public String getLclsSystm3() {return lclsSystm3;}

    public void setLclsSystm3(String lclsSystm3) {this.lclsSystm3 = lclsSystm3;}

    public String getZipcode() {return zipcode;}

    public void setZipcode(String zipcode) {this.zipcode = zipcode;}
}
