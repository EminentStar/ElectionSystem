package net.javabugs.web.example.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.dao.GroupMembersDao;
import net.javabugs.web.common.mvc.model.dto.GroupMember;
import net.javabugs.web.common.mvc.model.vo.ExtJsResultVO;
import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dao.JoinDao;
import net.javabugs.web.example.model.dto.DeptParam;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Paging;
import net.javabugs.web.example.model.dto.Post;


@Service("joinService")
public class JoinService {
	
	private Logger logger = Logger.getLogger(JoinService.class);
	
	@Autowired
	private JoinDao joinDao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private GroupMembersDao groupMembersDao;
	
	@Transactional  
	public ResultVO create(JoinParam param) {
			String newPwd = param.getPasswd();
			param.setPasswd(passwordEncoder.encodePassword(newPwd, null)); //암호화를 한다음 그값을  패스워드에 집어넣어?
			//이부분이 실제적으로 비밀번호를 암호화를 하는부분 
			int ret = joinDao.createUser(param); 
		//joinDao에 권한추가하는 메서드 만들자
		if(ret > 0 ){
			joinDao.createUserAuthority(param);
		}
		
				
		ResultVO result = new ResultVO();
		return result;
	}
	
	@Transactional
	public ResultVO checkValidation(JoinParam param) {
		int countCid = joinDao.checkCid(param);

		JSONObject resultJson = new JSONObject();
		resultJson.accumulate("user_id", countCid == 0);
		
		return new ResultVO(resultJson);
		
	}

	public ResultVO getDeptList() {
		ResultVO result = new ResultVO();
		List<DeptParam> deptList = null;
		//여기서 count를 먼저얻어야한다
		
		int count = joinDao.getCountDeptList();
		
		if(count>0){
			deptList = joinDao.getDeptList();
		}
		result.put("deptList", deptList);
		
		return result;
	}
}
