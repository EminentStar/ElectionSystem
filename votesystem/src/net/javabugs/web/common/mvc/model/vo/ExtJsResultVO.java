package net.javabugs.web.common.mvc.model.vo;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.validation.FieldError;

public final class ExtJsResultVO {

	private JSONObject data;
	
	private boolean success;
	
	private int totalPageCount;
	
	private List<FieldError> errors;

	public ExtJsResultVO(){
		this(true);
	}
	
	public ExtJsResultVO(boolean success) {
		this.data = new JSONObject();
		setSuccess(success);
	}
	
	public Object getRoot() {
		return this.data.get("root");
	}
	
	public void setRoot(Object root) {
		this.data.put("root", root);
	}
	
	public void setRoot(List<Object> root) {
		this.data.put("root", root);
	}

	public boolean isSuccess() {
		return success;
	}

	public void setSuccess(boolean success) {
		this.success = success;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public List<FieldError> getErrors() {
		return errors;
	}

	public void setErrors(List<FieldError> errors) {
		this.errors = errors;
	}
	
	@Override
	public String toString() {
		JSONObject errors = new JSONObject();
		errors.put("errors", this.errors);
		
		return new StringBuffer()
		.append("{")
		.append("success:")
		.append(this.success)
		.append(",totalPageCount:")
		.append(this.totalPageCount)
		.append(",errors:")
		.append(errors.get("errors"))
		.append(",root:")
		.append(this.data)
		.append("}").toString();
	}
	
}
