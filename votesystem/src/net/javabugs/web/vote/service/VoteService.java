package net.javabugs.web.example.service;

import java.util.List;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dao.CandiDAO;
import net.javabugs.web.example.model.dao.JoinDao;
import net.javabugs.web.example.model.dao.VoteDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.CheckParam;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Vote;
import net.javabugs.web.example.model.dto.VoteParam;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class VoteService {
	@Autowired
	private CandiDAO candiDAO;
	@Autowired
	private VoteDAO voteDAO;

	public JSONObject getCandiList(CandiParam candiParam) {
		// TODO Auto-generated method stub
		
			JSONObject json = new JSONObject();
			List<Candi> voteList = null;
			//여기서 count를 먼저얻어야한다
			
			int count = candiDAO.getCountCandiList(candiParam);
			//Paging paging = new Paging(param.getCurrPageNo(),count);
			//param.setFromRowNum(paging.getFromRowNum());
			//param.setToRowNum(paging.getToRowNum());
			
			if(count>0){
				voteList = candiDAO.getCandiList(candiParam);
			}
			
			//json.accumulate("paging", paging);
			json.accumulate("voteList", voteList);
			
			return json;
		
	}
	
	public ResultVO vote(VoteParam vote) {
		// TODO Auto-generated method stub
		int ret = voteDAO.vote(vote);
		System.out.println(ret);
		ResultVO result= new ResultVO();
		return result;
	}

	

	public Vote getVoteRate(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return voteDAO.getVoteRate(voteParam);
	}

	public ResultVO getVoteCandiRate(VoteParam voteParam) {
		// TODO Auto-generated method stub
		ResultVO result = new ResultVO();
		List<Vote> votecandiList = null;

		votecandiList = voteDAO.getVoteCandiList(voteParam);
		
		result.put("votecandiList", votecandiList);
		
		return result;
	}

	public JSONObject getVoteTotalRate(VoteParam voteParam) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		List<Vote> votetotalRate = null;

		votetotalRate = voteDAO.getVoteTotalList(voteParam);
		
		result.put("votetotalRate", votetotalRate);
		
		return result;
	}

	public JSONObject getVoteCollegeRate(VoteParam voteParam) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		List<Vote> votecollegeRate = null;

		votecollegeRate = voteDAO.getVoteCollegeList(voteParam);
		
		result.put("votecollegeRate", votecollegeRate);
		
		return result;
	}

	public JSONObject getElectedResult(VoteParam voteParam) {
		// TODO Auto-generated method stub
		JSONObject result = new JSONObject();
		List<Vote> electedresult = null;

		electedresult = voteDAO.getElectedResult(voteParam);
		
		result.put("electedresult", electedresult);
		
		return result;
	}

	@Transactional
	public int checkValidation(VoteParam voteParam) {
		// TODO Auto-generated method stub
		
		
			int countuserid = voteDAO.checkUserid(voteParam);

			
			return countuserid;
			
	}

	public int checkVoteTerm() {
		int ret = voteDAO.checkVoteTerm();
		return ret;		
		
	}

	public int updateTermCheck(CheckParam checkParam) {
		int ret = voteDAO.updateTerm(checkParam);
		return ret;
	}
	

}
