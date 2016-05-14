package net.javabugs.web.example.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.service.CandiService;
import net.javabugs.web.example.service.UserService;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/user")
public class UserController {
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private UserService userService;
	
	@RequestMapping("/userlist")
	public String list(HttpServletRequest request){
		logger.debug("[UserController.userlist] method called" );
//		HttpSession session = request.getSession();
//		
//		//Enumeration<String> ans = session.getAttributeNames();
//		
//		SecurityContextImpl obj =(SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
//		obj.getAuthentication().getPrincipal();
		
		return "admin/usermodify";
	}//	
	
	@RequestMapping("/usersearch")
	public @ResponseBody JSONObject search(JoinParam joinParam){
		logger.debug("[CandiController.candisearch] method called");
		JSONObject json = userService.getUserList(joinParam);
		
		return json;
	}
	@RequestMapping("/updateauth")
	public @ResponseBody JSONObject updateAuthority(JoinParam joinParam){
		JSONObject json = userService.updateAuthority(joinParam);
		
		return json;
	}

}
