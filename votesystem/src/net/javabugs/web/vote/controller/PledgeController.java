package net.javabugs.web.example.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.dto.JavabugsUser;
import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.ElectedPledge;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;
import net.javabugs.web.example.service.PledgeService;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
@RequestMapping("/pledge")
public class PledgeController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PledgeService pledgeService;

	@RequestMapping("/pledgelist")
	public String list(HttpServletRequest request){
//		HttpSession session = request.getSession();
//		
//		SecurityContextImpl obj = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
//		obj.getAuthentication().getPrincipal();
		
		return "admin/pledgelist";
	}
	

	
	@RequestMapping("/pledgesearch")
	public @ResponseBody JSONObject search(PledgeParam plegeParam){
		JSONObject json = pledgeService.getPlegeList(plegeParam);
		return json;
	}
	
	@RequestMapping("/pledgecheck")
	public ModelAndView pledgecheck(ModelAndView mav){
		int pledgeCnt = pledgeService.getCountElectedPledgeList();
		//mav.addObject("pledgeList", pledgeList); //List도 어짜피 Object의 자식
		mav.addObject("pledgeCnt", pledgeCnt);
		mav.setViewName("/pledgecheck");
		return mav;
	}
	//등록
	@RequestMapping(value="/pledgedetail", method=RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, @Valid PledgeParam pledgeParam, BindingResult bindingResult) throws IOException {
	//	logger.debug("[CandiController.insert] method called" );
		if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO(); //여기부터 끝까지 실행. 우리는 ResultVO로 바꿔줄 것이다.
			rvo.put("error",bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString());
		}else{
			int result = pledgeService.insertPledge(pledgeParam);
			mav.addObject("crtCnt",result);
		}
		
		mav.addObject("pledgeParam", pledgeParam);
		mav.setViewName("/admin/pledgeconfirm");
		return mav;
	}
	
	@RequestMapping(value="/pledgedetail/{pledge_id}/{cand_id}",method=RequestMethod.GET)
	public ModelAndView detail(ModelAndView mav,PledgeParam pledgeParam){
		Pledge pledge = pledgeService.getPledge(pledgeParam);
		mav.addObject("pledge",pledge);
		mav.setViewName("/admin/pledgedetail");
		return mav;
	}
	
	@RequestMapping(value="/pledgedetail/{pledge_id}/{cand_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(PledgeParam pledgeParam){
		logger.debug("[CandiController.delete] method called" );
		int result = pledgeService.deletePledge(pledgeParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt", result);
		
		return resultVO;
	}
	@RequestMapping(value="/checkValidation", method=RequestMethod.GET)
	public @ResponseBody ResultVO checkValidation(PledgeParam param) {
		ResultVO result = pledgeService.checkValidation(param);
		return result;
	}
	
	//수정
	@RequestMapping(value= "/pledgedetail/", method= RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid PledgeParam pledgeParam, BindingResult bindingResult ){
		logger.debug("[CandiController.update] method called" );
		int result = pledgeService.updatePledge(pledgeParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		
		return resultVO;
	}
	
	//등록  http://localhost:8080/sample/candi/candiconfirm/new
	@RequestMapping(value="/pledgeconfirm/{pledge_id}/{cand_id}", method= RequestMethod.GET)
	public ModelAndView pledgeconfirm(ModelAndView mav, PledgeParam pledgeParam){
		logger.debug("[CandiController.form] method called" );
		if(!"new".equals(pledgeParam.getPledge_id())){
			Pledge pledge = pledgeService.getPledge(pledgeParam);
			mav.addObject("pledge", pledge);
		}
		
		mav.setViewName("/admin/pledgeconfirm");
		return mav;		
	}

	@RequestMapping("/pledgechecklist")
	public @ResponseBody JSONObject pledgeCheckList(ElectedPledge electedPledge){
		JSONObject json = new JSONObject();
		List<ElectedPledge> electedPledgeList = pledgeService.getPledgeCheckList(electedPledge);
		json.accumulate("electedPledgeList", electedPledgeList);
		
		return json;
	}
	@RequestMapping(value="/getelectedpledge")
	public ModelAndView electedPledgeModify(ModelAndView mav, String pledge_id){
		logger.debug(pledge_id);
		ElectedPledge pledge = pledgeService.getElectedPledge(pledge_id);
		
		mav.addObject("pledge", pledge);
		mav.setViewName("/admin/electedpledgemodify");
		return mav;
	}
	@RequestMapping(value= "/pledgechecklist", method= RequestMethod.POST)
	public @ResponseBody ResultVO updateElctedPledge(ElectedPledge electedPledge, BindingResult bindingResult ){
		
		JavabugsUser user = (JavabugsUser)SecurityContextHolder.getContext()
				.getAuthentication().getPrincipal();
		String user_id = user.getUsername();
		electedPledge.setUpd_id(user_id);
		int result = pledgeService.updateElectedPledge(electedPledge);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		
		return resultVO;
	}
}
