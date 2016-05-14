package net.javabugs.web.example.model.dto;

import net.javabugs.web.common.mvc.model.vo.ParameterVO;

import org.springframework.web.multipart.MultipartFile;



public class FileUploadParam extends ParameterVO {

	private String CKEditor;
	
	private String CKEditorFuncNum;
	
	private String langCode;	
	
	private MultipartFile upload;

	public String getCKEditor() {
		return CKEditor;
	}

	public void setCKEditor(String cKEditor) {
		CKEditor = cKEditor;
	}

	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}

	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
	}

	public String getLangCode() {
		return langCode;
	}

	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
}
