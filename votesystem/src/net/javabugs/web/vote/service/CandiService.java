package net.javabugs.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import net.javabugs.web.common.mvc.model.vo.ResultVO;
import net.javabugs.web.example.model.dao.CandiDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.Pledge;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class CandiService {
	@Autowired
	private CandiDAO candiDAO;
	
	@Value("#{javabugsProp['file.upload.dir']}")
	private String fileDir;

	public JSONObject getCandiList(CandiParam candiParam) {
		JSONObject json = new JSONObject();
		List<Candi> candiList = null;
		//여기서 count를 먼저얻어야한다
		
		int count = candiDAO.getCountCandiList(candiParam);
		//Paging paging = new Paging(param.getCurrPageNo(),count);
		//param.setFromRowNum(paging.getFromRowNum());
		//param.setToRowNum(paging.getToRowNum());
		
		if(count>0){
			candiList = candiDAO.getCandiList(candiParam);
		}
		
		//json.accumulate("paging", paging);
		json.accumulate("candiList", candiList);
		
		return json;
	}

	public Candi getCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		
		Candi candi = candiDAO.getCandi(candiParam);
		if(candi == null){
			candi=candiDAO.getCandidetail(candiParam);
		}else{
		Candi tmpcandi = candiDAO.getpCandi(candiParam);
		candi.setPfilename(tmpcandi.getPfilename());
		candi.setPfilepath(tmpcandi.getPfilepath());
		}
		
		return candi;
	}

	public int deleteCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		int result2=0;
		int result3=0;
		int result4=0;
		int result = candiDAO.deleteCandiAttach(candiParam);
		
		if(result>0){
			result3 = candiDAO.deleteCandiVote(candiParam);
			result4 = candiDAO.deletePledge(candiParam);
			
		}
		
		result2=candiDAO.deleteCandi(candiParam);
		return result2;
	}

	public int updateCandi(CandiParam candiParam) {
		// TODO Auto-generated method stub
		return candiDAO.updateCandi(candiParam);
	}

	@Transactional
	public int insertCandi(CandiParam candiParam) throws IOException{
		String name=null;
		String pname=null;
		if(candiParam.getAttachment()!=null){
		 name = candiParam.getAttachment().getOriginalFilename();
		}
		if(candiParam.getPattachment() !=null){
			pname=candiParam.getPattachment().getOriginalFilename();
		}
		
		boolean hasFile = name != null && !"".equals(name);
		boolean phasFile= pname !=null && !"".equals(pname);
		int result = -1;
		
		Candi candi = new Candi();
		if(hasFile){
			String fileName = null;
			
			fileName= candiParam.getUser_name();
			
			candi.setFilename(candiParam.getAttachment().getOriginalFilename());
			candi.setFilepath(fileDir+candiParam.getAttachment().getOriginalFilename());
			candi.setCand_id(candiParam.getCand_id());
			
			result = candiDAO.insertAttachFile(candi);
		}
		if(phasFile){
			String fileName = null;
			
			fileName= candiParam.getUser_name();
			
			candi.setFilename(candiParam.getPattachment().getOriginalFilename());
			candi.setFilepath(fileDir+candiParam.getPattachment().getOriginalFilename());
			candi.setCand_id(candiParam.getCand_id());
			
			result = candiDAO.insertPAttachFile(candi);
		}
		
		if( result >0 || result == -1){
			candi.setCand_id(candiParam.getCand_id());
			candi.setUser_name(candiParam.getUser_name());
			candi.setUser_id(candiParam.getUser_id());
			candi.setProfile(candiParam.getProfile());
			result = candiDAO.insertCandi(candi);
		}
		

		if(result > 0 && hasFile){
//			String name = postParam.getAttachment().getOriginalFilename(); 
//				String fileDir = "d:\\upload\\"; //디스크가 늘어나게 되면 수정이 될수도있으니깐 리소스로 빼는게 좋다! 팀명.properties에       fileDir 
				
			FileOutputStream fos = new FileOutputStream(fileDir + name);//이러면 파일을 쓸위치가 필요하죠? 이러면 xml에서 정의한 경로로 뭐되고 앞으로 거기서 뭐 읽고함? 그냥 throws로 ! (try catch no no)
			
			InputStream is = candiParam.getAttachment().getInputStream();
			BufferedInputStream bis = new BufferedInputStream(is);
			
			byte[] buffer = new byte[2048];
			while(bis.read(buffer)!= -1){
				fos.write(buffer);
			}
			
			fos.close();//다썼으면 닫아주자!
			//파일명만바꾸면안됨?뭐 파일컨트롤러도 바꿔줘야함!
		}
		if(result > 0 && phasFile){
//			String name = postParam.getAttachment().getOriginalFilename(); 
//				String fileDir = "d:\\upload\\"; //디스크가 늘어나게 되면 수정이 될수도있으니깐 리소스로 빼는게 좋다! 팀명.properties에       fileDir 
				
			FileOutputStream fos = new FileOutputStream(fileDir + pname);//이러면 파일을 쓸위치가 필요하죠? 이러면 xml에서 정의한 경로로 뭐되고 앞으로 거기서 뭐 읽고함? 그냥 throws로 ! (try catch no no)
			
			InputStream is = candiParam.getPattachment().getInputStream();
			BufferedInputStream bis = new BufferedInputStream(is);
			
			byte[] buffer = new byte[2048];
			while(bis.read(buffer)!= -1){
				fos.write(buffer);
			}
			
			fos.close();//다썼으면 닫아주자!
			//파일명만바꾸면안됨?뭐 파일컨트롤러도 바꿔줘야함!
		}
		
		
		return result;
	}

	public JSONObject getCandidateIntroduce(CandiParam candiParam) {
		JSONObject json = new JSONObject();//
		List<Candi> candiList = null;
		//List<Pledge> pledgeList = null;
		
		candiList = candiDAO.getCandidateIntroduce(candiParam);
		//pledgeList = candiDAO.getPledgeList(candiParam);
		
		json.accumulate("candiList", candiList);
		//json.accumulate("pledgeList", pledgeList);
		
		return json;
	}

	public JSONObject getCandidatePoster(CandiParam candiParam) {
		JSONObject json = new JSONObject();//
		Candi candi = null;
		List<Pledge> pledgeList = null;
		
		candi = candiDAO.getCandidatePoster(candiParam);
		pledgeList = candiDAO.getPledgeList(candiParam);
		
		json.accumulate("candi", candi);
		json.accumulate("pledgeList", pledgeList);
		
		return json;
	}

	public ResultVO checkValidation(CandiParam param) {
		// TODO Auto-generated method stub
		int countCid = candiDAO.checkcand_id(param);

		JSONObject resultJson = new JSONObject();
		resultJson.accumulate("user_id", countCid == 0);
		
		return new ResultVO(resultJson);
	}
	
	@Transactional
	 public JSONObject setElectPerson(CandiParam candiParam){
	 	JSONObject json = new JSONObject();
	 	try {
	 	int updCnt = candiDAO.setElectPerson(candiParam); //후보자를 당선자로 전환(기호 0번) 
	 	
//	 	int updCntPledge = candiDAO.setPledge(candiParam);//후보자 공약테이블에서 당선자의 공약의 cand_id 를 0으로 변환
	 	
	 	int updCntElectedPledge = candiDAO.setElectedPledge(candiParam); //후보자의 공약을 당선자 공약 테이블로 복사
	 	
	 	json.accumulate("updCnt", updCnt);
//	 	json.accumulate("updCntPledge", updCntPledge);
	 	json.accumulate("updCntElectedPledge", updCntElectedPledge);
	 	} catch (Exception e) {
	 		e.printStackTrace();
	 	}
	 	return json;
	  }

	public int updateElectedPerson() {
		return candiDAO.updateElectedPerson();
	}

	public int deleteElectedPledge() {
		return candiDAO.deleteElectedPledge();
	}
}