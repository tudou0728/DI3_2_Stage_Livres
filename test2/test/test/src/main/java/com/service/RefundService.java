package com.service;

import java.util.List;

import com.entity.Refund;

public interface RefundService 
{
	public List<Refund> searchRefund(String demandeId,String bookId);
	
	public void insertRefund(Refund refund);
	
	public void updateRefund(Refund refund);
	
	public List<Refund> searchRefundByUserId(String userId);
	
	public List<Refund> searchRefundBySellerId(String sellerId);
}
