package net.javabugs.web.example.model.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.example.model.dao.JoinDao;
import net.javabugs.web.example.model.dto.Dept;
import net.javabugs.web.example.model.dto.DeptParam;
import net.javabugs.web.example.model.dto.Join;
import net.javabugs.web.example.model.dto.JoinParam;

@Repository
public class JoinDaoImpl extends SqlSessionDaoSupport implements JoinDao{
	@Override
	public int createUser(JoinParam param) {
//		String deptCode = (String) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Join.selectDeptCode",param);
//		param.setDept_code(deptCode);
		return getSqlSession().insert("net.javabugs.web.example.model.mapper.Join.createUser",
				param);
		
	}
	
	

	@Override
	public int checkCid(JoinParam param) {
		return (Integer)getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Join.checkCid", 
				param);
		
	}


	@Override
	public int createUserAuthority(JoinParam param) {
		// TODO Auto-generated method stub
		param.setAuthorities_code(VSConstants.AUTH_ROLE_USER); //joinparam에 권한코드가들어감 -> 회원가입시 권한테이블에 들어갈때 쓰임
		
		return getSqlSession().insert(
				"net.javabugs.web.example.model.mapper.Join.createUserAuthority",
				param);
		
	}

	@Override
	public int getCountDeptList() {
		
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.Join.getCountDeptList");
	}

	@Override
	public List<DeptParam> getDeptList() {
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Join.getDeptList");
	}

	@Override
	public int getCountUserList(JoinParam joinParam) {
		// TODO Auto-generated method stub
		return (int) getSqlSession().selectOne("net.javabugs.web.example.model.mapper.User.getCountUserList",joinParam);
	}

	@Override
	public List<Join> getUserList(JoinParam joinParam) {
		// TODO Auto-generated method stub
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.User.getUserList",joinParam);
	}

	@Override
	public int updateAuthority(JoinParam joinParam) {
		return getSqlSession().update("net.javabugs.web.example.model.mapper.User.updateAuthority",joinParam);
	}
	
/*	@Override
	public List<Dept> getDeptParamList(DeptParam param){
		return getSqlSession().selectList("net.javabugs.web.example.model.mapper.Join.selectDeptCode",param);
	}*/
	
	
/*
	@Override
	public int createUserAuthority(JoinParam param) {
		param.setRole(VSConstants.AUTH_ROLE_USER); 
		return getSqlSession().insert("net.javabugs.web.example.model.mapper.Join.createUserAuthority", param);
	}
	*/
}
