package net.javabugs.web.example.model.dao.impl;

import java.util.List;

import net.javabugs.web.example.model.dao.CommentDAO;
import net.javabugs.web.example.model.dto.Comment;
import net.javabugs.web.example.model.dto.CommentParam;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;


@Repository //DAOImple에는 꼭 붙여야한다! 안그러면 오토와이어드 할때 실패한다!!
public class CommentDAOImpl extends SqlSessionDaoSupport implements CommentDAO {
		//  net.javabugs.web.example.model.mapper.Comment
	@SuppressWarnings("unchecked")
	@Override
	public List<Comment> getCommentList(CommentParam commentParam) {
		return getSqlSession().selectList(
				"net.javabugs.web.example.model.mapper.Comment.getCommentList",
				commentParam);
	}

	@Override
	public int deleteComment(String cmt_num) {
		return getSqlSession().delete(
				"net.javabugs.web.example.model.mapper.Comment.deleteComment",
				cmt_num);
	}

	@Override
	public int updateComment(Comment comment) {
		return getSqlSession().update(
				"net.javabugs.web.example.model.mapper.Comment.updateComment",
				comment);
	}

	@Override
	public int insertComment(Comment comment) {
		 return getSqlSession().insert(
				 "net.javabugs.web.example.model.mapper.Comment.insertComment",
		comment);
	}

	@Override
	public int deleteCommentByNum_bid(String num_bid) {
		return getSqlSession().delete(
				"net.javabugs.web.example.model.mapper.Comment.deleteCommentByNum_bid",
				num_bid);
	}

}
