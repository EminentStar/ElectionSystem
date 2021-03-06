package net.javabugs.web.example.model.dao;

import java.util.List;

import net.javabugs.web.example.model.dto.DeptParam;
import net.javabugs.web.example.model.dto.Join;
import net.javabugs.web.example.model.dto.JoinParam;

public interface JoinDao {
	
	
	public int createUser(JoinParam param);
	
	public int checkCid(JoinParam param);
	
	public int createUserAuthority(JoinParam param); //이렇게 만들자!

	public int getCountDeptList();

	public List<DeptParam> getDeptList();

	public int getCountUserList(JoinParam joinParam);

	public List<Join> getUserList(JoinParam joinParam);

	public int updateAuthority(JoinParam joinParam);
}
