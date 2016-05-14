package net.javabugs.web.example.model.dao;

import java.util.List;
import java.util.Map;

import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;

public interface BbsDAO {
	public List<Post> getPostList(PostParam param);
	
	public Post getPost(PostParam param);

	public int deletePost(PostParam postParam);

	public int updatePost(PostParam postParam);

	public int insertPost(Post post);

	public int insertAttachFile(Post post);

	public int getCountPostList(PostParam param);

}
