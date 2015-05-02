package net.javabugs.web.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.javabugs.web.example.model.dao.CandiDAO;
import net.javabugs.web.example.model.dao.JoinDao;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.Join;
import net.javabugs.web.example.model.dto.JoinParam;
import net.sf.json.JSONObject;

@Service
public class UserService {
	@Autowired
	private JoinDao joinDao;

	public JSONObject getUserList(JoinParam joinParam) {
		JSONObject json = new JSONObject();
		List<Join> userList = null;
		//여기서 count를 먼저얻어야한다
		
		int count = joinDao.getCountUserList(joinParam);
		
		if(count>0){
			userList = joinDao.getUserList(joinParam);
		}
	
		json.accumulate("userList", userList);
		
		return json;
	}

	public JSONObject updateAuthority(JoinParam joinParam) {
		int result = joinDao.updateAuthority(joinParam);
		JSONObject json = new JSONObject();
		
		json.accumulate("updCnt", result);
		return json;
	}

}
