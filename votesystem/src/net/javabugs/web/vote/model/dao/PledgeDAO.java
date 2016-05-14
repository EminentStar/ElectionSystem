package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.example.model.dto.ElectedPledge;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;

public interface PledgeDAO {

	public List<Pledge> getPledgeList(PledgeParam pledgeParam);
	
	public int getCountPledgeList(PledgeParam pledgeParam);

	public Pledge getPledge(PledgeParam pledgeParam);

	public int getCountElectedPledgeList();


	public int deleteCandi(PledgeParam predgeParam);

	public List<ElectedPledge> getPledgeCheckList(ElectedPledge electedPledge);

	public int updatePledge(PledgeParam pledgeParam);

	public int insertPledge(PledgeParam param);

	public int checkPledge(PledgeParam param);

	public ElectedPledge getElectedPledge(String pledge_id);

	public int updateElectedPledge(ElectedPledge electedPledge);

	public int checkpledge(PledgeParam param);




}
