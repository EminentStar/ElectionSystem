package net.javabugs.web.example.service;

import java.util.List;

import net.javabugs.web.example.model.dao.HomeDAO;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;
import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class HomeService {

	private Logger logger = Logger.getLogger(HomeService.class);
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private HomeDAO homeDAO;

	public JoinParam getUserInformation(String id) {
		return homeDAO.getUserInformation(id);
	}

	public int updateUserInformation(JoinParam joinParam) {
		if(!joinParam.getPasswd().isEmpty()){
			String newPwd = joinParam.getPasswd();
			joinParam.setPasswd(passwordEncoder.encodePassword(newPwd, null)); //암호화를 한다음 그값을  패스워드에 집어넣어?
			//이부분이 실제적으로 비밀번호를 암호화를 하는부분
		}
		return homeDAO.updateUserInformation(joinParam);
	}

	public JSONObject getPostList(PostParam postParam) {
		List<Post> postList = homeDAO.getPostList(postParam);
		JSONObject json = new JSONObject();
		
		json.accumulate("postList", postList);
		
		return json;
	}

	public JSONObject getHomeList(Post post) {
		// TODO Auto-generated method stub
		List<Post> homeList = homeDAO.getHomeList(post);
		JSONObject json = new JSONObject();
		
		json.accumulate("homeList", homeList);
		
		return json;
	}

	public int checkUserInformation(JoinParam joinParam) {
		
		JoinParam param = new JoinParam();
		String securityPasswd = null;
		if(!joinParam.getPasswd().isEmpty()){
			String newPwd = joinParam.getPasswd();
			joinParam.setPasswd(passwordEncoder.encodePassword(newPwd, null)); //암호화를 한다음 그값을  패스워드에 집어넣어?
			//이부분이 실제적으로 비밀번호를 암호화를 하는부분
			securityPasswd = joinParam.getPasswd();						
		}
		
		param =homeDAO.checkUserInformation(joinParam);
	
		if(param.getPasswd().equals(securityPasswd)){
			return 1;
		}else{
			return 0;
		}
	}

	
}
