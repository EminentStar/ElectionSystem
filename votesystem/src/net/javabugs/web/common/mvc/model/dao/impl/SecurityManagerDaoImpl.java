package net.javabugs.web.common.mvc.model.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import net.javabugs.web.common.mvc.model.dao.SecurityManagerDao;
import net.javabugs.web.common.mvc.model.dto.JavabugsUser;

/**
 * Extends the baseline Spring Security JdbcDaoImpl and load login user from custom user table.
 * 
 */
public class SecurityManagerDaoImpl extends JdbcDaoImpl implements SecurityManagerDao {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public UserDetails createUserDetails(String user_id, UserDetails userFromUserQuery, List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();

        if (!isUsernameBasedPrimaryKey()) {
            returnUsername = user_id;
        }
        JavabugsUser customUser = (JavabugsUser)userFromUserQuery;
        
        return new JavabugsUser(
        		returnUsername
        		, userFromUserQuery.getPassword()
        		, userFromUserQuery.isEnabled()
        		, true
        		, true
        		, true
        		, combinedAuthorities
        		, customUser.getUsers_name()
        		, customUser.getCell_phone()
        		, customUser.getDept_code()
        		, customUser.getEmail()
        		, customUser.getStudent_check()
        		);
	}
	
	@Override
	public List<UserDetails> loadUsersByUsername(String user_id) {
        return getJdbcTemplate().query(getUsersByUsernameQuery(), new String[] {user_id}, new RowMapper<UserDetails>() {
            public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
            	
                String user_id = rs.getString("user_id");
                String passwd = rs.getString("passwd");
                boolean enabled = rs.getBoolean("enabled");
                
                String users_name = rs.getString("users_name");           
                String cell_phone = rs.getString("cell_phone");
                String dept_code = rs.getString("dept_code");
                String email = rs.getString("email");
                String student_check=rs.getString("student_check");
                
             
                 //노란거 뜬애들도 지우고
               
                
                return new JavabugsUser(
                		user_id
                		, passwd
                		, enabled
                		, true
                		, true
                		, true
                		, loadUserAuthorities(user_id) //사용자의 권한을 로드한다?
                		, users_name
                		, cell_phone
                		, dept_code
                		, email
                		, student_check
                		);
            }
        });
	}
	
	public int changePassword(String username, String oldPasswd, String newPasswd) {
		JavabugsUser user = (JavabugsUser)loadUserByUsername(username);
		String oldEncodedPassword = passwordEncoder.encodePassword(oldPasswd, null);
		String currPassword = user.getPassword();
		int result =  -1;
		if(currPassword.equals(oldEncodedPassword)) {
			String encodedPasswd = passwordEncoder.encodePassword(newPasswd, null);
			result = getJdbcTemplate().update("UPDATE users SET passwd = ?, updated_dttm = NOW() WHERE user_id = ?", encodedPasswd, username);
		} 
		
		return result;
	}
	
	public int joinOut(String username, String password) {
		String encodedPassword = passwordEncoder.encodePassword(password, null);
		JavabugsUser user = (JavabugsUser)loadUserByUsername(username);
		int result =  -1;
		if(encodedPassword.equals(user.getPassword())) {
			result = getJdbcTemplate().update("UPDATE users SET leave_dttm = NOW(), enabled = 0, updated_dttm = NOW(), updater_id = ? WHERE user_id = ?", 
					user.getUsername(), user.getUsername());
		}
		return result;
	}
	
}
