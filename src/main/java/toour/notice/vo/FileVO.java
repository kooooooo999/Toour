package toour.notice.vo;

public class FileVO {
    private String file_idx, post_idx, file_name_original, file_name_stored, file_s3_url, file_size, file_type, uploaded_at;

    public String getFile_idx() {
        return file_idx;
    }

    public void setFile_idx(String file_idx) {
        this.file_idx = file_idx;
    }

    public String getPost_idx() {
        return post_idx;
    }

    public void setPost_idx(String post_idx) {
        this.post_idx = post_idx;
    }

    public String getFile_name_original() {
        return file_name_original;
    }

    public void setFile_name_original(String file_name_original) {
        this.file_name_original = file_name_original;
    }

    public String getFile_name_stored() {
        return file_name_stored;
    }

    public void setFile_name_stored(String file_name_stored) {
        this.file_name_stored = file_name_stored;
    }

    public String getFile_s3_url() {
        return file_s3_url;
    }

    public void setFile_s3_url(String file_s3_url) {
        this.file_s3_url = file_s3_url;
    }

    public String getFile_size() {
        return file_size;
    }

    public void setFile_size(String file_size) {
        this.file_size = file_size;
    }

    public String getFile_type() {
        return file_type;
    }

    public void setFile_type(String file_type) {
        this.file_type = file_type;
    }

    public String getUploaded_at() {
        return uploaded_at;
    }

    public void setUploaded_at(String uploaded_at) {
        this.uploaded_at = uploaded_at;
    }
}
