package com.entity;

import java.io.Serializable;
import java.sql.Timestamp;

public class Comment implements Serializable
{
	private String demandeId;
	private String bookId;
	private String userId;
	private String bookComment;
	private float grade;
	private Timestamp commentDate;
	private String commentNo;
	
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
	public String getUserId()
	{
		return userId;
	}
	public void setUserId(String userId)
	{
		this.userId=userId;
	}
	public String getBookId()
	{
		return bookId;
	}
	public void setBookComment(String bookComment)
	{
		this.bookComment=bookComment;
	}
	public String getBookComment()
	{
		return bookComment;
	}
	public void setgrade(float grade)
	{
		this.grade=grade;
	}
	public float getgrade()
	{
		return grade;
	}
	public void setCommentDate(Timestamp commentDate)
	{
		this.commentDate=commentDate;
	}
	public Timestamp getCommentDate()
	{
		return commentDate;
	}
	public void setCommentNo(String commentNo)
	{
		this.commentNo=commentNo;
	}
	public String getCommentNo()
	{
		return commentNo;
	}
}
