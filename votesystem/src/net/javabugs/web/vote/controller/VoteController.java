package net.javabugs.web.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.Check;
import net.javabugs.web.example.model.dto.CheckParam;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Vote;
import net.javabugs.web.example.model.dto.VoteParam;
import net.javabugs.web.example.service.CandiService;
import net.javabugs.web.example.service.VoteService;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/vote")
public class VoteController extends Check{
	
	Check check = new Check();
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private VoteService voteService;
	@Autowired
	private CandiService candiService;
	
	@RequestMapping("/votelist")
	public String votelist(HttpServletRequest request, VoteParam voteParam){
		if(voteParam.getCrtId().equals("anonymousUser")){
			return "/login";
		}
		int result = voteService.checkValidation(voteParam);		
		if(result==0){
//		HttpSession session = request.getSession();
//		
//		//Enumeration<String> ans = session.getAttributeNames();
//		
//		SecurityContextImpl obj =(SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
//		obj.getAuthentication().getPrincipal();
		return "/vote";
		
		}else{
			return "/alreadyvote";
		}
	}//	
	
	
	
	@RequestMapping("/voteresultlist")
	public String voteresultlist(HttpServletRequest request){
		/*
		HttpSession session = request.getSession();
		
		SecurityContextImpl obj2= (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj2.getAuthentication().getPrincipal();*/
		
		return "/voteresult";
		
		
	}
	@RequestMapping("/homecheck")
	public @ResponseBody int homecheck(CheckParam checkParam){
		 
		int result = voteService.updateTermCheck(checkParam);
		return result;
		//int json = voteService.getTermCheck(checkParam);
		/*JSONObject json = new JSONObject();
		if(checkParam.checkname.equals("투표기간 활성화")){
			check.setVotecheck(1);
			check.setDefaultcheck(0);
			check.setElectedcheck(0);
			json.put("votecheck", check.getVotecheck());
			return json;
		}else if(checkParam.checkname.equals("당선자공지기간 활성화")){
			check.setVotecheck(0);
			check.setDefaultcheck(0);
			check.setElectedcheck(1);
			json.put("electedcheck", check.getElectedcheck());
			return json;
		}else{
			check.setVotecheck(0);
			check.setDefaultcheck(1);
			check.setElectedcheck(0);
			json.put("defaultcheck", check.getDefaultcheck());
			return json;
		}*/
	}
	@RequestMapping("/votecheck")
	public String votechekc(HttpServletRequest request){
		return "voteerror";
	}
	
	
	@RequestMapping("/votecollegerate")
	public @ResponseBody JSONObject votecollegerate(VoteParam voteParam){
		JSONObject result = voteService.getVoteCollegeRate(voteParam);
		return result;
	}
	
	@RequestMapping("/votecandirate")
	public @ResponseBody ResultVO votecandirate(VoteParam voteParam){
		ResultVO result = voteService.getVoteCandiRate(voteParam);
		return result;
	}
	
	
	@RequestMapping("/votesearch")
	public @ResponseBody JSONObject search(CandiParam candiParam){
		logger.debug("[VoteController.votesearch] method called");
		
		JSONObject json = voteService.getCandiList(candiParam);
		
		return json;
	}
	
	@RequestMapping("/dovote")
	public @ResponseBody ResultVO dovote(@Valid VoteParam vote, BindingResult bindingResult){
		ResultVO result=null;
		if(bindingResult.hasErrors()){
			result = new ResultVO();
			result.put("error", bindingResult.getAllErrors());
		}else{
			result=voteService.vote(vote);
		}
		
		return result;
	}
	/*@RequestMapping(value="/checkValidation", method=RequestMethod.GET)
	public @ResponseBody ResultVO checkValidation(VoteParam voteParam) {
		ResultVO result = voteService.checkValidation(voteParam);
		return result;
	}*/
	
	@RequestMapping(value="/voterate",method=RequestMethod.GET)
	public ModelAndView voterate(ModelAndView mav, VoteParam voteParam){
		Vote vote = voteService.getVoteRate(voteParam);
		mav.addObject("vote",vote);
		mav.setViewName("/voterate");
		return mav;
		
	}
	
	
	@RequestMapping("/votetotalrate")
	public @ResponseBody JSONObject votetotalrate(VoteParam voteParam){
		JSONObject result = voteService.getVoteTotalRate(voteParam);
		return result;
	}
	@RequestMapping("/electedresult")
	public @ResponseBody JSONObject electedresult(VoteParam voteParam){
		JSONObject result = voteService.getElectedResult(voteParam);
		return result;
	}

}
