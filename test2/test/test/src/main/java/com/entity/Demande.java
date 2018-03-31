package com.entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Demande implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private String demandeId;
	private String bookId;
	private int quantity;
	private String userId;
	private Timestamp createDate;
	private float totalPrice;
	private int payOrNot;
	private String deliveryAdress;
	private int deliverOrNot;
	private int commentOrNot;

	public String getDemandeId()
	{
		return demandeId;
	}
	public void setDemandeId(String demandeId)
	{
		this.demandeId=demandeId;
	}
	
	public String getBookId()
	{
		return bookId;
	}
	public void setBookId(String bookId)
	{
		this.bookId=bookId;
	}
	
	public int getQuantity()
	{
		return quantity;
	}
	public void setQuantity(int quantity)
	{
		this.quantity=quantity;
	}
	
	public String getUserId()
	{
		return userId;
	}
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	
	public Timestamp getCreateDate()
	{
		return createDate;
	}
	public void setCreateDate(Timestamp createDate)
	{
		this.createDate=createDate;
	}
	
	public float getTotalPrice()
	{
		return totalPrice;
	}
	public void setTotalPrice(float totalPrice)
	{
		this.totalPrice=totalPrice;
	}
	
	public int getPayOrNot()
	{
		return payOrNot;
	}
	public void setPayOrNot(int payOrNot)
	{
		this.payOrNot=payOrNot;
	}
	public void setDeliveryAdress(String adress)
	{
		this.deliveryAdress=adress;
	}
	public String getDeliveryAdress()
	{
		return deliveryAdress;
	}
	public void setDeliverOrNot(int deliverOrNot)
	{
		this.deliverOrNot=deliverOrNot;
	}
	public int getDeliverOrNot()
	{
		return deliverOrNot;
	}
	public void setCommentOrNot(int commentOrNot)
	{
		this.commentOrNot=commentOrNot;
	}
	public int getCommentOrNot()
	{
		return commentOrNot;
	}
}
