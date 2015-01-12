package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BaseStatsDaoImpl implements BaseStatsDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<HashMap<String,String>> statsList(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("baseStats.statsList" , map);
	}

}
