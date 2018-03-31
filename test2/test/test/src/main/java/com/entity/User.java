package com.entity;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.List;;

public class User implements Serializable 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String userId;
	private String userName;
	private String passWord;
	private String userEnterprise;
	private Timestamp createDate;
	private Timestamp deleteDate;
	private List<Demande>demandes;
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public void setUserEnterprise(String enterprise)
	{
		this.userEnterprise=enterprise;
	}
	public String getUserEnterprise()
	{
		return userEnterprise;
	}
	public void setUserId(String id)
	{
		this.userId=id;
	}
	public String getUserId()
	{
		return userId;
	}
	public void setCreateDate(Timestamp time)
	{
		this.createDate=time;
	}
	public Timestamp getCreateDate()
	{
		return createDate;
	}
	public void setDeleteDate(Timestamp time)
	{
		this.deleteDate=time;
	}
	public Timestamp getDeleteDate()
	{
		return deleteDate;
	}
	public void setDemandes(List<Demande>demandes){
		this.demandes=demandes;
	}
	public List<Demande> getDemandes(){
		return demandes;
	}
}
