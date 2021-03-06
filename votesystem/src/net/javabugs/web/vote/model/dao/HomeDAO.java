package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;
import net.sf.json.JSONObject;

public interface HomeDAO {

	public JoinParam getUserInformation(String id);

	public int updateUserInformation(JoinParam joinParam);

	public List<Post> getPostList(PostParam postParam);

	public List<Post> getHomeList(Post post);

	public JoinParam checkUserInformation(JoinParam joinParam);
}
