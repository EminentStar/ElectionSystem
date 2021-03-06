package net.javabugs.web.example.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;
import net.javabugs.web.example.service.BbsService;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

//import com.bbs.PJK.model.dao.BbsDAO;
//import com.bbs.PJK.model.dto.Post;
@Controller
@RequestMapping("/bbs")
public class BbsController {// �̰� MVC�� C( �帧�� ���Ѵ�!) ������ ������ M����
							// ���Ѵ�! M�� �������Ѵ� (dao dto)

	Logger logger = Logger.getLogger(this.getClass());
// private BbsDAO bbsDao;
//
// public BbsController(){
// bbsDao = new BbsDAO();
// }
	@Autowired
	private BbsService bbsService;

	@RequestMapping("/list/{boardType}")
	public String list(HttpServletRequest request,@PathVariable("boardType") int boardType) {
		logger.debug("[BbsController.list] method called");//이러면 콘솔창에 똑같이 찍힌다!
		logger.debug(boardType);//이러면 콘솔창에 똑같이 찍힌다!
		
		// 줬다고 가정하고 세션을 뽑자
//		HttpSession session = request.getSession();
		// 세션의 어트리뷰트를 탐색하자!!!
		// session.getAttribute(arg0) 키값을 알고있으면 그걸 돌려줄께? 란의미
		//Enumeration<String> ans = session.getAttributeNames(); //안씀
		
		/// SPRING_SECURITY_CONTEXT 이거 나왔죠? 그럼 우린 이걸통해 값을 뺄수있다! 값을뺴보자!
//		SecurityContextImpl obj = (SecurityContextImpl) session
//				.getAttribute("SPRING_SECURITY_CONTEXT");
	
//		obj.getAuthentication().getPrincipal();   // jsp에서 값들을 보여주지못하기에 일단 여기서 세션넘어오는걸 보여준다했던것임 지워도되는것임  
		
		if(boardType==1){
			return "bbs/list/notice";
		}else if(boardType==2){
			return "bbs/list/qna";
		}else if(boardType==3){
			return "bbs/list/studentunion";
		}else{
			return "bbs/list/editstudentunion";
		}
		
		//String list = "bbs/list/" + boardType;
		//return list;
		// list과감하게 삭제하고!(기존의 것들)
		// JavabugsUser user = (JavabugsUser)SecurityContextHolder.getContext()
		// .getAuthentication().getPrincipal();
		// 이게 여러분들의 유저를 돌려준다!!
		
		// System.out.println(user.toString());//저위에 세션의요소 찍었을때랑 뭐가틀린지도 봐보세요
		// 그럼 세션으로 동일하게 뺴고 싶으면 어떻게 빼야될까요?
		// 지금 결과를 가지고 user클래스 를 얻어보자!!
		
		// System.out.println(user.getName());
		// System.out.println(user.getAuthorities());
		// System.out.println(user.getUsername());
		// System.out.println(user.getRole());
		// System.out.println(user.getClass());
		// System.out.println(user.getSerialversionuid());
		// System.out.println(user.getCellPhone());
		
		/*
		 * for(String str : user.getRole()){ System.out.println(str); }
		 * //ROLE_USER 이렇게 찍힘! 결국 getRole과 getAuthorities는 같은거다!
		 */
		// 그후 빼서쓰면된다 일단 뭐가나오는지보자!
	}

	// search도 리퀘스트매핑 먼저 붙입니다.
	// 파라미터도 안쓸꺼니깐 지우자 쓰긴쓸껀데 저런거 안쓸꺼임
	@RequestMapping("/search/{bbs_type}")
	public @ResponseBody JSONObject search(PostParam postParam) {
//		List<Post> postList = bbsService.getPostList(postParam);
		// searchCondition과 searchText도 그대로 정의 되어야한다 ? PostParam안에다 선언?
		JSONObject json = bbsService.getPostList(postParam);

		return json;
	}

	@RequestMapping(value = "/detail/{num_bid}", method = RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav, PostParam postParam) { // ModelAndView
																		// 설명 했음
																		// 혼자
																		// 공부하기

		Post post = bbsService.getPost(postParam);
		mav.addObject("post", post);
		mav.setViewName("/bbs/detail");

		return mav;
	}

	// 삭제메서드 추가 url은 detail과 같은데 하나는 get 하나는 delete!!!
	@RequestMapping(value = "/detail/{num_bid}", method = RequestMethod.DELETE)
	public @ResponseBody
	ResultVO delete(PostParam postParam) {
		int result = bbsService.deletePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt", result);

		return resultVO;
	}

	@RequestMapping(value = "/detail", method = RequestMethod.PUT)
	public @ResponseBody
	ResultVO update(@Valid PostParam postParam, BindingResult bindingResult) {
		int result = bbsService.updatePost(postParam);// 데이터를 조회해오는데 상세와 똑같이;
		String bbstype = postParam.getBbs_type();
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		resultVO.put("postParam", bbstype);

		return resultVO;
	}

	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public @ResponseBody ModelAndView insert(ModelAndView mav,@Valid PostParam postParam,BindingResult bindingResult) throws IOException {
		logger.debug("[BbsController.insert] method called");
		if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO();
			rvo.put("error",bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString()); //이상태가되면 crtcnt가안넘어가는거죠!
		}else{
			int result = bbsService.insertPost(postParam);
			mav.addObject("crtCnt",result);
		}
		
//		int result = bbsService.insertPost(postParam); // 데이터를 조회해오는데 상세와 똑같이;
//		ResultVO resultVO = new ResultVO();
//		mav.addObject("crtCnt", result);
		mav.addObject("postParam", postParam);
		mav.setViewName("/bbs/form");
			return mav;
	}

	@RequestMapping("/form/{num_bid}/{bbs_type}")//이렇게 url이 추가로붙은경우 {}안에 매개변수의 이름과 같게하면 들어가는듯??
	public ModelAndView form(PostParam postParam, ModelAndView mav, HttpServletRequest request) {
		
		if (!"new".equals(postParam.getNum_bid())) {
			Post post = bbsService.getPost(postParam); // 데이터를 조회해오는데 상세와 똑같이;
			mav.addObject("post", post);
			//mav.setViewName("/bbs/form");
		}else{
			//String bbs_type=postParam.getBbs_type();
			mav.addObject("post1",postParam);
		}
		logger.debug(request.getParameter("bbs_type"));
		mav.setViewName("/bbs/form"); // 불러오는 jsp만다르나?
		return mav;
	}
}
