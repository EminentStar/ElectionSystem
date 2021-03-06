package net.javabugs.web.example.model.dao;

import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.FileInfo;

public interface FileDAO {
	public FileInfo getFileInfo(String fid);

	public FileInfo getCandiFileInfo(String fid);
	
	
	
	public int insertAttachFile(FileInfo post);

	public FileInfo getSubFileInfo(Candi candi);

	public int insertCandiAttachFile(FileInfo fileInfo);

	public int insertCandipAttachFile(FileInfo fileInfo);
	
}
