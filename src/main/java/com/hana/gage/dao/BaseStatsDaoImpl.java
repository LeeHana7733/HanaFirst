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
	
	/**
	 *	자료통계 리스트
	 * 	inOutType [ outPayAll : 지출/전체 , outPayType : 지출/분류 , inPayAll : 수입/전체 , inPayType: 수입/분류 ,allStats :합산통계 ]
	 *	@param HashMap<String,String> map
	 *  @return List<HashMap<String,String>> 
	 */
	@Override
	public List<HashMap<String,String>> statsList(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		String sqlMapId		= "baseStatsList";
		String inOutType	= map.get("inOutType");
		if ("outPayAll".equals(inOutType) || "inPayAll".equals(inOutType)){
			return sqlSession.selectList("baseStats.baseStatsList" , map);
		}else if ("outPayType".equals(inOutType) || "inPayType".equals(inOutType)){
			return sqlSession.selectList("baseStats.baseStatsList" , map);
		}else{
			return sqlSession.selectList("baseStats.baseStatsList" , map);
		}
	}

}
