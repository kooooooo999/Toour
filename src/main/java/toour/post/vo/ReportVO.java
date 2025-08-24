package toour.post.vo;

public class ReportVO {
    private String report_idx, reporter_idx, reported_idx, post_idx, report_content, report_created_at, target_type, report_status;

    private String reporter_nickname;
    private String reported_nickname;

    public String getComment_idx() {
        return comment_idx;
    }

    public void setComment_idx(String comment_idx) {
        this.comment_idx = comment_idx;
    }

    private String comment_idx;

    public String getReporter_nickname() {
        return reporter_nickname;
    }

    public void setReporter_nickname(String reporter_nickname) {
        this.reporter_nickname = reporter_nickname;
    }

    public String getReported_nickname() {
        return reported_nickname;
    }

    public void setReported_nickname(String reported_nickname) {
        this.reported_nickname = reported_nickname;
    }

    public String getReport_idx() {
        return report_idx;
    }

    public void setReport_idx(String report_idx) {
        this.report_idx = report_idx;
    }
    //신고한 사람
    public String getReporter_idx() {
        return reporter_idx;
    }

    public void setReporter_idx(String reporter_idx) {
        this.reporter_idx = reporter_idx;
    }
    //신고당한 사람
    public String getReported_idx() {
        return reported_idx;
    }

    public void setReported_idx(String reported_idx) {
        this.reported_idx = reported_idx;
    }

    public String getPost_idx() {
        return post_idx;
    }

    public void setPost_idx(String post_idx) {
        this.post_idx = post_idx;
    }

    public String getReport_content() {
        return report_content;
    }

    public void setReport_content(String report_content) {
        this.report_content = report_content;
    }

    public String getReport_created_at() {
        return report_created_at;
    }

    public void setReport_created_at(String report_created_at) {
        this.report_created_at = report_created_at;
    }

    public String getTarget_type() {
        return target_type;
    }

    public void setTarget_type(String target_type) {
        this.target_type = target_type;
    }

    public String getReport_status() {
        return report_status;
    }

    public void setReport_status(String report_status) {
        this.report_status = report_status;
    }
}
