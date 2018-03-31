package com.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.dbcp.pool.PoolableObjectFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Delivery;
import com.entity.DeliveryCal;
import com.entity.Demande;
import com.service.BookService;
import com.service.DeliveryCalService;
import com.service.DeliveryService;
import com.service.DemandeCalService;
import com.service.DemandeService;
import com.service.UserService;
import com.sun.tools.internal.xjc.generator.bean.ImplStructureStrategy.Result;

@Controller
@RequestMapping("/delivery")
public class DeliveryController 
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
	private DemandeCalService demandeCalService;
	@Resource
	private DeliveryCalService deliveryCalService;
	
	@ResponseBody
	@RequestMapping("userSearchDeliveryByDeliveryId")//待测
	public Map<String, Object> searchDeliveryByDemandeId(@RequestParam(value="deliveryId") String deliveryId,@RequestParam(value="userId") String userId)
	{	
		Map<String, Object> result = new HashMap<String, Object>();	
		if(deliveryService.searchDelivery(deliveryId).size()>0 && (userId.equals(deliveryService.searchDelivery(deliveryId).get(0).getUserId())))
		{
			List<Delivery> deliverys=deliveryService.searchDelivery(deliveryId);
			result.put("status", "1");
			result.put("data", deliverys);
		}
		else
		{
			result.put("status", "0");
			result.put("errorMsg", "wrong demandeId.");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("searchDeliveryByUserIdForInformation")//
	public Map<String, Object> searchDeliveryByUserIdForInofrmation(@RequestParam(value="userId")String userId,@RequestParam(value="deliveryNumber")Integer deliveryNumber)
	{	
		Map<String, Object> result=new HashMap<String,Object>();
		//System.out.println(deliveryNumber);
		//System.out.println(listDelivery.size());
		if(deliveryService.searchDeliveryByUserId(userId).size()!= deliveryNumber)
		{
			//System.out.println("1234567");
			result.put("status", "1");
			result.put("data",deliveryService.searchDeliveryByUserId(userId).size());
		}
		else
		{
			result.put("status", "0");
			result.put("data",deliveryNumber);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("userSearchDeliveryByUserId")//
	public Map<String, Object> searchDeliveryByUserId(@RequestParam(value="userId")String userId)
	{	
		Map<String, Object> result=new HashMap<String,Object>();
		if(deliveryService.searchDeliveryByUserId(userId).size()==0)
		{
			result.put("status", "2");
			result.put("errorMsg","no such demandeId");
		}
		else
		{
			List<Delivery> deliverys=deliveryService.searchDeliveryByUserId(userId);
			result.put("status", "1");
			result.put("data", deliverys);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("searchDemandeToDeliver")
	public Map<String, Object> searchDemandeToDeliver(String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		List<Demande> demandes=new ArrayList<>();

		if(deliveryService.demandeWaitingForDelivery(userId).size()==0)
		{
			result.put("status", "2");
			result.put("errorMsg", "no demandes waiting for delivery");
		}
		else
		{
			int num;
			int size=deliveryService.demandeWaitingForDelivery(userId).size();
			for(num=0;num<size;num++)
			{
				String bookId=deliveryService.demandeWaitingForDelivery(userId).get(num).getBookId();
				if(userId.equals(bookService.selectBooks(bookId).get(0).getBookSellerId()))
				{
					demandes.add(deliveryService.demandeWaitingForDelivery(userId).get(num));
				}
			}
			result.put("status", "1");
			result.put("data",demandes);
		}	
		return result;
	}
	
	@ResponseBody
	@RequestMapping("startToDeliver")//
	public String starToDeliver(@RequestParam(value="demandeId") String demandeId,@RequestParam(value="bookId") String bookId,@RequestParam(value="deliveryId") String deliveryId,@RequestParam(value="userId") String userId)
	{
		if(demandeService.getDemandeByBookId(demandeId,bookId).size()==0)
		{
			return "wrong demandeId or bookId1.";
		}
		else
		{
			if(deliveryService.searchDeliveryByDidBid(deliveryId, bookId).size()>0)
			{
				return "wrong deliveryId.";
			}
			else if(userId.equals(bookService.selectBooks(bookId).get(0).getBookSellerId()))
			{
				String adress=demandeService.getDemandeByBookId(demandeId,bookId).get(0).getDeliveryAdress();
				Timestamp time=new Timestamp(System.currentTimeMillis());
				Delivery delivery=new Delivery();
				delivery.setCreateDate(time);
				delivery.setArriveDate(null);
				delivery.setDeliveryAdress(adress);
				delivery.setDeliveryId(deliveryId);
				delivery.setDemandeId(demandeId);
				delivery.setSignOrNot(0);
				delivery.setUserId(demandeService.getDemandeByBookId(demandeId,bookId).get(0).getUserId());
				delivery.setBookId(bookId);
				Demande demande=demandeService.getDemandeByBookId(demandeId,bookId).get(0);
				demande.setDeliverOrNot(1);
				demandeService.updateDemande(demande);
				deliveryService.insertDelivery(delivery);
				String uId=demandeService.getDemandeByBookId(demandeId,bookId).get(0).getUserId();
				
				insertDeliveryCal(uId, userId, deliveryId,bookId);
				
				return delivery.getDeliveryId()+"  starts to delivery.";
			}			
			else
			{
				return "wrong demandeId or bookId.";
			}
		}
	}
	
	/*有问题
	@ResponseBody
	@RequestMapping("startToDeliverRandomDeliveryId")
	public String randomDeliveryIdStarToDeliver(@RequestParam(value="demandeId") String demandeId)
	{
		String adress=demandeService.getDemande(demandeId).get(0).getDeliveryAdress();
		Timestamp time=new Timestamp(System.currentTimeMillis());
		Delivery delivery=new Delivery();
		delivery.setCreateDate(time);
		delivery.setArriveDate(null);
		delivery.setDeliveryAdress(adress);
		delivery.setDeliveryId(deliveryService.setRandomDeliveryId());
		delivery.setDemandeId(demandeId);
		delivery.setSignOrNot(0);
		delivery.setUserId(demandeService.getDemande(demandeId).get(0).getUserId());
		deliveryService.insertDelivery(delivery);
		return delivery.getDeliveryId()+"  starts to delivery.";
	}*/
	
	@ResponseBody
	@RequestMapping("nowArriveAt")
	public String updateArriveAt(@RequestParam(value="deliveryId") String deliveryId,@RequestParam(value="arriveAt") String arriveAt,String userId)
	{
		if(deliveryService.searchDelivery(deliveryId).size()==0)
		{
			return "wrong deliveryId.";
		}
		else
		{
			String bookId=deliveryService.searchDelivery(deliveryId).get(0).getBookId();
			String sellerId=bookService.selectBooks(bookId).get(0).getBookSellerId();
			if(sellerId.equals(userId))
			{
				for(int i=0;i<deliveryService.searchDelivery(deliveryId).size();i++)
				{
					bookId=deliveryService.searchDelivery(deliveryId).get(i).getBookId();
					Delivery delivery=deliveryService.searchDeliveryByDidBid(deliveryId, bookId).get(0);
					delivery.setNowArriveAt(arriveAt);
					deliveryService.updateDelivery(delivery);
				}
				return "update delivery arrive station successfully";
			}
			else
			{
				return "wrong deliveryId.";
			}
		}		
	}
	
	@ResponseBody
	@RequestMapping("insertDeliveryCal")
	public void insertDeliveryCal(String userId,String sellerId,String deliveryId,String bookId)
	{
		DeliveryCal deliveryCal=new DeliveryCal();
		deliveryCal.setDeliveryId(deliveryId);;
		deliveryCal.setSellerId(sellerId);
		deliveryCal.setUserId(userId);
		deliveryCal.setbookId(bookId);
		deliveryCalService.insertDeliveryCal(deliveryCal);
		//return "insert successfully.";
	}
	/*
	@ResponseBody
	@RequestMapping("updatetDeliveryCal")
	public String updatetDeliveryCal(String userId,String sellerId,Integer deliveryNumber )
	{
		DeliveryCal deliveryCal=deliveryCalService.selectNumber(sellerId, userId).get(0);
		deliveryCal.setDeliveryNumber(deliveryNumber);
		deliveryCalService.updateDeliveryCal(deliveryCal); 
		return "update successfully.";
	}*/
	
	@ResponseBody
	@RequestMapping("infoDeliveryCal")
	public Map<String, Object>infoDeliveryCal(String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(deliveryCalService.selectNumberOnlyByUserId(userId).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no new informations");
		}
		else 
		{
			result.put("status", "1");
			List<DeliveryCal> deliveryCals=deliveryCalService.selectNumberOnlyByUserId(userId);
			result.put("data", deliveryCals);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("info")
	public Integer info(String userId)
	{
		if(deliveryService.searchDeliveryByUserId(userId).size()==0)
		{
			return 0;
		}
		else 
		{
			//System.out.println("true");
			Integer num=0;
			List<DeliveryCal> deliveryCals=deliveryCalService.selectNumberOnlyByUserId(userId);
			int size=deliveryCals.size();
			for(int i=0;i<size;i++)
			{
				num=num+1;
			}
			return num;
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteInfo")
	public boolean deleteInfo(String userId)
	{
		if(deliveryCalService.selectNumberOnlyByUserId(userId).size()==0)
		{
			return false;
		}
		else 
		{
			deliveryCalService.deleteDeliveryCalOnlyByUserId(userId);
			//System.out.println("12345");
			return true;
		}
	}
	
	@ResponseBody
	@RequestMapping("demandeDelivery")
	public Map<String, Object> demandeDelivery(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId)
	{
		Map<String, Object>result=new HashMap<String,Object>();
		if(demandeService.getDemandeByBookId(demandeId, bookId).size()==0)
		{
			result.put("status1", 0);
			result.put("errorMsg", "no such demande");
		}
		else
		{
			Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			result.put("status1", 1);
			result.put("demande", demande);
			if(deliveryService.searchDeliveryByDeidBid(demandeId, bookId).size()==0)
			{
				result.put("status2", 0);
				result.put("errorMsg", "not deliver yet");
			}
			else
			{
				Delivery delivery=deliveryService.searchDeliveryByDeidBid(demandeId, bookId).get(0);
				result.put("status2", 1);
				result.put("delivery", delivery);
				Timestamp now=new Timestamp(System.currentTimeMillis());
				if(delivery.getSignOrNot()==0)
				{
					result.put("refund", 0);
					result.put("errorMsg2", "can not refund");
				}
				else 
				{
					long l1=now.getTime();
					long l2=delivery.getArriveDate().getTime();
					if((now.getTime()-delivery.getArriveDate().getTime())/(1000*60*60*24)>=3)
					{
						result.put("refund", 0);
						result.put("errorMsg2", "can not refund");
					}
					else
					{
						result.put("refund", 1);
					}
				}
			}
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("deliveryArrive")
	public String deliveryArrive(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId)
	{
		Delivery delivery=deliveryService.searchDeliveryByDeidBid(demandeId, bookId).get(0);
		Timestamp time=new Timestamp(System.currentTimeMillis());
		delivery.setArriveDate(time);
		delivery.setSignOrNot(1);
		deliveryService.updateDelivery(delivery);
		return "thanks for your using";
	}
}
