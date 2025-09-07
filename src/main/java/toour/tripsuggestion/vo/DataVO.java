package toour.tripsuggestion.vo;

public class DataVO {
    private String title, mapx, mapy, addr1, addr2, firstimage, firstimage2, tel,
            cat1, cat2, cat3, contentTypeId, contentId, overview, infocenter, parking, restdate, usetime, cPage, homepageUrl, homepageText, subcontentid, subdetailalt, subdetailimg, subdetailoverview, subname, totalCount, distance, schedule, theme, sidoname,
            accomcount, chkbabycarriage, chkpet, expagerange, expguide, opendate,
            chkpetculture, parkingfee, scale, usetimeculture,
            spendtime, agelimit, bookingplace, eventenddate, eventhomepage, eventplace, eventstartdate, playtime, program, sponsor1, sponsor1tel, usetimefestival,
            openperiod, parkingfeeleports, parkingleports, reservation, usefeeleports,
            checkintime, checkouttime, chkcooking, roomcount, subfacility,
            opendateshopping, opentime, saleitem, roomtype,
            firstmenu, opentimefood, packing, seat;

    public DataVO(String distance, String schedule, String theme) {
        this.distance = distance;
        this.schedule = schedule;
        this.theme = theme;
    }

    public DataVO() {
    }

    public DataVO(String title, String addr1, String overview, String firstimage, String mapx, String mapy, String homepageUrl, String homepageText, String totalCount) {
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

    public DataVO(String infocenter, String parking, String restdate, String usetime) {
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

    public DataVO(String title, String mapx, String mapy, String addr1, String addr2, String firstimage, String firstimage2, String eventstartdate, String eventenddate, String tel, String contentTypeId, String contentId, String overview) {
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

    public String getFirstmenu() {
        return firstmenu;
    }

    public void setFirstmenu(String firstmenu) {
        this.firstmenu = firstmenu;
    }

    public String getOpentimefood() {
        return opentimefood;
    }

    public void setOpentimefood(String opentimefood) {
        this.opentimefood = opentimefood;
    }

    public String getPacking() {
        return packing;
    }

    public void setPacking(String packing) {
        this.packing = packing;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public String getRoomtype() {
        return roomtype;
    }

    public void setRoomtype(String roomtype) {
        this.roomtype = roomtype;
    }

    public String getOpendateshopping() {
        return opendateshopping;
    }

    public void setOpendateshopping(String opendateshopping) {
        this.opendateshopping = opendateshopping;
    }

    public String getOpentime() {
        return opentime;
    }

    public void setOpentime(String opentime) {
        this.opentime = opentime;
    }

    public String getSaleitem() {
        return saleitem;
    }

    public void setSaleitem(String saleitem) {
        this.saleitem = saleitem;
    }

    public String getCheckintime() {
        return checkintime;
    }

    public void setCheckintime(String checkintime) {
        this.checkintime = checkintime;
    }

    public String getCheckouttime() {
        return checkouttime;
    }

    public void setCheckouttime(String checkouttime) {
        this.checkouttime = checkouttime;
    }

    public String getChkcooking() {
        return chkcooking;
    }

    public void setChkcooking(String chkcooking) {
        this.chkcooking = chkcooking;
    }

    public String getRoomcount() {
        return roomcount;
    }

    public void setRoomcount(String roomcount) {
        this.roomcount = roomcount;
    }

    public String getSubfacility() {
        return subfacility;
    }

    public void setSubfacility(String subfacility) {
        this.subfacility = subfacility;
    }

    public String getUsefeeleports() {
        return usefeeleports;
    }

    public void setUsefeeleports(String usefeeleports) {
        this.usefeeleports = usefeeleports;
    }

    public String getOpenperiod() {
        return openperiod;
    }

    public void setOpenperiod(String openperiod) {
        this.openperiod = openperiod;
    }

    public String getParkingfeeleports() {
        return parkingfeeleports;
    }

    public void setParkingfeeleports(String parkingfeeleports) {
        this.parkingfeeleports = parkingfeeleports;
    }

    public String getParkingleports() {
        return parkingleports;
    }

    public void setParkingleports(String parkingleports) {
        this.parkingleports = parkingleports;
    }

    public String getReservation() {
        return reservation;
    }

    public void setReservation(String reservation) {
        this.reservation = reservation;
    }


    public String getSpendtime() {
        return spendtime;
    }

    public void setSpendtime(String spendtime) {
        this.spendtime = spendtime;
    }

    public String getAgelimit() {
        return agelimit;
    }

    public void setAgelimit(String agelimit) {
        this.agelimit = agelimit;
    }

    public String getBookingplace() {
        return bookingplace;
    }

    public void setBookingplace(String bookingplace) {
        this.bookingplace = bookingplace;
    }

    public String getEventhomepage() {
        return eventhomepage;
    }

    public void setEventhomepage(String eventhomepage) {
        this.eventhomepage = eventhomepage;
    }

    public String getEventplace() {
        return eventplace;
    }

    public void setEventplace(String eventplace) {
        this.eventplace = eventplace;
    }

    public String getPlaytime() {
        return playtime;
    }

    public void setPlaytime(String playtime) {
        this.playtime = playtime;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public String getSponsor1() {
        return sponsor1;
    }

    public void setSponsor1(String sponsor1) {
        this.sponsor1 = sponsor1;
    }

    public String getSponsor1tel() {
        return sponsor1tel;
    }

    public void setSponsor1tel(String sponsor1tel) {
        this.sponsor1tel = sponsor1tel;
    }

    public String getUsetimefestival() {
        return usetimefestival;
    }

    public void setUsetimefestival(String usetimefestival) {
        this.usetimefestival = usetimefestival;
    }

    public String getChkpetculture() {
        return chkpetculture;
    }

    public void setChkpetculture(String chkpetculture) {
        this.chkpetculture = chkpetculture;
    }

    public String getParkingfee() {
        return parkingfee;
    }

    public void setParkingfee(String parkingfee) {
        this.parkingfee = parkingfee;
    }

    public String getScale() {
        return scale;
    }

    public void setScale(String scale) {
        this.scale = scale;
    }

    public String getUsetimeculture() {
        return usetimeculture;
    }

    public void setUsetimeculture(String usetimeculture) {
        this.usetimeculture = usetimeculture;
    }

    public String getAccomcount() {
        return accomcount;
    }

    public void setAccomcount(String accomcount) {
        this.accomcount = accomcount;
    }

    public String getChkbabycarriage() {
        return chkbabycarriage;
    }

    public void setChkbabycarriage(String chkbabycarriage) {
        this.chkbabycarriage = chkbabycarriage;
    }

    public String getChkpet() {
        return chkpet;
    }

    public void setChkpet(String chkpet) {
        this.chkpet = chkpet;
    }

    public String getExpagerange() {
        return expagerange;
    }

    public void setExpagerange(String expagerange) {
        this.expagerange = expagerange;
    }

    public String getExpguide() {
        return expguide;
    }

    public void setExpguide(String expguide) {
        this.expguide = expguide;
    }

    public String getOpendate() {
        return opendate;
    }

    public void setOpendate(String opendate) {
        this.opendate = opendate;
    }

    public String getSidoname() {
        return sidoname;
    }

    public void setSidoname(String sidoname) {
        this.sidoname = sidoname;
    }

    public String getDistance() {
        return distance;
    }

    public void setDistance(String distance) {
        this.distance = distance;
    }

    public String getSchedule() {
        return schedule;
    }

    public void setSchedule(String schedule) {
        this.schedule = schedule;
    }

    public String getTheme() {
        return theme;
    }

    public void setTheme(String theme) {
        this.theme = theme;
    }

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