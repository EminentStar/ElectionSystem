package net.javabugs.web.example.model.dao.impl;

import java.util.List;

import net.javabugs.web.example.model.dao.CandiDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;
import net.sf.json.JSONObject;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class CandiDAOImpl extends SqlSessionDaoSupport implements CandiDAO{

	@Override
	public List<Candi> getCandiList(CandiParam param) {
		// TODO Auto-generated method stub
		//return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Bbs.getPostList"
		//,param);
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Candi.getCandiList",param);
	}

	@Override
	public int getCountCandiList(CandiParam candiparam) {
		// TODO Auto-generated method stub
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getCountCandiList",candiparam);
	}

	@Override
	public Candi getCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return (Candi) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getCandi",candiParam);
	}

	@Override
	public int deleteCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Candi.deleteCandi",candiParam);
	}

	@Override
	public int updateCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.updateCandi",candiParam);
	}
	
	@Override
	public int insertCandi(Candi candi) {
		return getSqlSession().insert("net.javabugs.web.example.model.mapper.Candi.insertCandi",candi);
	}

	@Override
	public int insertAttachFile(Candi candi) {
		// TODO Auto-generated method stub
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.insertAttachFile",candi);
	}

	@Override
	public List<Candi> getCandidateIntroduce(CandiParam candiParam) {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Candi.getCandidateIntroduce",candiParam);
	}

	@Override
	public List<Pledge> getPledgeList(CandiParam candiParam) {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Candi.getPledgeList",candiParam);
	}

	@Override
	public Candi getCandidatePoster(CandiParam candiParam) {
		return (Candi) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getCandidatePoster",candiParam);
	}

	@Override
	public Candi getpCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return (Candi) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getpCandi",candiParam);
	}

	@Override
	public Candi getCandidetail(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return (Candi) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getCandidetail",candiParam);
	}

	@Override
	public int insertPAttachFile(Candi candi) {
		// TODO Auto-generated method stub
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.insertPAttachFile",candi);
	}

	@Override
	public int deleteCandiAttach(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Candi.deleteCandiAttach",candiParam);
	}

	@Override
	public int deleteCandiVote(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Candi.deleteCandiVote",candiParam);
	}

	@Override
	public int deletePledge(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Candi.deletePledge",candiParam);
	}

	@Override
	public int checkcand_id(CandiParam param) {
		// TODO Auto-generated method stub
		return (Integer)getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.checkcand_id", 
				param);
	}

	@Override
	public int setElectPerson(CandiParam candiParam) {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.setElectPerson",candiParam);
	}

//	@Override
//	public int setPledge(CandiParam candiParam) {
//		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.setPledge",candiParam);
//	}
	
	@Override
	public int setElectedPledge(CandiParam candiParam) {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.setElectedPledge",candiParam);
	}

	@Override
	public int updateElectedPerson() {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Candi.updateElectedPerson");
	}

	@Override
	public int deleteElectedPledge() {
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Candi.deleteElectedPledge");
	}


}
