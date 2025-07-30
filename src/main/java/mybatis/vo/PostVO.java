package mybatis.vo;

import java.util.List;

public class PostVO {
    private String post_idx, member_idx, category_idx, post_title, post_content, post_views, post_likes, post_comments_count,  post_status, post_created_at, post_updated_at, post_star;

    private List<CommentVO> c_list;

    public List<CommentVO> getC_list() {
        return c_list;
    }

    private List<FileVO> f_list;

    public List<FileVO> getF_list() {
        return f_list;
    }

    public void setF_list(List<FileVO> f_list) {
        this.f_list = f_list;
    }

    public void setC_list(List<CommentVO> c_list) {
        this.c_list = c_list;
    }

    public String getCategory_idx() {return category_idx;}

    public void setCategory_idx(String category_idx) {this.category_idx = category_idx;}

    public String getMember_idx() {return member_idx;}

    public void setMember_idx(String member_idx) {this.member_idx = member_idx;}

    public String getPost_comments_count() {return post_comments_count;}

    public void setPost_comments_count(String post_comments_count) {this.post_comments_count = post_comments_count;}

    public String getPost_content() {return post_content;}

    public void setPost_content(String post_content) {this.post_content = post_content;}

    public String getPost_created_at() {return post_created_at;}

    public void setPost_created_at(String post_created_at) {this.post_created_at = post_created_at;}

    public String getPost_idx() {return post_idx;}

    public void setPost_idx(String post_idx) {this.post_idx = post_idx;}



    public String getPost_likes() {return post_likes;}

    public void setPost_likes(String post_likes) {this.post_likes = post_likes;}

    public String getPost_star() {return post_star;}

    public void setPost_star(String post_star) {this.post_star = post_star;}

    public String getPost_status() {return post_status;}

    public void setPost_status(String post_status) {this.post_status = post_status;}

    public String getPost_title() {return post_title;}

    public void setPost_title(String post_title) {this.post_title = post_title;}

    public String getPost_updated_at() {return post_updated_at;}

    public void setPost_updated_at(String post_updated_at) {this.post_updated_at = post_updated_at;}

    public String getPost_views() {return post_views;}

    public void setPost_views(String post_views) {this.post_views = post_views;}


}
