package net.javabugs.web.example.model.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import net.javabugs.web.example.model.dao.BbsDAO;
import net.javabugs.web.example.model.dto.Post;
import net.javabugs.web.example.model.dto.PostParam;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.stereotype.Repository;

@Repository
public class BbsDAOImpl extends SqlSessionDaoSupport implements BbsDAO {

	@Override
	public List<Post> getPostList(PostParam param) { // 기존이랑 이름이같으니깐 매개변수만 바꿔주자
		// 우리가 해야되는것은 getJdbc@#$여기를 얻어서 쿼리를 날리면된다!

		return getSqlSession().selectList(
				"net.javabugs.web.example.model.mapper.Bbs.getPostList", param);
	}

	public Post getPost(PostParam param) {

		return (Post) getSqlSession().selectOne(
				"net.javabugs.web.example.model.mapper.Bbs.getPost", param);

	}

	@Override
	public int deletePost(PostParam postParam) {

		return getSqlSession().delete(
				"net.javabugs.web.example.model.mapper.Bbs.deletePost",
				postParam);

		// 여기서할껀 getJdbcTemplate얻어서 쿼리를 날리면 된다!
		// 쿼리 짜세요 DELETE FROM BBS WHERE num_bid = ?
		//
		// StringBuffer sql = new StringBuffer();
		// sql.append(" DELETE FROM BBS WHERE num_bid = ? ");
		//
		// return getJdbcTemplate().update(sql.toString() ,
		// new Object[]{ postParam.getNum_bid()});
	}

	@Override
	public int updatePost(PostParam postParam) {
		return getSqlSession().update(
				"net.javabugs.web.example.model.mapper.Bbs.updatePost",
				postParam);

		// 쿼리와 저밑에 파라미터부분만 수정하면 될 것 임
		// 쿼리는 SET 뭐뭐뭐들 들어가면 되겠죠? ?
		// StringBuffer sql = new StringBuffer();
		// sql.append("UPDATE BBS ");
		// sql.append(" SET	 TITLE = ? ");
		// sql.append(" 	,CONTENT = ? ");
		// sql.append(" 	,UPDATE_UID = ?  ");
		// sql.append(" 	,UPDATE_DTTM = SYSDATE  ");
		// sql.append(" 	WHERE NUM_BID = ?  ");
		//
		// return getJdbcTemplate().update(sql.toString(),
		// new Object[]{
		// postParam.getTitle(),
		// postParam.getContent(),
		// postParam.getUpdId(),
		// postParam.getNum_bid()
		// });
	}

	@Override
	public int insertPost(Post post) {
		return getSqlSession().insert(
				"net.javabugs.web.example.model.mapper.Bbs.insertPost", post);

		// StringBuffer sql = new StringBuffer();
		// sql.append(" INSERT INTO BBS ");
		// sql.append(" ( ");
		// sql.append(" TITLE ");
		// sql.append(" ,CONTENT ");
		// sql.append(" ,FID ");
		// sql.append(" ,CREATE_UID ");
		// sql.append(" ,CREATE_DTTM ");
		// sql.append(" ) ");
		// sql.append(" VALUES ");
		// sql.append(" ( ");
		// sql.append("  ? "); //TITLE
		// sql.append(" ,? "); //CONTENT
		// sql.append(" ,? "); //FID
		// sql.append(" ,? "); //CREATE_UID
		// sql.append(" ,SYSDATE "); //CREATE_DTTM
		// sql.append(" ) ");

		// cid랑 create_uid랑 겹치지않나?

		// return getJdbcTemplate().update(
		// sql.toString(),
		// new Object[]{
		// post.getTitle(),
		// post.getContent(),
		// post.getFid(), //postparam에 추가하던지 아니면 postparam이 아닌걸 받전지 해야된다! post엔
		// fid가 있죠?
		// post.getUsername()
		// });
	}

	@Override
	public int insertAttachFile(Post post) { // 이제 final일필요가없다! 그리고 서비스도 고쳐야함
		return getSqlSession().update(
				"net.javabugs.web.example.model.mapper.Bbs.insertAttachFile",
				post);
		// insert하고 fid를 찾아와야하는데 가장흔하게 쓰는게 select ATTACHED_FILE_SEQ from dual 해서
		// 가저와서
		// insert하고 여기도하고 저기도하고 하는데 그런데 트랜잭션안이라 뭐 롤백 @#$$뭐 한몸안인데? 스프링에서 지원 함?
		// generatedKeyHolder
		// GeneratedKeyHolder keyHolder = new GeneratedKeyHolder();
		// getJdbcTemplate().update(new PreparedStatementCreator() {
		// @Override
		// public PreparedStatement createPreparedStatement(Connection conn)
		// throws SQLException {
		// StringBuffer sql = new StringBuffer();
		// sql.append(" INSERT INTO ATTACHED_FILE");
		// sql.append(" ( ");
		// sql.append(" FID ");
		// sql.append(" ,FILENAME ");
		// sql.append(" ,FILEPATH ");
		// sql.append(" ) ");
		// sql.append(" VALUES ");
		// sql.append(" ( ");
		// sql.append(" ATTACHED_FILE_SEQ.NEXTVAL "); //FID
		// sql.append(" ,? "); //FILENAME
		// sql.append(" ,? "); //FILEPATH
		// sql.append(" ) ");
		//
		//
		// PreparedStatement pstmt = conn.prepareStatement(sql.toString(),
		// new String[]{"FID"});
		//
		// String fileName = null;
		// if(postParam.getTitle().length() < 5){
		// fileName = postParam.getTitle();
		// }else{
		// fileName = postParam.getTitle().substring(0,5);
		// }
		//
		// pstmt.setString(1, fileName); //익명클래스안에서 이걸쓰려면 매개변수에 final이여야한다
		// pstmt.setString(2, postParam.getAttachment().getOriginalFilename());
		//
		// return pstmt;
		// }
		// },keyHolder);
		// return keyHolder.getKey().intValue();
	}

	@Override
	public int getCountPostList(PostParam param) {
		return (Integer) getSqlSession().selectOne(
				"net.javabugs.web.example.model.mapper.Bbs.getCountPostList",
				param);
	}

}
