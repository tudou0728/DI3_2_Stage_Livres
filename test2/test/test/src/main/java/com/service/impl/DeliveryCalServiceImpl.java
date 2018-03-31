package com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.DeliveryCalDao;
import com.entity.DeliveryCal;
import com.service.DeliveryCalService;

@Service
public class DeliveryCalServiceImpl implements DeliveryCalService
{
	@Resource
	private DeliveryCalDao deliveryCalDao;
	
	public List<DeliveryCal> selectNumber(String sellerId,String userId)
	{
		return deliveryCalDao.selectNumber(sellerId, userId);
	}
	public void insertDeliveryCal(DeliveryCal deliveryCal)
	{
		deliveryCalDao.insertDeliveryCal(deliveryCal);
	}
	public void updateDeliveryCal(DeliveryCal deliveryCal)
	{
		deliveryCalDao.updateDeliveryCal(deliveryCal);
	}
	public void deleteDeliveryCal(String deliveryId)
	{
		deliveryCalDao.deleteDeliveryCal(deliveryId);
	}
	public List<DeliveryCal> selectNumberOnlyByUserId(String userId)
	{
		return deliveryCalDao.selectNumberOnlyByUserId(userId);
	}
	
	public void deleteDeliveryCalOnlyByUserId(String userId)
	{
		deliveryCalDao.deleteDeliveryCalOnlyByUserId(userId);
	}
}
