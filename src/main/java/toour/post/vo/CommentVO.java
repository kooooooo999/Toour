package toour.post.vo;

public class CommentVO {

    private String member_nickname;

    public String getMember_nickname() {
        return member_nickname;
    }

    public void setMember_nickname(String member_nickname) {
        this.member_nickname = member_nickname;
    }

    private String comment_idx, post_idx, member_idx, comment_content, comment_created_at, comment_updated_at, comment_status;

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public String getComment_created_at() {
        return comment_created_at;
    }

    public void setComment_created_at(String comment_created_at) {
        this.comment_created_at = comment_created_at;
    }

    public String getComment_idx() {
        return comment_idx;
    }

    public void setComment_idx(String comment_idx) {
        this.comment_idx = comment_idx;
    }

    public String getComment_status() {
        return comment_status;
    }

    public void setComment_status(String comment_status) {
        this.comment_status = comment_status;
    }

    public String getComment_updated_at() {
        return comment_updated_at;
    }

    public void setComment_updated_at(String comment_updated_at) {
        this.comment_updated_at = comment_updated_at;
    }

    public String getMember_idx() {
        return member_idx;
    }

    public void setMember_idx(String member_idx) {
        this.member_idx = member_idx;
    }

    public String getPost_idx() {
        return post_idx;
    }

    public void setPost_idx(String post_idx) {
        this.post_idx = post_idx;
    }
}
