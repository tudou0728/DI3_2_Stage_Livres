package com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.RefundDao;
import com.entity.Refund;
import com.service.RefundService;

@Service
public class RefundServiceImpl implements RefundService
{
	@Resource
	private RefundDao refundDao;
	
	public List<Refund> searchRefund(String demandeId,String bookId)
	{
		return refundDao.searchRefund(demandeId, bookId);
	}
	
	public void insertRefund(Refund refund)
	{
		refundDao.insertRefund(refund);
	}
	
	public void updateRefund(Refund refund)
	{
		refundDao.updateRefund(refund);
	}
	public List<Refund> searchRefundByUserId(String userId)
	{
		return refundDao.searchRefundByUserId(userId);
	}
	public List<Refund> searchRefundBySellerId(String sellerId)
	{
		return refundDao.searchRefundBySellerId(sellerId);
	}
}
