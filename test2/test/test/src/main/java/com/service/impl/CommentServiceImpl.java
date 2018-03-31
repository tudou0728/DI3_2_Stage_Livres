package com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.dao.CommentDao;
import com.entity.Comment;
import com.service.CommentService;

@Service
public class CommentServiceImpl implements CommentService
{
	@Resource
	private CommentDao commentDao;
	
	public List<Comment> searchCommentByBookId(String bookId)
	{
		return commentDao.searchCommentByBookId(bookId);
	}
	public void addComment(Comment comment)
	{
		commentDao.addComment(comment);
	}
	public void updateComment(Comment comment)
	{
		commentDao.updateComment(comment);
	}
	public void deleteComment(String demandeId,String bookId,String commentNo)
	{
		commentDao.deleteComment(demandeId, bookId, commentNo);
	}
	public List<Comment>searchCommentByBIdDid(String demandeId,String bookId)
	{
		return commentDao.searchCommentByBIdDid(demandeId, bookId);
	}
}
