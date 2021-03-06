package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.Pledge;
import net.javabugs.web.example.model.dto.PledgeParam;
import net.javabugs.web.example.model.dto.PostParam;
import net.sf.json.JSONObject;

public interface CandiDAO {
	
	public List<Candi> getCandiList(CandiParam candiparam);
	
	public int getCountCandiList(CandiParam candiparam);

	public Candi getCandi(CandiParam candiParam);

	public int deleteCandi(CandiParam candiParam);

	public int updateCandi(CandiParam candiParam);

	public int insertAttachFile(Candi candi);

	public int insertCandi(Candi candi);

	public List<Candi> getCandidateIntroduce(CandiParam candiParam);

	public List<Pledge> getPledgeList(CandiParam candiParam);

	public Candi getCandidatePoster(CandiParam candiParam);

	public Candi getpCandi(CandiParam candiParam);

	public Candi getCandidetail(CandiParam candiParam);

	public int insertPAttachFile(Candi candi);

	public int deleteCandiAttach(CandiParam candiParam);

	public int deleteCandiVote(CandiParam candiParam);

	public int deletePledge(CandiParam candiParam);

	public int checkcand_id(CandiParam param);

	public int setElectPerson(CandiParam candiParam);

	public int setElectedPledge(CandiParam candiParam);

//	public int setPledge(CandiParam candiParam);

	public int updateElectedPerson();

	public int deleteElectedPledge();
}
