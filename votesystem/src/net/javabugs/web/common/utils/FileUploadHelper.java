package net.javabugs.web.common.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

import net.javabugs.web.common.constant.VSConstants;

public class FileUploadHelper {
	
	private Logger logger = Logger.getLogger(FileUploadHelper.class);
	
	@Value("#{javabugsProp['file.upload.dir']}")
	private String defaultFilePath;
	
	private int bufferSize = 1024 * 256;
	
	public String THUMBNAIL_DIR = "thumb";
	
	public String getFilePath(String dirLevel1) {
		return defaultFilePath + dirLevel1; 
	}
	
	public String getFilePath(String dirLevel1, String dirLevel2) {
		return getFilePath(dirLevel1) 
				+ File.separator + dirLevel2 
				+ File.separator;
	}
	
	private String getImageFilePath(String dirLevel1, String dirLevel2, String fileName) {
		return getImageFilePath(dirLevel1, dirLevel2, null, fileName);
	}
	
	private String getImageFilePath(String dirLevel1, String dirLevel2, String dirLevel3, String fileName) {
		return getFilePath(dirLevel1, dirLevel2) + (!StringUtils.isEmpty(dirLevel3) ? dirLevel3 + File.separator : "")  + fileName + VSConstants.IMAGE_FILE_EXTENSION;
	}

	public void copyImage(OutputStream os, String dirLevel1, String dirLevel2, String dirLevel3, String fileName, String defaultImagePath) throws IOException {
		FileInputStream fis = null;
		try {
			String path = getImageFilePath(dirLevel1, dirLevel2, dirLevel3, fileName);
			File file = new File(path);
			
			if (!file.exists()) {
				file = new File(defaultImagePath);
			}
			
			fis = new FileInputStream(file);
			
			byte[] b = new byte[bufferSize];
			int len = -1;
			while((len = fis.read(b)) > -1) {
				os.write(b, 0, len);
				b = new byte[512];
			}
		} catch (IOException e) {
			logger.error(e.getMessage());
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw e;
			}
		}
	}
	
	public void copyImage(OutputStream os, String dirLevel1, String dirLevel2, String fileName, String defaultImagePath) throws IOException {
		copyImage(os, dirLevel1, dirLevel2, null, fileName, defaultImagePath);
	}
	
	public void writeImage(InputStream is, String dirLevel1, String dirLevel2, String fileName) throws IOException {
		writeImage(is, dirLevel1, dirLevel2, fileName, true);
	}
	
	public void writeImage(InputStream is, String dirLevel1, String dirLevel2, String fileName, boolean makeThumnail) throws IOException {
		FileOutputStream fos = null;
		try {
			String filePath = getImageFilePath(dirLevel1, dirLevel2, fileName);
			String thumbFilePath = getImageFilePath(dirLevel1, dirLevel2, THUMBNAIL_DIR, fileName);
			
			File file = new File(filePath);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			
			fos = new FileOutputStream(filePath);
			
			int len = -1;
			byte[] b = new byte[bufferSize];
			while((len = is.read(b)) != -1) {
				fos.write(b, 0, len);
			}
			
			file = new File(thumbFilePath);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			
			if (makeThumnail) {
				//썸네일 이미지 생성
				ImageUtils.createThumbnail(filePath, thumbFilePath, "jpg", 120);
			}
			
		} catch (IOException e) {
			logger.error(e.getMessage());
			throw e;
		} finally {
			try {
				if (fos != null) {
					fos.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw e;
			}
		}
	}
	
	public void deleteImage(String dirLevel1, String dirLevel2, String fileName) {
		String filePath = getImageFilePath(dirLevel1, dirLevel2, fileName);
		String thumbFilePath = getImageFilePath(dirLevel1, dirLevel2, "thumb", fileName);
		
		//이미지 삭제
		File file = new File(filePath);
		if (file.exists()) {
			file.delete();
		}
		
		//썸네일 이미지가 존재하면 삭제
		file = new File(thumbFilePath);
		if (file.exists()) {
			file.delete();
		}
	}
	
	public void writeFile(InputStream is, String dirLevel1, String dirLevel2, String fileName) throws IOException {
		FileOutputStream fos = null;
		try {
			String filePath = getFilePath(dirLevel1, dirLevel2) + fileName;
			
			File file = new File(filePath);
			if (!file.getParentFile().exists()) {
				file.getParentFile().mkdirs();
			}
			
			fos = new FileOutputStream(filePath);
			
			int len = -1;
			byte[] b = new byte[bufferSize];
			while((len = is.read(b)) != -1) {
				fos.write(b, 0, len);
			}
		} catch (IOException e) {
			logger.error(e.getMessage());
			throw e;
		} finally {
			try {
				if (fos != null) {
					fos.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw e;
			}
		}
	}
	
	public void deleteFile(String dirLevel1, String dirLevel2, String fileName) {
		String filePath = getFilePath(dirLevel1, dirLevel2) + fileName;
		
		//파일 삭제
		File file = new File(filePath);
		if (file.exists()) {
			file.delete();
		}
	}
	
	public boolean copyFile(HttpServletResponse response, String dirLevel1, String dirLevel2, String fileName) throws IOException {
		return copyFile(response, dirLevel1, dirLevel2, fileName, fileName);
	}
	
	public boolean copyFile(HttpServletResponse response, String dirLevel1, String dirLevel2, String fileName, String downloadName) throws IOException {
		FileInputStream fis = null;
		try {
			String path = getFilePath(dirLevel1, dirLevel2) + fileName;
			File file = new File(path);
			OutputStream os = response.getOutputStream();
			fis = new FileInputStream(file);
			
			response.setHeader("Content-Disposition", "attachment; filename=" + URLEncoder.encode(downloadName, response.getCharacterEncoding()));
			response.setContentLength((int) file.length());
			
			byte[] b = new byte[bufferSize];
			int len = -1;
			while((len = fis.read(b)) > -1) {
				os.write(b, 0, len);
				b = new byte[512];
			}
			return true;
		} catch (IOException e) {
			logger.error(e.getMessage());
			return false;
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw e;
			}
		}
	}
	
	public boolean copyFile(OutputStream os, String dirLevel1, String dirLevel2, String fileName) throws IOException {
		FileInputStream fis = null;
		try {
			String path = getFilePath(dirLevel1, dirLevel2) + fileName;
			File file = new File(path);
			fis = new FileInputStream(file);
			
			byte[] b = new byte[bufferSize];
			int len = -1;
			while((len = fis.read(b)) > -1) {
				os.write(b, 0, len);
				b = new byte[512];
			}
			return true;
		} catch (IOException e) {
			logger.error(e.getMessage());
			return false;
		} finally {
			try {
				if (fis != null) {
					fis.close();
				}
			} catch (IOException e) {
				logger.error(e.getMessage());
				throw e;
			}
		}
	}
}
