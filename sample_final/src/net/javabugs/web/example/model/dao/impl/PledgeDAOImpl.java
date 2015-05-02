package net.javabugs.web.example.model.dao.impl;

import java.util.List;

import net.javabugs.web.example.model.dao.PledgeDAO;
import net.javabugs.web.example.model.dto.ElectedPledge;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

@Repository
public class PledgeDAOImpl extends  SqlSessionDaoSupport implements PledgeDAO{
	
	@Override
	public List<Pledge> getPledgeList(PledgeParam param) {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Pledge.getPledgeList",param);
	}
	
	@Override
	public int getCountPledgeList(PledgeParam pledgeParam) {
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Pledge.getCountPledgeList",pledgeParam);
	}

	@Override
	public Pledge getPledge(PledgeParam pledgeParam) {
		return (Pledge) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Pledge.getPledge",pledgeParam);
	}

	@Override
	public int getCountElectedPledgeList() {
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Pledge.getCountElectedPledgeList");
	}


	@Override
	public int deleteCandi(PledgeParam pledgeParam) {
		return getSqlSession().delete("net.javabugs.web.example.model.mapper.Pledge.deletePledge",pledgeParam);
	
	}

	@Override
	public int updatePledge(PledgeParam pledgeParam) {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Pledge.updatePledge",pledgeParam);
		
	}

	@Override
	public List<ElectedPledge> getPledgeCheckList(ElectedPledge electedPledge) {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Pledge.getElectedPledgeList");
	}

	@Override
	public int insertPledge(PledgeParam param) {
		try {
		return (int) getSqlSession().insert("net.javabugs.web.example.model.mapper.Pledge.insertPledge", param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	@Override
	public int checkPledge(PledgeParam param) {
		return (int) getSqlSession().insert("net.javabugs.web.example.model.mapper.Pledge.checkCandid", param);
	}

	@Override
	public ElectedPledge getElectedPledge(String pledge_id) {
		return (ElectedPledge) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Pledge.getElectedPledge",pledge_id);
	}

	@Override
	public int updateElectedPledge(ElectedPledge electedPledge) {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.Pledge.updateElectedPledge",electedPledge);
	}

	@Override
	public int checkpledge(PledgeParam param) {
		// TODO Auto-generated method stub
		return (Integer)getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Pledge.checkpledge", 
				param);
	}
}
