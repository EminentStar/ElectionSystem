package net.javabugs.web.example.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.dto.JavabugsUser;
import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;
import net.javabugs.web.example.service.BbsService;
import net.javabugs.web.example.service.HomeService;
import net.javabugs.web.example.service.JoinService;
import net.javabugs.web.example.service.VoteService;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/home")
public class HomeController {
	

	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(this.getClass());

	@Autowired
	private HomeService homeService;
	
	@Autowired
	private BbsService bbsService;
	
	@Autowired
	private VoteService voteService;
	
	
	@Autowired
	private JoinService joinService;

	@RequestMapping("/main")
	public String home(){
		
		return "home";
	}
	
	@RequestMapping("/recheck")
	public String recheck(){
	
		return "/recheck";		
	}	

	
	@RequestMapping(value="/usermodify", method=RequestMethod.GET)//회원정보 수정
	public ModelAndView userModify(ModelAndView mav, HttpServletRequest request){
		//현재 로그인되어있는 회원의 정보를 받아와서 수정할 수 있게 usermodify.jsp에 넘긴다.
		logger.debug("[HomeController.userModify] method called");
		// 줬다고 가정하고 세션을 뽑자
//		HttpSession session = request.getSession();
//		// 세션의 어트리뷰트를 탐색하자!!!
//		// session.getAttribute(arg0) 키값을 알고있으면 그걸 돌려줄께? 란의미
//		Enumeration<String> ans = session.getAttributeNames();
//		
//		/// SPRING_SECURITY_CONTEXT 이거 나왔죠? 그럼 우린 이걸통해 값을 뺄수있다! 값을뺴보자!
//		SecurityContextImpl obj = (SecurityContextImpl) session
//				.getAttribute("SPRING_SECURITY_CONTEXT");
//		obj.getAuthentication().getPrincipal();

		JavabugsUser user = (JavabugsUser)SecurityContextHolder.getContext()
		.getAuthentication().getPrincipal();
		// 이게 여러분들의 유저를 돌려준다!!
		System.out.println(user.getUsername());

		String id = user.getUsername();
		//-------------------------
		JoinParam joinParam = homeService.getUserInformation(id);
		mav.addObject("user",joinParam);
		mav.setViewName("/user/usermodify");
		return mav;
	}

	@RequestMapping(value="/usermodify", method = RequestMethod.POST)
	public @ResponseBody ResultVO updateModify(@Valid JoinParam joinParam,BindingResult bindingResult){
		int result = homeService.updateUserInformation(joinParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		return resultVO;
	}
	
	@RequestMapping(value="/usercheck", method = RequestMethod.POST)
	public @ResponseBody ResultVO userCheck(@Valid JoinParam joinParam,BindingResult bindingResult){
		int result = homeService.checkUserInformation(joinParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		return resultVO;
	}
	
	@RequestMapping("/homemodify")
	public @ResponseBody ModelAndView homemodify(ModelAndView mav){
		int term = voteService.checkVoteTerm();
		mav.addObject("term",term);
		mav.setViewName("/homemodify");
		return mav;
	}
	
	@RequestMapping("/homesearch")
	public @ResponseBody JSONObject homesearch(Post post) {
//		List<Post> postList = bbsService.getPostList(postParam);
//		searchCondition과 searchText도 그대로 정의 되어야한다 ? PostParam안에다 선언?
		
		JSONObject json = homeService.getHomeList(post);

		return json;
	}
	@RequestMapping("/delete")
	public @ResponseBody JSONObject delete(PostParam postParam) {
//		List<Post> postList = bbsService.getPostList(postParam);
//		searchCondition과 searchText도 그대로 정의 되어야한다 ? PostParam안에다 선언?
		
		int result = bbsService.deleteHome(postParam);

		JSONObject json = new JSONObject();
		json.put("delCnt", result);

		return json;
	}
	
	@RequestMapping(value="/searchlist/{bbs_type}", method= RequestMethod.GET)
	public @ResponseBody JSONObject searchlist(PostParam postParam) {
//		List<Post> postList = bbsService.getPostList(postParam);
//		searchCondition과 searchText도 그대로 정의 되어야한다 ? PostParam안에다 선언?
		JSONObject json = homeService.getPostList(postParam);

		return json;
	}
	@RequestMapping(value = "/detail", method = RequestMethod.POST)
	public @ResponseBody ModelAndView insert(ModelAndView mav,@Valid PostParam postParam,BindingResult bindingResult) throws IOException {
		//logger.debug("[BbsController.insert] method called");
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
		mav.setViewName("/homemodify");
			return mav;
	}

	
}
