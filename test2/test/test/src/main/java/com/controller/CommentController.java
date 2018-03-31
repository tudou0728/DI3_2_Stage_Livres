package com.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Comment;
import com.entity.Demande;
import com.service.BookService;
import com.service.CommentService;
import com.service.DeliveryCalService;
import com.service.DeliveryService;
import com.service.DemandeCalService;
import com.service.DemandeService;
import com.service.RefundService;
import com.service.UserService;

@Controller
@RequestMapping("/comment")
public class CommentController 
{
	@Resource
	private CommentService commentService;
	@Resource
	private UserService userService;
	@Resource
	private BookService bookService;
	@Resource
	private DemandeService demandeService;
	@Resource
	private DeliveryService deliveryService;
	@Resource
	private DeliveryCalService deliveryCalService;
	@Resource
	private DemandeCalService demandeCalService;
	@Resource
	private RefundService refundService;
	
	@ResponseBody
	@RequestMapping("insertComment")
	public String insertComment(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId,@RequestParam(value="userId")String userId,@RequestParam(value="bookComment")String bookComment,@RequestParam(value="grade")String grade)
	{
		Comment comment=new Comment();
		comment.setBookId(bookId.substring(1));
		comment.setDemandeId(demandeId.substring(1));
		comment.setUserId(userId);
		float t=Float.parseFloat(grade);
		comment.setgrade(t);
		comment.setBookComment(bookComment);
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		comment.setCommentDate(timestamp);
		int temp=commentService.searchCommentByBIdDid(demandeId, bookId).size();
		comment.setCommentNo(Integer.toString(temp+1));
		commentService.addComment(comment);
		
		Demande demande=demandeService.getDemandeByBookId(demandeId.substring(1), bookId.substring(1)).get(0);
		demande.setCommentOrNot(0);
		demandeService.updateDemande(demande);
		
		return "thanks for your comment.";
		
	}
	
	@RequestMapping("inverseToRefund")
	public String inverseToRefund()
	{
		return "/refund";
	}
	
	@ResponseBody
	@RequestMapping("listComment")
	public Map<String, Object>listComment(@RequestParam(value="bookId")String bookId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(commentService.searchCommentByBookId(bookId).size()==0)
		{
			result.put("status", 0);
			result.put("errorMsg", "no comments");
		}
		else
		{
			List<Comment> comments=commentService.searchCommentByBookId(bookId);
			result.put("status", 1);
			result.put("data", comments);
		}
		return result;
	}
}
