package com.hana.gage.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface BaseStatsService {
	
	public List<HashMap<String ,String>> statsList(HashMap<String,String> map);
}
