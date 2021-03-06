package net.javabugs.web.example.service;

import java.util.List;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dao.CommentDAO;
import net.javabugs.web.example.model.dto.Comment;
import net.javabugs.web.example.model.dto.CommentParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


//얘는 서비스어노태이션 붙여야되죠

@Service
public class CommentService {

	
	@Autowired
	private CommentDAO commentDAO;
	//num_bid로 삭제한느건 안하니깐 지울꼐요
	
	public ResultVO getCommentList(CommentParam commentParam){ //----------여기 느낌 좀 이상함 수정해야될듯????????????????
		
		List<Comment> list = commentDAO.getCommentList(commentParam);
		ResultVO result = new ResultVO();
		result.put("commentList", list);
		//밑의 메소드들도 마찬가지로 서비스에서 작업해주고 컨트롤러는 가급적이면 흐름만관리하도록!
//		return commentDAO.getCommentList(commentParam);
		return result;
	}

	public ResultVO deleteComment(String cmt_num){
		int cnt = commentDAO.deleteComment(cmt_num);
		ResultVO result = new ResultVO();
		result.put("delCnt", cnt);
		return result;
	}
	
	public ResultVO updateComment(CommentParam commentParam){
		Comment comment = new Comment();
		comment.setUser_id(commentParam.getUpdId());
		comment.setCmt_num(commentParam.getCmt_num());
		comment.setComments(commentParam.getComment());
		int cnt = commentDAO.updateComment(comment);
		
		ResultVO result = new ResultVO();
		result.put("updCnt",cnt);
		return result;
	}

	public ResultVO insertComment(CommentParam commentParam){
		Comment comment = new Comment();
		comment.setUser_id(commentParam.getLoginUserId());
		comment.setCrt_id(commentParam.getCrtId());
		comment.setNum_bid(commentParam.getNum_bid());
		comment.setComments(commentParam.getComment());
		int cnt = commentDAO.insertComment(comment);
		
		ResultVO result = new ResultVO();
		result.put("crtCnt",cnt);
		return result;
	}

}
