package com.hana.gage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.hana.gage.service.BaseStatsService;

@Controller
public class BaseStatsController {
	@Autowired
	private BaseStatsService baseStatsService; 
	
	@RequestMapping(value="/baseStats")
	public ModelAndView baseStatsView(@ModelAttribute HashMap<String ,String> map){
		ModelAndView mav	= new ModelAndView("baseStats");
		HashMap<String,String> resultMap	= new HashMap<String, String>();
		List<HashMap<String ,String>> result	= new ArrayList<HashMap<String ,String>>();
		
		result	= baseStatsService.statsList(map);
		resultMap.put("START_DATE", result.get(result.size()-1).get("START_DATE"));
		resultMap.put("END_DATE", result.get(result.size()-1).get("END_DATE"));
		result.remove(result.size()-1);
		
		mav.addObject("result" ,	result );
		mav.addObject("resultDate" , resultMap);
		mav.addObject("title", "자료통계");
		return mav;
	}
	
	@RequestMapping(value="/baseStatsList",  produces="text/plain; charset=UTF-8")
	public ModelAndView baseStatsList(@RequestParam HashMap<String,String> map){
		ModelAndView mav	= new ModelAndView();
		HashMap<String,String> resultMap	= new HashMap<String, String>();
		List<HashMap<String ,String>> result	= new ArrayList<HashMap<String ,String>>();
		
		result	= baseStatsService.statsList(map);
		resultMap.put("START_DATE", result.get(result.size()-1).get("START_DATE"));
		resultMap.put("END_DATE", result.get(result.size()-1).get("END_DATE"));
		result.remove(result.size()-1);
		
		mav.addObject("result" ,	result );
		mav.addObject("resultDate" , resultMap);
		mav.setViewName("jsonView");
		return mav;
	}
}
