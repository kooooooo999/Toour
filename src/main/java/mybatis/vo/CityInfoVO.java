package mybatis.vo;

public class CityInfoVO {
    private String title, addr1, firstimage;

    public CityInfoVO(String title, String firstimage, String addr1) {
        this.addr1 = addr1;
        this.firstimage = firstimage;
        this.title = title;
    }

    public String getFirstimage() {
        return firstimage;
    }

    public void setFirstimage(String firstimage) {
        this.firstimage = firstimage;
    }

    public String getAddr1() {
        return addr1;
    }

    public void setAddr1(String addr1) {
        this.addr1 = addr1;
    }


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
