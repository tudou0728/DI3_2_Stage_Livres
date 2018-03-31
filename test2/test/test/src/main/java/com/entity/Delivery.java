package com.entity;

import java.sql.Timestamp;
import java.util.List;

public class Delivery 
{
	private static final long serialVersionUID = 1L;
	private String deliveryId;
	private String demandeId;
	private String userId;
	private int signOrNot;
	private String deliveryAdress;
	private Timestamp createDate;
	private Timestamp arriveDate;
	private String nowArriveAt;
	private List<Demande> demandesForDelivery;
	private String bookId;
	
	public void setDeliveryId(String deliveryId)
	{
		this.deliveryId=deliveryId;
	}
	public String getDeliveryId()
	{
		return deliveryId;
	}
	
	public void setDemandeId(String demandeId)
	{
		this.demandeId=demandeId;
	}
	public String getDemandeId()
	{
		return demandeId;
	}
	
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	public String getUserId()
	{
		return userId;
	}
	
	public void setSignOrNot(int signOrNot)
	{
		this.signOrNot=signOrNot;
	}
	public int getSignOrNot()
	{
		return signOrNot;
	}
	
	public void setDeliveryAdress(String deliveryAdress)
	{
		this.deliveryAdress=deliveryAdress;
	}
	public String getDeliveryAdress()
	{
		return deliveryAdress;
	}
	
	public void setCreateDate(Timestamp createDate)
	{
		this.createDate=createDate;
	}
	public Timestamp getCreateDate()
	{
		return createDate;
	}
	
	public void setArriveDate(Timestamp arriveDate)
	{
		this.arriveDate=arriveDate;
	}
	public Timestamp getArriveDate()
	{
		return arriveDate;
	}
	public void setDemandesForDelivery(List<Demande>demandes){
		this.demandesForDelivery=demandes;
	}
	public List<Demande> getDemandesForDelivery(){
		return demandesForDelivery;
	} 
	public void setNowArriveAt(String nowArriveAt){
		this.nowArriveAt=nowArriveAt;
	}
	public String getNowArriveAt(){
		return nowArriveAt;
	}
	
	public void setBookId(String bookId){
		this.bookId=bookId;
	}
	public String getBookId(){
		return bookId;
	}
}
