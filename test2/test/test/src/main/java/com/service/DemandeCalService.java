package com.service;

import java.util.List;

import com.dao.DemandeCalDao;
import com.entity.DemandeCal;

public interface DemandeCalService 
{
	public List<DemandeCal> selectNumber(String userId,String sellerId);
	
	public void insertDemandeCal(DemandeCal demandeCal);
	
	public void updateDemandeCal(DemandeCal demandeCal);
	
	public void deleteDemandeCal(String demandeId);
	
	public void deleteDemandeCalBySellerId(String sellerId);
	
	public List<DemandeCal> selectNumberOnlyBySellerId(String sellerId);
}
