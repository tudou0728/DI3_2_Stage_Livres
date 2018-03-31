package com.service;

import java.util.List;

import com.entity.Delivery;
import com.entity.Demande;

public interface DeliveryService 
{
	public List<Delivery> listDelivery();
	public void insertDelivery(Delivery delivery);
	public List<Delivery> searchDelivery(String deliveryId);
	public void updateDelivery(Delivery delivery);
	public void deleteDelivery(String deliveryId);
	public String setRandomDeliveryId();
	public List<Demande> demandeWaitingForDelivery(String sellerId);
	public List<Delivery>searchDeliveryByUserId(String userId);
	public List<Delivery>searchDeliveryByDemandeId(String demandeId);
	public List<Delivery> searchDeliveryByDidBid(String deliveryId,String bookId);
	public List<Delivery> searchDeliveryByDeidBid(String demandeId,String bookId);
	public List<Delivery> searchDeliveryByDidDid(String deliveryId,String demandeId);
}
