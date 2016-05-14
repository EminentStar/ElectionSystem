package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.example.model.dto.CheckParam;
import net.javabugs.web.example.model.dto.Vote;
import net.javabugs.web.example.model.dto.VoteParam;
import net.sf.json.JSONObject;

public interface VoteDAO {

	int vote(VoteParam vote);

	Vote getVoteRate(VoteParam voteParam);

	List<Vote> getVoteCandiList(VoteParam voteParam);

	List<Vote> getVoteTotalList(VoteParam voteParam);

	List<Vote> getVoteCollegeList(VoteParam voteParam);

	List<Vote> getElectedResult(VoteParam voteParam);

	int checkUserid(VoteParam voteParam);

	int checkVoteTerm();

	int updateTerm(CheckParam checkParam);

	
	
}
