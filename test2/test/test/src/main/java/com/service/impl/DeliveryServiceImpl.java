package com.service.impl;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.SessionTrackingMode;

import org.springframework.stereotype.Service;

import com.dao.DeliveryDao;
import com.entity.Delivery;
import com.entity.Demande;
import com.service.DeliveryService;

@Service
public class DeliveryServiceImpl implements DeliveryService
{
	@Resource
	private DeliveryDao deliveryDao;
	
	public List<Delivery> listDelivery()
	{
		return deliveryDao.listDelivery();
	}
	public void insertDelivery(Delivery delivery)
	{
		deliveryDao.insertDelivery(delivery);
	}
	public List<Delivery> searchDelivery(String deliveryId)
	{
		return deliveryDao.searchDelivery(deliveryId);
	}
	public void updateDelivery(Delivery delivery) {
		deliveryDao.updateDelivery(delivery);
	}
	public void deleteDelivery(String deliveryId)
	{
		deliveryDao.deleteDelivery(deliveryId);
	}
	public String setRandomDeliveryId()
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
		if(searchDelivery(string).size()==0 && string.charAt(0)!='0')
		{
			return string;
		}
		else
		{
			return setRandomDeliveryId();
		}
	}
	public List<Demande> demandeWaitingForDelivery(String sellerId)
	{
		return deliveryDao.demandeWaitingForDelivery(sellerId);
	}
	public List<Delivery>searchDeliveryByUserId(String userId)
	{
		return deliveryDao.searchDeliveryByUserId(userId);
	}
	public List<Delivery>searchDeliveryByDemandeId(String demandeId)
	{
		return deliveryDao.searchDeliveryByDemandeId(demandeId);
	}
	public List<Delivery> searchDeliveryByDidBid(String deliveryId,String bookId)
	{
		return deliveryDao.searchDeliveryByDidBid(deliveryId, bookId);
	}
	public List<Delivery> searchDeliveryByDidDid(String deliveryId,String demandeId)
	{
		return deliveryDao.searchDeliveryByDidDid(deliveryId, demandeId);
	}
	public List<Delivery> searchDeliveryByDeidBid(String demandeId,String bookId)
	{
		return deliveryDao.searchDeliveryByDeidBid(demandeId, bookId);
	}
}
