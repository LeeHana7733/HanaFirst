package com.hana.gage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hana.gage.dao.BaseStatsDao;

@Service("baseStatsService")
public class BaseStatsServiceImpl implements BaseStatsService {

	@Autowired
	private BaseStatsDao baseStatsDao;	
	
	@Override
	public List<HashMap<String, String>> statsList(HashMap<String,String> map) {
		
		List<HashMap<String ,String>> result	=  new ArrayList<HashMap<String,String>>();
		
		if (map.get("baseType") == null){
			map.put("baseType","W");
			map.put("inOutType", "outPayAll" );
		}
		if (map.get("inOutType").toUpperCase().indexOf("IN") > -1){
			map.put("spdType" , "IN");
		}else if (map.get("inOutType").toUpperCase().indexOf("OUT") > -1){
			map.put("spdType" , "OUT");
		}
		
		result	= baseStatsDao.statsList(map);
		
		map.put("START_DATE", result.get(0).get("LAST_DATE"));
		map.put("END_DATE", result.get(result.size()-1).get("LAST_DATE") );
		result.add(map);
		return result;
	}
}
