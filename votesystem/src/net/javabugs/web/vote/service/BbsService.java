package net.javabugs.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import net.javabugs.web.example.model.dao.BbsDAO;
import net.javabugs.web.example.model.dao.CommentDAO;
import net.javabugs.web.example.model.dto.Paging;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service //일단 이어노테이션만 붙이겠습니다.
public class BbsService {
	
	@Autowired
	private BbsDAO bbsDAO;
	@Autowired
	private CommentDAO commentDAO;
	
	//여기다 일단 변수를 하나 설정해요!
	@Value("#{javabugsProp['file.upload.dir']}") //요이름은 우리가 수정한 이름이죠!
	// <util:properties id="javabugsProp" location="/WEB-INF/config/javabugs.properties"/> scm.xml에서 이게 이걸 자바벅스프로프로 쓸수있게해주는거다!
	private String fileDir; 
	
	
	public JSONObject getPostList(PostParam param){
		JSONObject json = new JSONObject();
		List<Post> postList = null;
		//여기서 count를 먼저얻어야한다
		
		int count = bbsDAO.getCountPostList(param);
		Paging paging = new Paging(param.getCurrPageNo(),count);
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		
		if(count>0){
			postList = bbsDAO.getPostList(param);
		}
		
		json.accumulate("paging", paging);
		json.accumulate("postList", postList);
		
		return json;
	}
	
	public Post getPost(PostParam param){
		return bbsDAO.getPost(param);
	}
	
	@Transactional //잘못되면 롤백되야하니 트랜잭셔녈 ㄱㄱ
	public int deletePost(PostParam postParam) {
		
		int result =  bbsDAO.deletePost(postParam);
		if(result>0){
			commentDAO.deleteCommentByNum_bid(postParam.getNum_bid());
		}
		return result;
	}
	public int deleteHome(PostParam postParam){
		int result = bbsDAO.deletePost(postParam);
		return result;
	}

	public int updatePost(PostParam postParam) {
		int result = bbsDAO.updatePost(postParam);
		return result;
	}

	@Transactional
	public int insertPost(PostParam postParam) throws IOException { //파일이들어올수도있으니! 파일도!
		String name = postParam.getAttachment().getOriginalFilename(); 
		boolean hasFile = name != null && !"".equals(name);
		int result = -1;
		
		Post post = new Post();
		if(hasFile){
			String fileName = null;
			if(postParam.getTitle().length() < 5){
				fileName = postParam.getAttachment().getOriginalFilename();
				
			}else{
				fileName = postParam.getAttachment().getOriginalFilename();
			}
			post.setFilename(fileName);
			post.setFilepath(fileDir+postParam.getAttachment().getOriginalFilename());
			
			result = bbsDAO.insertAttachFile(post); //fid가 온다?
					
		}
		
		//결과값으로 FID가 온다. //이제 안간다!!
		if(result > 0 || result == -1 ){
//			Post post = new Post();
			//post.setFid(postParam.getFid()); //이렇게 추가해주면 될꺼구요! 여기서 다시 집어넣어주니깐 공백이셋팅되니깐 없어?
			post.setTitle(postParam.getTitle());
			post.setContent(postParam.getContent());
			post.setFirst_word(postParam.getFirst_word());
			post.setUser_id(postParam.getLoginUserId());
			post.setBbs_type(postParam.getBbs_type());
			result = bbsDAO.insertPost(post);
		}
		//그리고 위 두개는 같은 트랜잭션으로 묶는게 좋겠죠?
		
		//new Paging(1); //무조건 써야하죠?
		
		if(result > 0 && hasFile){
//			String name = postParam.getAttachment().getOriginalFilename(); 
//				String fileDir = "d:\\upload\\"; //디스크가 늘어나게 되면 수정이 될수도있으니깐 리소스로 빼는게 좋다! 팀명.properties에       fileDir 
				
			FileOutputStream fos = new FileOutputStream(fileDir + name);//이러면 파일을 쓸위치가 필요하죠? 이러면 xml에서 정의한 경로로 뭐되고 앞으로 거기서 뭐 읽고함? 그냥 throws로 ! (try catch no no)
			
			InputStream is = postParam.getAttachment().getInputStream();
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
}

