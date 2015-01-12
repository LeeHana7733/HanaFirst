package com.hana.gage.dao;

import java.util.HashMap;
import java.util.List;

public interface BaseStatsDao {
	public List<HashMap<String ,String>> statsList(HashMap<String,String> map);
}
