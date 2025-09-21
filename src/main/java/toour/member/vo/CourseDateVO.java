package toour.member.vo;

public class CourseDateVO {
    private String courseDate_idx, date, date_title, course_idx;

    CourseInVO[] courseIn_list;

    public String getCourseDate_idx() {
        return courseDate_idx;
    }

    public void setCourseDate_idx(String courseDate_idx) {
        this.courseDate_idx = courseDate_idx;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDate_title() {
        return date_title;
    }

    public void setDate_title(String date_title) {
        this.date_title = date_title;
    }

    public String getCourse_idx() {
        return course_idx;
    }

    public void setCourse_idx(String course_idx) {
        this.course_idx = course_idx;
    }

    public CourseInVO[] getCourseIn_list() {
        return courseIn_list;
    }

    public void setCourseIn_list(CourseInVO[] courseIn_list) {
        this.courseIn_list = courseIn_list;
    }
}
