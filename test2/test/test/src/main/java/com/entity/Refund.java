package com.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import com.sun.tools.corba.se.idl.constExpr.Times;

public class Refund implements Serializable
{
	private String demandeId;
	private String bookId;
	private String userId;
	private String refundReason;
	private Timestamp beginDate;
	private int acceptRefund;
	private Timestamp returnMoney;
	
	public void setDemandeId(String demandeId)
	{
		this.demandeId=demandeId;
	}
	public String getDemandeId()
	{
		return demandeId;
	}
	public void setBookId(String bookId)
	{
		this.bookId=bookId;
	}
	public String getBookId()
	{
		return bookId;
	}
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	public String getUserId()
	{
		return userId;
	}
	public void setRefundReason(String refundReason)
	{
		this.refundReason=refundReason;
	}
	public String getRefundReason()
	{
		return refundReason;
	}
	public void setBeginDate(Timestamp beginDate)
	{
		this.beginDate=beginDate;
	}
	public Timestamp getBeginDate()
	{
		return beginDate;
	}
	public void setAcceptRefund(int acceptRefund)
	{
		this.acceptRefund=acceptRefund;
	}
	public int getAcceptRefund()
	{
		return acceptRefund;
	}
	public void setReturnMoney(Timestamp returnMoney)
	{
		this.returnMoney=returnMoney;
	}
	public Timestamp getReturnMoney()
	{
		return returnMoney;
	}
}
