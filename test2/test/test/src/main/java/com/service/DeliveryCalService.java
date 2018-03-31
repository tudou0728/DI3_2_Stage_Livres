package com.service;

import java.util.List;

import com.entity.DeliveryCal;

public interface DeliveryCalService 
{
	public List<DeliveryCal> selectNumber(String sellerId,String userId);
	
	public void insertDeliveryCal(DeliveryCal deliveryCal);
	
	public void updateDeliveryCal(DeliveryCal deliveryCal);
	
	public void deleteDeliveryCal(String deliveryId);
	
	public List<DeliveryCal> selectNumberOnlyByUserId(String userId);
	
	public void deleteDeliveryCalOnlyByUserId(String userId);
}
