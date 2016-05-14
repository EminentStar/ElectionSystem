package net.javabugs.web.example.model.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import net.javabugs.web.example.model.dao.FileDAO;
import net.javabugs.web.example.model.dto.Candi;
import net.javabugs.web.example.model.dto.FileInfo;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;


@Repository
public class FileDAOImpl extends SqlSessionDaoSupport  implements FileDAO {
	
	public FileInfo getFileInfo(String fid) {		
		return (FileInfo)getSqlSession().selectOne(
				"net.javabugs.web.example.model.mapper.File.getFileInfo", 
				fid);
	}
	
	

	

	
	/*public FileInfo getCandiFileInfo(String fid) {
		// TODO Auto-generated method stub
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT FID 	");
		sql.append("	,FILENAME ");
		sql.append("	,FILEPATH ");
		sql.append("	FROM CANDIATTACHED_FILE ");
		sql.append("	WHERE FID = ? ");
		
		
		return getJdbcTemplate().queryForObject(sql.toString(),
				new Object[]{fid},
				new RowMapper<FileInfo>(){
				@Override
					public FileInfo mapRow(ResultSet rs, int arg1)
							throws SQLException {
						FileInfo fileInfo = new FileInfo();
						fileInfo.setFid(rs.getString("fid"));
						fileInfo.setFilename(rs.getString("filename"));
						fileInfo.setFilepath(rs.getString("filepath"));
						return fileInfo;
					}
				
		});
		
	}*/
	@Override
	public int insertAttachFile(FileInfo fileInfo) {
		return getSqlSession().insert(
				"net.javabugs.web.example.model.mapper.File.insertAttachFile", 
				fileInfo);
	}


	@Override
	public FileInfo getCandiFileInfo(String fid) {
		// TODO Auto-generated method stub
		return (FileInfo)getSqlSession().selectOne(
				"net.javabugs.web.example.model.mapper.File.getCandiFileInfo", 
				fid);
	}



	@Override
	public FileInfo getSubFileInfo(Candi candi) {
		// TODO Auto-generated method stub
		return (FileInfo) getSqlSession().selectOne(
				"net.javabugs.web.example.model.mapper.File.getSubFileInfo", 
				candi);
	}






	@Override
	public int insertCandiAttachFile(FileInfo fileInfo) {
		// TODO Auto-generated method stub
		return getSqlSession().insert(
				"net.javabugs.web.example.model.mapper.File.insertCandiAttachFile", 
				fileInfo);
	}






	@Override
	public int insertCandipAttachFile(FileInfo fileInfo) {
		// TODO Auto-generated method stub
		return getSqlSession().insert(
				"net.javabugs.web.example.model.mapper.File.insertCandipAttachFile", 
				fileInfo);
	}


	



}
