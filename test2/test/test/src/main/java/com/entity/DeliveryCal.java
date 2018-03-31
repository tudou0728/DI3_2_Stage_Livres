package com.entity;

public class DeliveryCal 
{
	private String userId;
	private String sellerId;
	private String deliveryId;
	private String bookId;
	
	public void setUserId(String userId){
		this.userId=userId;
	}
	public String getUserId(){
		return userId;
	}
	public void setSellerId(String sellerId){
		this.sellerId=sellerId;
	}
	public String getSellerId(){
		return sellerId;
	}
	public void setDeliveryId(String deliveryId){
		this.deliveryId=deliveryId;
	}
	public String getDeliveryId(){
		return deliveryId;
	}
	public void setbookId(String bookId){
		this.bookId=bookId;
	}
	public String getbookId(){
		return bookId;
	}
}
