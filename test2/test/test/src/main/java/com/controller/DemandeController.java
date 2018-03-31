package com.controller;

import java.security.KeyStore.LoadStoreParameter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.crypto.MacSpi;
import javax.print.attribute.Size2DSyntax;
import javax.servlet.http.HttpServletRequest;

import org.eclipse.jdt.internal.compiler.ast.FalseLiteral;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.sql.visitor.functions.Char;
import com.entity.Book;
import com.entity.Delivery;
import com.entity.DeliveryCal;
import com.entity.Demande;
import com.entity.DemandeCal;
import com.service.BookService;
import com.service.DeliveryCalService;
import com.service.DeliveryService;
import com.service.DemandeCalService;
import com.service.DemandeService;
import com.service.UserService;
import com.sun.jdi.PrimitiveType;

@Controller
@RequestMapping("demande")
public class DemandeController 
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
	private DeliveryCalService deliveryCalService;
	@Resource
	private DemandeCalService demandeCalService;
	
	
	@ResponseBody
	@RequestMapping("listDemande")//
	public Map<String, Object> listUserDemande(@RequestParam(value="userId")String userId)
	{	
		Map<String, Object> result=new HashMap<String,Object>();
		if(demandeService.getDemandeByUserOrderByDate(userId).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no demandes.");
		}
		else
		{
			List<Demande> demandes=demandeService.getDemandeByUserOrderByDate(userId);
			List<String> allDemande=new ArrayList<String>();
			for(Demande demande:demandes)
			{
				allDemande.add(demandeService.inverseDemandeToString(demande));
			}
			result.put("status", "1");
			result.put("data", demandes);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("listDemandeNotPay")//
	public Map<String, Object> listUserDemandeNotPay(@RequestParam(value="userId")String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(demandeService.getDemandeNotPay(userId).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no demandes");
		}
		else
		{
			List<Demande> demandes=demandeService.getDemandeNotPay(userId);
			result.put("status", "1");
			result.put("data", demandes);
		}	
		return result;
	}
	
	@ResponseBody
	@RequestMapping("demandeInfo")// 
	public Map<String, Object> userGetDemandeInfoByDemnandeId(@RequestParam(value="demandeId") String demandeId,@RequestParam(value="userId") String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if((demandeService.getDemande(demandeId).size()!=0) && (userId.equals(demandeService.getDemande(demandeId).get(0).getUserId())))
		{
			List<Demande> demandes=demandeService.getDemande(demandeId);
			result.put("status", "1");
			result.put("data", demandes);				
		}
		else
		{
			result.put("status", "0");
			result.put("errorMsg", "wrong demandeId.");
		}		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="getRandomDemandeId")//
	public String getRandomId()
	{
		String demandeId=demandeService.setRandomDemandeId();
		return demandeId;
	}
	
	@ResponseBody
	@RequestMapping("insertDemande")
	public String insertDemande(@RequestParam(value="bookId") String bookId,@RequestParam(value="quantity") String quantity,@RequestParam(value="demandeId") String demandeId,@RequestParam(value="userId") String userId)
	{
		String pattern="^[0-9]+";
		if(!quantity.matches(pattern)||quantity.charAt(0)=='0')
		{
			return "please input entity.";
		}
		else
		{		
			String temp=bookId.split(":")[1].trim();
			if(Integer.parseInt(quantity)>bookService.selectBooks(temp).get(0).getBookQuantity())
			{
				return "not enough books";
			}
			else
			{
				int num=Integer.parseInt(quantity);
				Demande demande=new Demande();
				demande.setBookId(temp);
				demande.setCommentOrNot(0);
				demande.setDeliverOrNot(0);
				demande.setDeliveryAdress(null);
				demande.setDemandeId(demandeId.replace("\"", ""));
				demande.setPayOrNot(0);
				demande.setQuantity(num);
				demande.setUserId(userId);
				demande.setTotalPrice(num * bookService.selectBooks(temp).get(0).getBookUnitPrice());
				demande.setCreateDate(new Timestamp(System.currentTimeMillis()));
				demandeService.insertDemande(demande);
				Book book=bookService.selectBooks(temp).get(0);
				book.setBookQuantity(book.getBookQuantity()-num);
				int bnum=book.getSale();
				book.setSale(bnum+num);
				bookService.updateBook(book);
				return "add demande successfully,demandeid: "+demandeId.replace("\"", "");
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value="verifyByDemandeId") //
	public String verifyDemende(@RequestParam(value="bookId") String bookId,@RequestParam(value="quantity") int quantity,@RequestParam(value="adress") String adress,@RequestParam(value="demandeId") String demandeId,@RequestParam(value="userId") String userId)
	{
		List<Book> books=bookService.selectBooks(bookId);
		Book book=books.get(0);
		int eNum=book.getBookQuantity();
		int sale=book.getSale();
		book.setSale(sale+quantity);
		book.setBookQuantity(eNum-quantity);
		bookService.updateBook(book);//更新书本信息
		//else
		//{
		if(adress.trim().isEmpty())
		{
			return "please input your adress.";
		}
		else
		{
			Demande userDemande=new Demande();
			Timestamp time=new Timestamp(System.currentTimeMillis());
			userDemande.setBookId(bookId);
			userDemande.setCreateDate(time);
			userDemande.setDemandeId(demandeId);
			userDemande.setPayOrNot(0);
			userDemande.setQuantity(quantity);
			userDemande.setUserId(userId);
			float fPrice=quantity*(book.getBookUnitPrice());
			userDemande.setTotalPrice(fPrice);
			userDemande.setDeliveryAdress(adress);
			userDemande.setDeliverOrNot(0);
			demandeService.insertDemande(userDemande);//添加demande
			return userDemande.getDemandeId();
		}
	}
	
	@ResponseBody
	@RequestMapping("insertDemandeCal")
	public void insertDemandeCal(String userId,String sellerId,String demandeId,String bookId)
	{
		DemandeCal demandeCal=new DemandeCal();
		demandeCal.setdemandeId(demandeId);; 
		demandeCal.setSellerId(sellerId);
		demandeCal.setUserId(userId);
		demandeCal.setbookId(bookId);
		demandeCalService.insertDemandeCal(demandeCal);
		//return "insert successfully.";
	}
	/*
	@ResponseBody
	@RequestMapping("updatetDemandeCal")
	public String updatetDemandeCal(String userId,String sellerId,Integer demandeNumber )
	{
		DemandeCal demandeCal=demandeCalService.selectNumber(userId, sellerId).get(0);
		demandeCal.setDemandeNumber(demandeNumber); 
		demandeCalService.updateDemandeCal(demandeCal); 
		return "update successfully.";
	}*/
	

	@ResponseBody
	@RequestMapping("infoDemandeCal")
	public Map<String, Object>infoDemandeCal(String sellerId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(demandeCalService.selectNumberOnlyBySellerId(sellerId).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no new information");
		}
		else 
		{
			List<DemandeCal> demandeCals=demandeCalService.selectNumberOnlyBySellerId(sellerId);
			result.put("status", "1");
			result.put("data", demandeCals);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("info")
	public Integer info(String sellerId)
	{
		if(demandeCalService.selectNumberOnlyBySellerId(sellerId).size()==0)
		{
			return 0;
		}
		else 
		{
			Integer num=0;
			List<DemandeCal> demandeCals=demandeCalService.selectNumberOnlyBySellerId(sellerId);
			for(int i=0;i<demandeCals.size();i++)
			{
				num=num+1;
			}
			return num;
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteInfo")
	public boolean deleteInfo(String sellerId)
	{
		if(demandeCalService.selectNumberOnlyBySellerId(sellerId).size()==0)
		{
			return false;
		}
		else 
		{
			demandeCalService.deleteDemandeCalBySellerId(sellerId);
			//System.out.println("12345");
			return true;
		}
	}
	
	@ResponseBody
	@RequestMapping("delete")
	public String deleteDemande(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId)
	{
		if(demandeId.isEmpty()||bookId.isEmpty()||demandeId.trim().isEmpty()||bookId.trim().isEmpty())
		{
			return "please input your information.";
		}
		else if(demandeService.getDemandeByBookId(demandeId, bookId).size()==0)
		{
			return "no such demande.";
		}
		else if(demandeService.getDemandeByBookId(demandeId, bookId).get(0).getPayOrNot()==1)
		{
			return "deja payer can't annuler.";
		}
		else 
		{
			Book book=bookService.selectBooks(bookId).get(0);
			int num=demandeService.getDemandeByBookId(demandeId, bookId).get(0).getQuantity();
			book.setBookQuantity(book.getBookQuantity()+num);
			book.setSale(book.getSale()-num);
			bookService.updateBook(book);
			demandeService.deleteDemande(demandeId, bookId);
			return "delete demande: " +demandeId+" bookId: "+bookId;
		}
	}
	
	@RequestMapping("toDeliverPay")
	public String toDeliverPay(){
		return "/payAndDeliver";
	}
	
	@ResponseBody
	@RequestMapping("demande")
	public Map<String, Object>demandeInfo(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId)
	{
		Map<String, Object>result=new HashMap<String,Object>();
		if(demandeService.getDemandeByBookId(demandeId, bookId).size()==0)
		{
			result.put("status", 0);
			result.put("errorMsg", "no such demande");
		}
		else
		{
			result.put("status", 1);
			result.put("data", demandeService.getDemandeByBookId(demandeId, bookId).get(0));
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("updateAdress")
	public String updateAdress(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId,@RequestParam(value="adress")String adress)
	{
		if(demandeService.getDemandeByBookId(demandeId, bookId).size()==0)
		{
			return "no such demande";
		}
		else
		{
			Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			demande.setDeliveryAdress(adress);
			demandeService.updateDemande(demande);
			return "update adress successfully.";
		}
	}
	
	@ResponseBody
	@RequestMapping("payUpdate")
	public String payUpdate(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="bookId")String bookId)
	{
		if(demandeService.getDemandeByBookId(demandeId, bookId).size()==0)
		{
			return "no such demande";
		}
		else
		{
			Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			if(demande.getPayOrNot()==1)
			{
				return "deja payer.";
			}
			else
			{
				demande.setPayOrNot(1);
				demandeService.updateDemande(demande);
				String seller=bookService.selectBooks(bookId).get(0).getBookSellerId();
				String user=demandeService.getDemandeByBookId(demandeId, bookId).get(0).getUserId();
				DemandeCal demandeCal=new DemandeCal();
				demandeCal.setbookId(bookId);
				demandeCal.setdemandeId(demandeId);
				demandeCal.setSellerId(seller);
				demandeCal.setUserId(user);
				demandeCalService.insertDemandeCal(demandeCal);
				return "pay successfully.";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping("getDemandeLikeDid")
	public Map<String, Object> getDemandeLikeDid(@RequestParam(value="demandeId")String demandeId,@RequestParam(value="userId")String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(demandeService.getDemandeLikeDId(demandeId, userId).size()==0)
		{
			result.put("status", 0);
			result.put("errorMsg", "no such demande");
		}
		else 
		{
			List<Demande>demandes=demandeService.getDemandeLikeDId(demandeId, userId);
			List<Integer> delivery=new ArrayList<Integer>();
			for(int i=0;i<demandes.size();i++)
			{
				if(deliveryService.searchDeliveryByDeidBid(demandes.get(i).getDemandeId(), demandes.get(i).getBookId()).size()==0)
				{
					delivery.add(0);
				}
				else
				{
					if(deliveryService.searchDeliveryByDeidBid(demandes.get(i).getDemandeId(), demandes.get(i).getBookId()).get(0).getArriveDate()!=null)
					{
						delivery.add(1);
					}
					else
					{
						delivery.add(0);
					}
				}
			}
			result.put("status", 1);
			result.put("data", demandes);
			result.put("delivery", delivery);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("updateAllDeAdress")
	public String updateAllDeAdress(@RequestParam(value="demande")String demande,@RequestParam(value="adress")String adress)
	{
		List<Demande> list=new ArrayList<Demande>();
		String[] dList=demande.split("&");
		for(int i=1;i+1<dList.length;i=i+3)
		{
			String demandeId=dList[i].split("=")[1];
			String bookId=dList[i+1].split("=")[1];
			Demande d=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			d.setDeliveryAdress(adress);
			demandeService.updateDemande(d);
			list.add(d);
		}
		return "update adress successfully.";
	}
	
	@ResponseBody
	@RequestMapping("allDepayUpdate")
	public String allDepayUpdate(@RequestParam(value="demande")String demande)
	{
		String[] list=demande.split("&");
		boolean decide=true;
		for(int i=1;i+1<list.length;i=i+3)
		{
			String demandeId=list[i].split("=")[1];
			String bookId=list[i+1].split("=")[1];
			Demande d=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			if(d.getPayOrNot()==0)
			{
				d.setPayOrNot(1);
				demandeService.updateDemande(d);
			}
			else
			{
				decide=false;
				break;
			}
		}
		if(decide==true)
		{
			return "pay successfully";
		}
		else
		{
			return "some demande deja payer, please return to the step before.";
		}
	}
	
	@ResponseBody
	@RequestMapping("changeDemandeId")
	public StringBuilder changeDemandeId(@RequestParam(value="demande")String demande)
	{
		List<Demande> list=new ArrayList<Demande>();
		List<Demande> list2=new ArrayList<Demande>();
		String[] dList=demande.split("&");
		for(int i=1;i+1<dList.length;i=i+3)
		{
			String demandeId=dList[i].split("=")[1];
			String bookId=dList[i+1].split("=")[1];
			Demande d=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
			list.add(d);
		}
		for(int m=0;m<list.size();m++)
		{
			list2.add(list.get(m));
			for(int n=0;n<m;n++)
			{
				if(list.get(m).getBookId().equals(list.get(n).getBookId()))
				{
					Demande demande2=list.get(n);
					int q1=list.get(n).getQuantity();
					int q2=list.get(m).getQuantity();
					list.get(n).setQuantity(q1+q2);
					float p1=list.get(n).getTotalPrice();
					float p2=list.get(m).getTotalPrice();
					list.get(n).setTotalPrice(p1+p2);
					demandeService.deleteDemande(list.get(m).getDemandeId(), list.get(m).getBookId());
					demande2.setQuantity(q1+q2);
					demande2.setTotalPrice(p1+p2);
					demandeService.updateDemande(demande2);
					list2.remove(list.get(m));
					break;
				}
				else
				{
					String t1=bookService.selectBooks(list.get(m).getBookId()).get(0).getBookSellerId();
					String t2=bookService.selectBooks(list.get(n).getBookId()).get(0).getBookSellerId();
					if(t1.equals(t2))
					{
						if(demandeService.getDemandeByBookId(list.get(n).getDemandeId(), list.get(m).getBookId()).size()==0)
						{
							demandeService.updateDemandeId(list.get(n).getDemandeId(), list.get(m).getDemandeId(), list.get(m).getBookId());
							list.get(m).setDemandeId(list.get(n).getDemandeId());
							break;
						}
						else
						{
							Demande tDemande=demandeService.getDemandeByBookId(list.get(n).getDemandeId(), list.get(m).getBookId()).get(0);
							tDemande.setQuantity(tDemande.getQuantity()+list.get(m).getQuantity());
							tDemande.setTotalPrice(tDemande.getTotalPrice()+list.get(m).getTotalPrice());
							demandeService.updateDemande(tDemande);
							demandeService.deleteDemande(list.get(m).getDemandeId(), list.get(m).getBookId());
							list2.remove(list.get(m));
							break;
						}
					}	
				}
			}
		}
		StringBuilder sBuffer=new StringBuilder();
		for(int j=0;j<list2.size();j++)
		{
			String seller=bookService.selectBooks(list2.get(j).getBookId()).get(0).getBookSellerId();
			String user=list2.get(j).getUserId();
			String bookId=list2.get(j).getBookId();
			String id=list2.get(j).getDemandeId();
			
			sBuffer.append("&demandeId=");
			sBuffer.append(id);
			sBuffer.append("&bookId=");
			sBuffer.append(bookId);
			sBuffer.append("&price=");
			sBuffer.append(list2.get(j).getTotalPrice());
			
			insertDemandeCal(user, seller, id,bookId);		
		}
		return sBuffer;
	}
}
