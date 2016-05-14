package net.javabugs.web.example.controller;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import net.javabugs.web.common.mvc.model.vo.ExtJsResultVO;
import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.PostParam;
import net.javabugs.web.example.service.JoinService;
import net.sf.json.JSONObject;


@Controller
@RequestMapping("/join")
public class JoinController {
	
	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(JoinController.class);
	
	@Autowired
	private JoinService joinService;

	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String join() {
		
		//ExtJsResultVO javabugs = mfmCompanyService.readMyCompany(param);
		
		//model.addAttribute("javabugs", javabugs.getRoot());
		return "join";
	}
	@RequestMapping("/deptlist")
	public @ResponseBody ResultVO deptlist() {
		return joinService.getDeptList();
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public @ResponseBody ResultVO create(@Valid JoinParam join, BindingResult bindingResult) {
		ResultVO result = null;
		if(bindingResult.hasErrors()){//에러가 있으면 모든 에러를 리절트에담고
			result = new ResultVO();
			result.put("error", bindingResult.getAllErrors());
		}else{//error가없으면 넣자?
			result = joinService.create(join); 
		}
//		ResultVO result = joinService.create(join);
//		return result;
		return result;
	}
	
	@RequestMapping(value="/checkValidation", method=RequestMethod.GET)
	public @ResponseBody ResultVO checkValidation(JoinParam param) {
		ResultVO result = joinService.checkValidation(param);
		return result;
	}
	
	@RequestMapping(value="/searchID", method=RequestMethod.GET)
	public String searchID() {
		return "searchID";
	}
}
