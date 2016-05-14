package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.Comment;
import net.javabugs.web.example.model.dto.CommentParam;

public interface CommentDAO {
//	public Comment getComment(CommentParam commentParam);
	
	public List<Comment> getCommentList(CommentParam commentParam);
	
	public int deleteCommentByNum_bid(String num_bid);

	public int deleteComment(String cmt_num);
	
	public int updateComment(Comment comment);

	public int insertComment(Comment comment);
}
