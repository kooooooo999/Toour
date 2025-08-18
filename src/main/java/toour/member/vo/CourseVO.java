package toour.member.vo;

public class CourseVO {
    private String course_idx, member_idx, course_name, created_at, updated_at, course_summary;

//    CourseInVO[] courseIn_list;


    public String getCourse_summary() {
        return course_summary;
    }

    public void setCourse_summary(String course_summary) {
        this.course_summary = course_summary;
    }

    public String getCourse_idx() {
        return course_idx;
    }

    public void setCourse_idx(String course_idx) {
        this.course_idx = course_idx;
    }

    public String getMember_idx() {
        return member_idx;
    }

    public void setMember_idx(String member_idx) {
        this.member_idx = member_idx;
    }

    public String getCourse_name() {
        return course_name;
    }

    public void setCourse_name(String course_name) {
        this.course_name = course_name;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }

}
