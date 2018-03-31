package com.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.DemandeDao;
import com.entity.Book;
import com.entity.Demande;
import com.service.DemandeService;


@Service
public class DemandeServiceImpl implements DemandeService
{
	@Resource
	private DemandeDao demandeDao;
	
	public List<Demande> listDemande()
	{
		return demandeDao.listDemande();
	}
	
	public List<Demande> listDemandeOrderByDate()
	{
		return demandeDao.listDemandeOrderByDate();
	}

	
	public List<Demande> getDemande(String demandeId)
	{
		return demandeDao.getDemande(demandeId);
	}
	
	public void insertDemande(Demande demande)
	{
		demandeDao.insertDemande(demande);
	}
	
	public void updateDemande(Demande demande)
	{
		demandeDao.updateDemande(demande);
	}
	
	public void deleteDemande(String demandeId,String bookId)
	{
		demandeDao.deleteDemande(demandeId, bookId);
		
	}
	public String setRandomDemandeId()
	{
		Random ran=new Random();
		int length=ran.nextInt(10)+1;
		String base="0123456789";
		Random random=new Random();
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<length;i++)
		{
			int eNumber=random.nextInt(base.length());
			buffer.append(base.charAt(eNumber));
		}
		String string=buffer.toString();
		if(getDemande(string).size()==0 && string.charAt(0)!='0')
		{
			return string;
		}
		else
		{
			return setRandomDemandeId();
		}
	}
	
	public List<Demande> getDemandeByUserOrderByDate(String userId)
	{
		return demandeDao.getDemandeByUserOrderByDate(userId);
	}
	
	public List<Demande> getDemandeByBookId(String demandeId,String bookId)
	{
		return demandeDao.getDemandeByBookId(demandeId, bookId);
	}
	
	public String inverseDemandeToString(Demande demande)
	{
		StringBuffer buffer=new StringBuffer();
		buffer.append("demandeId:");
		buffer.append(demande.getDemandeId());
		buffer.append("     ");
		buffer.append("userId:");
		buffer.append(demande.getUserId());
		buffer.append("     ");
		buffer.append("bookId:");
		buffer.append(demande.getBookId());
		buffer.append("     ");
		buffer.append("quantity:");
		buffer.append(demande.getQuantity());
		buffer.append("     ");
		buffer.append("totalPrice:");
		buffer.append(demande.getTotalPrice());
		buffer.append("     ");
		buffer.append("payOrNot:");
		if(demande.getPayOrNot()==1)
		{
			buffer.append("yes");
		}
		else 
		{
			if(demande.getPayOrNot()==0)
			{
				buffer.append("no");
			}
			else
			{
				buffer.append("annuler");
			}			
		}
		buffer.append(System.getProperty("line.separator"));
		buffer.append("createDate:");
		buffer.append(demande.getCreateDate());
		return buffer.toString();
	}
	
	public List<Demande> getDemandeNotPay(String id)
	{
		return demandeDao.getDemandeNotPay(id);
	}
	
	public List<Demande> getDemandeLikeDId(String demandeId,String userId)
	{
		return demandeDao.getDemandeLikeDId(demandeId,userId);
	}
	public void updateDemandeId(String newId,String oldId,String bookId)
	{
		demandeDao.updateDemandeId(newId, oldId, bookId);
	}
}
