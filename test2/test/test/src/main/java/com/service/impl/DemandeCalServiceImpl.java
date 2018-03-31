package com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.DemandeCalDao;
import com.entity.DemandeCal;
import com.service.DemandeCalService;

@Service
public class DemandeCalServiceImpl implements DemandeCalService
{
	@Resource
	private DemandeCalDao demandeCalDao;
	
	public List<DemandeCal> selectNumber(String userId,String sellerId)
	{
		return demandeCalDao.selectNumber(userId, sellerId);
	}
	public void insertDemandeCal(DemandeCal demandeCal)
	{
		demandeCalDao.insertDemandeCal(demandeCal);
	}
	public void updateDemandeCal(DemandeCal demandeCal)
	{
		demandeCalDao.updateDemandeCal(demandeCal);
	}
	public void deleteDemandeCal(String demandeId)
	{
		demandeCalDao.deleteDemandeCal(demandeId);
	}
	public void deleteDemandeCalBySellerId(String sellerId)
	{
		demandeCalDao.deleteDemandeCalBySellerId(sellerId);
	}
	public List<DemandeCal> selectNumberOnlyBySellerId(String sellerId)
	{
		return demandeCalDao.selectNumberOnlyBySellerId(sellerId);
	}
}
