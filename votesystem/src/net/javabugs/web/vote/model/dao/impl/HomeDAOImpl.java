package net.javabugs.web.example.model.dao.impl;

import java.util.List;

import net.javabugs.web.example.model.dao.HomeDAO;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class HomeDAOImpl extends SqlSessionDaoSupport implements HomeDAO {

	@Override
	public JoinParam getUserInformation(String id) {
		return (JoinParam) getSqlSession().
				selectOne("net.javabugs.web.example.model.mapper.Join.getUserInformation",id);
	}

	@Override
	public int updateUserInformation(JoinParam joinParam) {//여기서 학과이름을 코드로 수정
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Join.updateUserInformation", joinParam);
	}

	@Override
	public List<Post> getPostList(PostParam postParam) {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Join.getPostList", postParam);
	}

	@Override
	public List<Post> getHomeList(Post post) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Join.getHomeList", post);
	}

	@Override
	public JoinParam checkUserInformation(JoinParam joinParam) {
		return (JoinParam) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Join.checkUserInformation", joinParam);

	}

}
