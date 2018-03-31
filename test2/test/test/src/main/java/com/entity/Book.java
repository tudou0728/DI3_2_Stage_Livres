package com.entity;

import java.io.Serializable;

public class Book 
{
	private String bookId;
	private String bookName;
	private int bookQuantity;
	private float bookUnitPrice;
	private String bookSellerId;
	private String userName;
	private int sale;
	private int saleOrNot;
	
	public void setBookId(String bookId)
	{
		this.bookId=bookId;
	}
	public void setBookName(String bookName)
	{
		this.bookName=bookName;
	}
	public void setBookQuantity(int bookQuantity)
	{
		this.bookQuantity=bookQuantity;
	}
	public void setBookUnitPrice(float bookUnitPrice)
	{
		this.bookUnitPrice=bookUnitPrice;
	}
	
	public String getBookId()
	{
		return bookId;
	}
	public String getBookName()
	{
		return bookName;
	}
	public int getBookQuantity()
	{
		return bookQuantity;
	}
	public float getBookUnitPrice()
	{
		return bookUnitPrice;
	}
	public void setBookSellerId(String bookSellerId){
		this.bookSellerId=bookSellerId;
	}
	public String getBookSellerId(){
		return bookSellerId;
	}
	
	public void setUserName(String userName){
		this.userName=userName;
	}
	public String getUserName(){
		return userName;
	}
	public void setSale(int sale){
		this.sale=sale;
	}
	public int getSale(){
		return sale;
	}
	public void setSaleOrNot(int saleOrNot){
		this.saleOrNot=saleOrNot;
	}
	public int getSaleOrNot(){
		return saleOrNot;
	}
}
