package net.javabugs.web.example.service;

import java.util.List;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dao.PledgeDAO;
import net.javabugs.web.example.model.dto.ElectedPledge;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class PledgeService {
	
	@Autowired
	private PledgeDAO pledgeDAO;

	
	public JSONObject getPlegeList(PledgeParam pledgeParam) {
		JSONObject json = new JSONObject();
		List<Pledge> pledgeList = null;
		pledgeList = pledgeDAO.getPledgeList(pledgeParam);
		json.accumulate("pledgeList",pledgeList);
		return json;
	}
	
	public Pledge getPledge(PledgeParam pledgeParam){
		return pledgeDAO.getPledge(pledgeParam);
	}

	public int getCountElectedPledgeList() {
		return pledgeDAO.getCountElectedPledgeList(); 
		
	}

	public int deletePledge(PledgeParam predgeParam) {
		int result = pledgeDAO.deleteCandi(predgeParam);
		
		return result;
	}

	public int updatePledge(PledgeParam pledgeParam) {
		// TODO Auto-generated method stub
		return pledgeDAO.updatePledge(pledgeParam);
	}


	public List<ElectedPledge> getPledgeCheckList(ElectedPledge electedPledge) {
		return pledgeDAO.getPledgeCheckList(electedPledge);
	}

	public int insertPledge(PledgeParam pledgeParam) {
		// TODO Auto-generated method stub
		return pledgeDAO.insertPledge(pledgeParam);
	}

	public ElectedPledge getElectedPledge(String pledge_id) {
		return pledgeDAO.getElectedPledge(pledge_id);
	}

	public int updateElectedPledge(ElectedPledge electedPledge) {
		return pledgeDAO.updateElectedPledge(electedPledge);
	}

	public ResultVO checkValidation(PledgeParam param) {
		// TODO Auto-generated method stub
		int countCid = pledgeDAO.checkpledge(param);

		JSONObject resultJson = new JSONObject();
		resultJson.accumulate("cand_id", countCid == 0);
		
		return new ResultVO(resultJson);
	}





}
