package com.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.runners.Parameterized.Parameter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.method.annotation.HttpHeadersReturnValueHandler;

import com.entity.Demande;
import com.entity.Refund;
import com.service.BookService;
import com.service.DeliveryService;
import com.service.DemandeService;
import com.service.RefundService;
import com.service.UserService;

@Controller
@RequestMapping("/refund")
public class RefundController 
{
	@Resource
	private UserService userService;
	@Resource
	private BookService bookService;
	@Resource
	private DemandeService demandeService;
	@Resource
	private DeliveryService deliveryService;
	@Resource
	private RefundService refundService;
	
	
	@ResponseBody
	@RequestMapping("addRefund")
	public String insertRefund(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="userId")String userId,@RequestParam(value="bookId")String bookId,@RequestParam(value="refundReason")String refundReason)
	{
		if(refundService.searchRefund(demandeId, bookId).size()==0)
		{
			Refund refund=new Refund();
			String dId=demandeId.split(":")[1].substring(1);
			String bId=bookId.split(":")[1].substring(1);
			refund.setDemandeId(dId);
			refund.setUserId(userId);
			refund.setBookId(bId);
			refund.setRefundReason(refundReason);
			Timestamp timestamp=new Timestamp(System.currentTimeMillis());
			refund.setBeginDate(timestamp);
			refund.setReturnMoney(null);
			refund.setAcceptRefund(0);
			refundService.insertRefund(refund);
			return "please waite for refund";
		}
		else
		{
			return "already add refund";
		}
	}
	

	@RequestMapping("inverseToRefund")
	public String inverseToRefund(){
		return "/refundInfo";
	}
	
	@ResponseBody
	@RequestMapping("listRefund_user")
	public Map<String,Object> listRefund_user(@RequestParam(value="userId")String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		List<Refund> refunds=refundService.searchRefundByUserId(userId);
		if(refunds.size()==0)
		{
			result.put("status", 0);
		}
		else
		{
			result.put("status", 1);
			result.put("refund", refunds);
			List<Demande> demandes=new ArrayList<Demande>();
			for(int i=0;i<refunds.size();i++)
			{
				String demandeId=refunds.get(i).getDemandeId();
				String bookId=refunds.get(i).getBookId();
				Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
				demandes.add(demande);
			}
			result.put("demande", demandes);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("listRefund_seller")
	public Map<String,Object> listRefund_seller(@RequestParam(value="sellerId")String sellerId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		List<Refund> refunds=refundService.searchRefundBySellerId(sellerId);
		if(refunds.size()==0)
		{
			result.put("status", 0);
		}
		else
		{
			result.put("status", 1);
			result.put("refund", refunds);
			List<Demande> demandes=new ArrayList<Demande>();
			for(int i=0;i<refunds.size();i++)
			{
				String demandeId=refunds.get(i).getDemandeId();
				String bookId=refunds.get(i).getBookId();
				Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
				demandes.add(demande);
			}
			result.put("demande", demandes);
		}
		return result;
	}
	
	
	@ResponseBody
	@RequestMapping("acceptRefund")
	public String acceptRefund(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId,@RequestParam(value="accept")String accept)
	{
		Refund refund=refundService.searchRefund(demandeId, bookId).get(0);
		int a=Integer.parseInt(accept);
		refund.setAcceptRefund(a);
		refundService.updateRefund(refund);
		return "OK";
	}
	
	@ResponseBody
	@RequestMapping("resolveOrNot")
	public String resolveOrNot(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId){
		Refund refund=refundService.searchRefund(demandeId, bookId).get(0);
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		refund.setReturnMoney(timestamp);
		refundService.updateRefund(refund);
		return "OK";
	}
}
