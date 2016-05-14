package net.javabugs.web.example.model.dao.impl;

import java.util.List;

import net.javabugs.web.example.model.dao.BbsDAO;
import net.javabugs.web.example.model.dao.VoteDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CheckParam;
import net.javabugs.web.example.model.dto.JoinParam;
import net.javabugs.web.example.model.dto.Vote;
import net.javabugs.web.example.model.dto.VoteParam;
import net.sf.json.JSONObject;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class VoteDAOImpl extends SqlSessionDaoSupport implements VoteDAO{

	@Override
	public int vote(VoteParam vote) {
		// TODO Auto-generated method stub
		return (int) getSqlSession().insert("net.javabugs.web.example.model.mapper.Vote.dovote", vote);
	}

	//return (Candi) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Candi.getCandi",candiParam);
	@Override
	public Vote getVoteRate(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return (Vote) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Vote.voterate",voteParam);
	}

	@Override
	public List<Vote> getVoteCandiList(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Vote.voteresult",voteParam);
	}

	@Override
	public List<Vote> getVoteTotalList(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Vote.voterate",voteParam);
	}

	@Override
	public List<Vote> getVoteCollegeList(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Vote.votecollegerate",voteParam);
	}

	@Override
	public List<Vote> getElectedResult(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Vote.electedresult",voteParam);
	}

	/*@Override
	public int checkCid(JoinParam param) {
		return (Integer)getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Join.checkCid", 
				param);
		
	}*/
	@Override
	public int checkUserid(VoteParam voteParam) {
		// TODO Auto-generated method stub
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Vote.checkUserid",voteParam);
	}

	@Override
	public int checkVoteTerm() {
		// TODO Auto-generated method stub
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Vote.checkVoteTerm");

	}

	@Override
	public int updateTerm(CheckParam checkParam) {
		// TODO Auto-generated method stub
		return (int) getSqlSession().update("net.javabugs.web.example.model.mapper.Vote.updateTerm",checkParam);

	}


}
