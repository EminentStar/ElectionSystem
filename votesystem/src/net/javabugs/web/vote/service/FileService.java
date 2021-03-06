package net.javabugs.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import net.javabugs.web.example.model.dao.FileDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.CandiParam;
import net.javabugs.web.example.model.dto.FileInfo;
import net.javabugs.web.example.model.dto.FileUploadParam;

@Service
public class FileService {
	
	@Value("#{javabugsProp['file.upload.dir']}")
	private String fileDir;
	
	@Autowired
	private FileDAO fileDAO;

	public FileInfo getFileInfo(String fid) {
		return fileDAO.getFileInfo(fid);
	}
	public FileInfo getSubFileInfo(Candi candi) {
		return fileDAO.getSubFileInfo(candi);
	}
	
	public FileInfo fileUpload(FileUploadParam fileUploadParam) throws IOException {
		String name = fileUploadParam.getUpload().getOriginalFilename();
		boolean hasFile = name != null && !"".equals(name);
		
		FileInfo fileInfo = new FileInfo();
		
		if (hasFile) {
			fileInfo.setFilename(fileUploadParam.getUpload().getName());
			fileInfo.setFilepath(fileDir+fileUploadParam.getUpload().getOriginalFilename());
						
			if (fileDAO.insertAttachFile(fileInfo) > 0) {
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = fileUploadParam.getUpload().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				
				fos.close();
			}
		}
		return fileInfo;
	}
	public FileInfo candifileUpload(CandiParam candiParam) throws IOException {
		// TODO Auto-generated method stub
		String name = candiParam.getUpload().getOriginalFilename();
		boolean hasFile = name != null && !"".equals(name);
		
		FileInfo fileInfo = new FileInfo();
		
		if (hasFile) {
			fileInfo.setFilename(candiParam.getUpload().getName());
			fileInfo.setFilepath(fileDir+candiParam.getUpload().getOriginalFilename());
			fileInfo.setFid(candiParam.getCand_id());
						
			if (fileDAO.insertCandiAttachFile(fileInfo) > 0) {
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = candiParam.getUpload().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				
				fos.close();
			}
		}
		return fileInfo;
	}
	public FileInfo candipfileUpload(CandiParam candiParam) throws IOException {
		// TODO Auto-generated method stub
		String name = candiParam.getUpload().getOriginalFilename();
		boolean hasFile = name != null && !"".equals(name);
		
		FileInfo fileInfo = new FileInfo();
		
		if (hasFile) {
			fileInfo.setFilename(candiParam.getUpload().getName());
			fileInfo.setFilepath(fileDir+candiParam.getUpload().getOriginalFilename());
			fileInfo.setFid(candiParam.getCand_id());
						
			if (fileDAO.insertCandipAttachFile(fileInfo) > 0) {
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = candiParam.getUpload().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				
				fos.close();
			}
		}
		return fileInfo;
	}
}
