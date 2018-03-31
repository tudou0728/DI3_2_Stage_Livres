package com.dao;

import java.util.List;

import com.entity.Comment;

public interface CommentDao 
{
	public List<Comment> searchCommentByBookId(String bookId);
	
	public void addComment(Comment comment);
	
	public void updateComment(Comment comment);
	
	public void deleteComment(String demandeId,String bookId,String commentNo);
	
	public List<Comment>searchCommentByBIdDid(String demandeId,String bookId);
}
