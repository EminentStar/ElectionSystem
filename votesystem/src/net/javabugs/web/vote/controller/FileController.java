package net.javabugs.web.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.javabugs.web.example.model.dao.FileDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.FileInfo;
import net.javabugs.web.example.model.dto.FileUploadParam;
import net.javabugs.web.example.service.FileService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/file")
public class FileController {
	@Autowired
	private FileService fileService;
	@Autowired
	private FileDAO fileDAO;
	
	@Value("#{javabugsProp['file.upload.dir']}") //FileController도 해주자!
	private String fileDir;
	
	
	@RequestMapping("/upload")
	public String upload(FileUploadParam uploadParam,
			HttpServletRequest request) throws IOException {
		FileInfo fileInfo = fileService.fileUpload(uploadParam);
		request.setAttribute("fileInfo", fileInfo);
		request.setAttribute("uploadParam", uploadParam);
		return "/file/fileupload";
	}
	@RequestMapping("/upload/{fid}/{sub_fid}")
	public String candiupload(CandiParam candiParam,
			HttpServletRequest request) throws IOException {
		FileInfo fileInfo = fileService.candifileUpload(candiParam);
		request.setAttribute("fileInfo", fileInfo);
		request.setAttribute("candiParam", candiParam);
		return "/file/cfileupload";
	}
	@RequestMapping("/pupload/{fid}/{sub_fid}")
	public String candipupload(CandiParam candiParam,
			HttpServletRequest request) throws IOException {
		FileInfo fileInfo = fileService.candipfileUpload(candiParam);
		request.setAttribute("fileInfo", fileInfo);
		request.setAttribute("candiParam", candiParam);
		return "/file/cfileupload";
	}
	
	
	@RequestMapping("/download/{fid}")
	public  void download(@PathVariable String fid, 
			HttpServletResponse response){ 
		FileInfo fileInfo = fileDAO.getFileInfo(fid);


//		File file = new File(fileDir + fileInfo.getFilepath());
		File file = new File(fileInfo.getFilepath());

		

		
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			OutputStream os = response.getOutputStream(); 
			String fileName = URLEncoder.encode(fileInfo.getFilename(),"UTF-8"); 
			response.setHeader("Content-Disposition", "attachment; filename="+fileName);
			
			byte[] b = new byte[1024];
			while(fis.read(b) != -1){
				os.write(b);
			}
			os.flush();
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(fis != null)try{fis.close();}catch(IOException e){}
		}

	}
	@RequestMapping("/candidownload/{fid}")
	public  void candidownload(@PathVariable String fid, 
			HttpServletResponse response){ 
		FileInfo fileInfo = fileDAO.getFileInfo(fid);


//		File file = new File(fileDir + fileInfo.getFilepath());
		File file = new File(fileInfo.getFilepath());
		
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			OutputStream os = response.getOutputStream(); 
			String fileName = URLEncoder.encode(fileInfo.getFilename(),"UTF-8"); 
			response.setHeader("Content-Disposition", "attachment; filename="+fileName);
			
			byte[] b = new byte[1024];
			while(fis.read(b) != -1){
				os.write(b);
			}
			os.flush();
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(fis != null)try{fis.close();}catch(IOException e){}
		}

	}
	@RequestMapping("/candidownload/{fid}/{sub_fid}")
	public  void candidownload(Candi candi, 
			HttpServletResponse response){ 
		FileInfo fileInfo = fileDAO.getSubFileInfo(candi);
		
		
//		File file = new File(fileDir + fileInfo.getFilepath());
		File file = new File(fileInfo.getFilepath());
		
		FileInputStream fis = null;
		try{
			fis = new FileInputStream(file);
			OutputStream os = response.getOutputStream(); 
			String fileName = URLEncoder.encode(fileInfo.getFilename(),"UTF-8"); 
			response.setHeader("Content-Disposition", "attachment; filename="+fileName);
			
			byte[] b = new byte[1024];
			while(fis.read(b) != -1){
				os.write(b);
			}
			os.flush();
		}catch(IOException e){
			e.printStackTrace();
		}finally{
			if(fis != null)try{fis.close();}catch(IOException e){}
		}
		
	}
}	
