package net.javabugs.web.example.controller;

import java.util.List;

import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.Comment;
import net.javabugs.web.example.model.dto.CommentParam;
import net.javabugs.web.example.service.CommentService;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

//컨트롤러니깐 컨트롤러와 리퀘스트매핑 어노테이션 필요
@Controller
@RequestMapping("/cmt")
public class CommentController {

	Logger logger = Logger.getLogger(getClass());
	@Autowired//그리고 서비스를 불러와야하니 오토와이어드 하자
	private CommentService commentService;
	
	//그럼 이제 각ㅇurl을 정의 하고 @#$@#$하져
	
	//조회 기능	/comment/{num_bid}	, GET 메소드
	@RequestMapping(value = "/comment/{num_bid}", method = RequestMethod.GET)
	public @ResponseBody ResultVO list(CommentParam commentParam){
		return commentService.getCommentList(commentParam);
//		ResultVO result = new ResultVO();
//		result.put("commentList", list); //이러한작업을 서비스에게 맡기자?  
		
	}
	
	//삭제 기능	/comment/{cmtNum} , DELETE 메소드
	@RequestMapping(value = "/comment/{cmt_num}", method = RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(@PathVariable String cmt_num){
		return commentService.deleteComment(cmt_num);
		
	}
	

	//등록 기능	/comment , POST 메소드
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public @ResponseBody ResultVO insert(@Valid CommentParam commentParam, BindingResult bindingResult){
		if(bindingResult.hasErrors()){
			ResultVO resultVO = new ResultVO();
			resultVO.put("error",bindingResult.getFieldError());
			return resultVO;
		}else{
			ResultVO resultVO = commentService.insertComment(commentParam);
//			logger.debug(resultVO.get("crtCnt"));
//			if(resultVO.get("crtCnt").equals(1)){
//				logger.debug("조회전");
//				Object commentList = commentService.getCommentList(commentParam).get("commentList");
//				resultVO.put("commentList", commentList);
//				logger.debug(commentList);
//			}
			
			return resultVO;
		}
	}
	
	//수정 기능	/comment , PUT 메소드
	@RequestMapping(value = "/comment", method = RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid CommentParam commentParam, BindingResult bindingResult){ //바인딩리절트가있으면 꼭 @valid붙여야하죠
		if (bindingResult.hasErrors()) {
			ResultVO resultVO = new ResultVO();
			resultVO.put("error", bindingResult.getFieldErrors());
			return resultVO;
		} else {
			return commentService.updateComment(commentParam);
		}
	}
	
}
