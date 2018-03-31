package com.entity;

public class DemandeCal 
{
	private String userId;
	private String sellerId;
	private String demandeId;
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
	public void setdemandeId(String demandeId){
		this.demandeId=demandeId;
	}
	public String getdemandeId(){
		return demandeId;
	}
	public void setbookId(String bookId){
		this.bookId=bookId;
	}
	public String getbookId(){
		return bookId;
	}
}
