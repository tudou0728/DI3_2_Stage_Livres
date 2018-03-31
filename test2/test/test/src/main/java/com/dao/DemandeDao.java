package com.dao;

import java.sql.Timestamp;
import java.util.List;

import com.entity.Book;
import com.entity.Demande;

public interface DemandeDao 
{
	public List<Demande> listDemande();
	public List<Demande> listDemandeOrderByDate();
	
	public List<Demande> getDemande(String demandeId);
	
	public void insertDemande(Demande demande);
	
	public void updateDemande(Demande demande);
	
	public void deleteDemande(String demandeId,String bookId);
	
	public List<Demande> getDemandeByUserOrderByDate(String userId);
	
	public List<Demande> getDemandeByBookId(String demandeId,String bookId);
	
	public List<Demande> getDemandeNotPay(String id);
	
	public List<Demande> getDemandeLikeDId(String demandeId,String userId);
	
	public void updateDemandeId(String newId,String oldId,String bookId);
}
