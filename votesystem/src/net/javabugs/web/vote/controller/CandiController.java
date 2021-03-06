package net.javabugs.web.example.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.PostParam;
import net.javabugs.web.example.service.CandiService;
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
@RequestMapping("/candi")
public class CandiController {
	
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private CandiService candiService;
	
	@RequestMapping("/candilist")
	public String list(HttpServletRequest request){
		logger.debug("[CandiController.candilist] method called" );
//		HttpSession session = request.getSession();
//		
//		//Enumeration<String> ans = session.getAttributeNames();
//		
//		SecurityContextImpl obj =(SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
//		obj.getAuthentication().getPrincipal();
		
		return "admin/candilist";
	}//	
	
	@RequestMapping("/candisearch")
	public @ResponseBody JSONObject search(CandiParam candiParam){
		logger.debug("[CandiController.candisearch] method called");
		JSONObject json = candiService.getCandiList(candiParam);
		
		return json;
	}

	@RequestMapping("/candidateintroduce")
	public String candidateintroduce(){
		return "candidateintroduce";
	}
	//수정,삭제

		@RequestMapping(value="/candidetail/{cand_id}", method=RequestMethod.DELETE)
		public @ResponseBody ResultVO delete(CandiParam candiParam){
			logger.debug("[CandiController.delete] method called" );
			int result = candiService.deleteCandi(candiParam);
			ResultVO resultVO = new ResultVO();
			resultVO.put("delCnt", result);
			
			return resultVO;
		}

	
	@RequestMapping(value= "/candidetail/", method= RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid CandiParam candiParam, BindingResult bindingResult ){
		logger.debug("[CandiController.update] method called" );
		int result = candiService.updateCandi(candiParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt", result);
		
		return resultVO;
	}
	
	//등록
	@RequestMapping(value="/candidetail",method=RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, @Valid CandiParam candiParam, BindingResult bindingResult) throws IOException {
		logger.debug("[CandiController.insert] method called" );
		if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO(); //여기부터 끝까지 실행. 우리는 ResultVO로 바꿔줄 것이다.
			rvo.put("error",bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString());
		}else{
			int result = candiService.insertCandi(candiParam);
			mav.addObject("crtCnt",result);
		}
		
		mav.addObject("candiParam", candiParam);
		mav.setViewName("/admin/candiconfirm");
		return mav;
	}
	
	@RequestMapping("/candidetail/{cand_id}")
	public ModelAndView detail(ModelAndView mav,CandiParam candiParam){
		Candi candi = candiService.getCandi(candiParam);
		mav.addObject("candi",candi);
		mav.setViewName("/admin/candidetail");
		return mav;
	}
	
	//등록  http://localhost:8080/sample/candi/candiconfirm/new
	@RequestMapping(value="/candiconfirm/{cand_id}", method= RequestMethod.GET)
	public ModelAndView candiconfirm(ModelAndView mav, CandiParam candiParam){
		logger.debug("[CandiController.form] method called" );
		if(!"new".equals(candiParam.getCand_id())){
			Candi candi = candiService.getCandi(candiParam);
			mav.addObject("candi", candi);
		}
		
		mav.setViewName("/admin/candiconfirm");
		return mav;		
	}
	@RequestMapping(value="/checkValidation", method=RequestMethod.GET)
	public @ResponseBody ResultVO checkValidation(CandiParam param) {
		ResultVO result = candiService.checkValidation(param);
		return result;
	}
	@RequestMapping(value="/candidateintroduce", method=RequestMethod.GET)
	public String candidateintroduce(CandiParam candiParam) {

		return "/candidateintroduce";
	}
	@RequestMapping(value="/candidatesearch", method=RequestMethod.GET)
	public @ResponseBody JSONObject candidatesearch(CandiParam candiParam) {
		JSONObject json = candiService.getCandidateIntroduce(candiParam);
		
		return json;
	}
	@RequestMapping(value="/candidatesearch", method=RequestMethod.POST)
	public @ResponseBody JSONObject candidateposter(CandiParam candiParam) {
		JSONObject json = candiService.getCandidatePoster(candiParam);
		
		return json;
	}
	
	@RequestMapping(value="/elected/{cand_id}", method= RequestMethod.POST)
	public @ResponseBody JSONObject setElectPerson(CandiParam candiParam) {
		JSONObject json = candiService.setElectPerson(candiParam);
		
		return json;
	}
	@RequestMapping(value="/electedreset", method= RequestMethod.GET)
	public ModelAndView electedReset(ModelAndView mav) {
		int updCntCandi = candiService.updateElectedPerson();
		int delCntPledge = candiService.deleteElectedPledge();
		mav.addObject("updCntCandi",updCntCandi);
		mav.addObject("delCntPledge",delCntPledge);
		mav.setViewName("/admin/candilist");
		
		return mav;
	}
}