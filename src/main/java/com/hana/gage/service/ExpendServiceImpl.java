package com.hana.gage.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hana.gage.dao.ExpendDao;
import com.hana.gage.domain.HistoryVO;

@Service("expendService")
public class ExpendServiceImpl implements ExpendService{

	@Autowired
	private ExpendDao	expendDao;
	@Override
	public String mergeHistory(HistoryVO hist) {
		String result	= "���������� �����Ͽ����ϴ�";
		if (expendDao.mergeHistory(hist) == 1){
			result	= "���������� ����Ǿ����ϴ�.";
		}
		return result;
	}
	@Override
	public Map<String ,String> totalAmount(HistoryVO hist) {
		// TODO Auto-generated method stub
		if (hist.getSpdDate() == null || "".equals(hist.getSpdDate())){
			SimpleDateFormat	sdf	= new SimpleDateFormat("yyyy-MM-dd");
			hist.setSpdDate(sdf.format(new Date()));
		}
		return expendDao.totalAmount(hist);
	}
	@Override
	public List<HistoryVO> histInfo(HashMap<String,String> map) {
		// TODO Auto-generated method stub
		return expendDao.histInfo(map);
	}
	@Override
	public String deleteHist(String oid) {
		// TODO Auto-generated method stub
		String result	= "�������� ������ �����Ͽ����ϴ�";
		if (expendDao.deleteHist(oid) ==1 )
			result	= "�������� ���� �Ǿ����ϴ�.";
		return result;
	}
	@Override
	public List<HashMap<String, String>> histList(HistoryVO hist) {
		// TODO Auto-generated method stub
		return expendDao.histList(hist);
	}

}