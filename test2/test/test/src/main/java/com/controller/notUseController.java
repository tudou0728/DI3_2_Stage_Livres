package com.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.ImportResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Book;
import com.entity.Demande;
import com.entity.User;
import com.service.BookService;
import com.service.DeliveryService;
import com.service.DemandeService;
import com.service.UserService;

@Controller
@RequestMapping("/beiYong")
public class notUseController 
{
	@Resource
	private UserService userService;
	@Resource
	private BookService bookService;
	@Resource
	private DemandeService demandeService;
	@Resource
	private DeliveryService deliveryService;
	
	private HttpSession session;
	
	@ResponseBody
	@RequestMapping("listDemande")//
	public Map<String, Object> listUserDemande(HttpServletRequest request)
	{	
		Map<String, Object> result=new HashMap<String,Object>();
		if(request.getSession(false)==null || session==null)
		{
			result.put("status", "0");
			result.put("errorMsg", "please log in again.");
		}
		else
		{
			String id=(String) session.getAttribute("userId");
			if(demandeService.getDemandeByUserOrderByDate(id).size()==0)
			{
				result.put("status", "0");
				result.put("errorMsg", "no demandes.");
			}
			else
			{
				List<Demande> demandes=demandeService.getDemandeByUserOrderByDate(id);
				List<String> allDemande=new ArrayList<String>();
				for(Demande demande:demandes)
				{
					allDemande.add(demandeService.inverseDemandeToString(demande));
				}
				result.put("status", "1");
				result.put("data", demandes);
			}
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("shiyishi")
	public String shishi(@RequestParam(value="s1")String s1,@RequestParam(value="s2")String s2)
	{
		return "phrase1:"+s1+" "+"phrase2:"+s2;
	}
	
	@ResponseBody
	@RequestMapping("/{userId}/{userPassword}/logIn")
	public String users(@PathVariable String userId, @PathVariable String userPassword,HttpServletRequest request)
	{
		session=request.getSession();
		//session.setMaxInactiveInterval(10*60);
		String sessionId=session.getId();
		User u=new User();
		u.setUserId(userId);
		u.setPassWord(userPassword);
		try{
			if(userService.userLogIn(userId,userPassword).size() ==1)
			{
				u=userService.userLogIn(userId, userPassword).get(0);
				session.setAttribute("userName", u.getUserName());
				session.setAttribute("userId", userId);
				session.setAttribute("userPassword", userPassword);	
				System.out.println(u.getUserName());
				return u.getUserName()+ ", welcome to your homepage! your sessionID:"+sessionId;
			}
			else
			{
				throw new Exception("wrong id or password.");
			}
		}
		catch(Exception e)
		{
			return e.getMessage();
		}
	}
	/*
	@ResponseBody
	@RequestMapping("test")
	public String haha()
	{		
		List<User> users = userService.getUser();
		return users.get(0).getUserName();
	}*/
	
	/*
	@ResponseBody
	@RequestMapping("password")
	public String getpassword(@PathVariable String userName)
	{
		return userService.getPassword(userName);
	}*/
	
	@ResponseBody
	@RequestMapping("list")
	public String hehe(HttpServletRequest request)
	{
		if(request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			String userId = (String) session.getAttribute("userId");
			String userName = (String) session.getAttribute("userName");
			String password =(String) session.getAttribute("userPassword");
			System.out.println("userId:"+userId);
			System.out.println("userName"+userName);
			System.out.println("password"+password);
			return "";
		}
	}
	/*
	@ResponseBody
	@RequestMapping("/{userName}/{userPassword}/{enterprise}/create")
	public String userCreate(@PathVariable String userName, @PathVariable String userPassword,@PathVariable String enterprise)
	{
		if(!userService.isCharNum(userPassword))
		{
			return "password can only use character or number.";
		}
		else
		{
			if(userService.verifyUserName(userName)== 0)
			{				
				User u=new User();
				u.setUserId(userService.setRandomUserId(2));
				u.setUserName(userName);
				u.setPassWord(userPassword);
				u.setUserEnterprise(enterprise);
				Timestamp time=new Timestamp(System.currentTimeMillis());
				u.setCreateDate(time);
				u.setDeleteDate(null);
				userService.insertUser(u);
				return "welcome! your userId:"+u.getUserId();
			}
			else
			{
				return "please change another name.";
			}
		}
	}*/
	/*
	@ResponseBody
	@RequestMapping("/modifyName/{userChangeName}")
	public String changeName(@PathVariable String userChangeName,HttpServletRequest request)//必须要有@PathVariable
	{		
		if(request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			String id=(String)session.getAttribute("userId");
			String password=(String)session.getAttribute("userPassword");
			List<User> users=userService.userLogIn(id,password);
			User u=users.get(0);
			u.setUserName(userChangeName);
			userService.updateUser(u);			
			return "change name successfully!";
		}
	}*/
	/*
	@ResponseBody
	@RequestMapping("/modifyPassword/{userChangePassword}")
	public String changePassword(@PathVariable String userChangePassword,HttpServletRequest request)
	{
		if(request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			if(!userService.isCharNum(userChangePassword))
			{
				return "password can only use character or number.";
			}
			else
			{
				String id=(String)session.getAttribute("userId");
				String password=(String)session.getAttribute("userPassword");
				List<User> users=userService.userLogIn(id,password);
				User u=users.get(0);
				u.setPassWord(userChangePassword);
				userService.updateUser(u);	
				return "change password successfully!";
			}
		}
	}*/
	@RequestMapping(value="hehe1",method = RequestMethod.GET)
	public String  url()
	{
		System.out.println("11111");
		return "/hehe";
	}
	
	/*@ResponseBody
	@RequestMapping(value="/{bookId}/{quantity}/buy") 
	public void buyBooks(@PathVariable String bookId,@PathVariable int quantity)
	{
		List<Book> books=bookService.selectBooks(bookId);
		Book book=books.get(0);
		int eNum=book.getBookQuantity();
		book.setBookQuantity(eNum-quantity);
		bookService.updateBook(book);
		float cost=quantity*(book.getBookUnitPrice());
		System.out.println("buy successfully! cost:"+cost);;
	}*/
	@ResponseBody
	@RequestMapping(value="/{bookId}/{quantity}/{adress}/verify") 
	public String verifyDemende2(@PathVariable String bookId,@PathVariable int quantity,@PathVariable String adress)
	{
		List<Book> books=bookService.selectBooks(bookId);
		Book book=books.get(0);
		int eNum=book.getBookQuantity();
		book.setBookQuantity(eNum-quantity);
		bookService.updateBook(book);//更新书本信息
		
		String userId=(String) session.getAttribute("userId");
		Timestamp time=new Timestamp(System.currentTimeMillis());
		String demandeId=demandeService.setRandomDemandeId();
		Demande userDemande=new Demande();
		userDemande.setBookId(bookId);
		userDemande.setCreateDate(time);
		userDemande.setDemandeId(demandeId);
		userDemande.setPayOrNot(0);
		userDemande.setQuantity(quantity);
		userDemande.setUserId(userId);
		float fPrice=quantity*(books.get(0).getBookUnitPrice());
		userDemande.setTotalPrice(fPrice);
		userDemande.setDeliveryAdress(adress);
		demandeService.insertDemande(userDemande);//添加demande
		return userDemande.getDemandeId();
	}
	/*
	@ResponseBody
	@RequestMapping("/{order}/buy")//可完善
	public String buy(@PathVariable String order)
	{
		String userId=(String) session.getAttribute("userId");
		Timestamp time=new Timestamp(System.currentTimeMillis());
		String demandeId=demandeService.setRandomDemandeId();
		String[] orders=order.split("\\.");
		for(int i=0;i<orders.length;i++)
		{
			String[] demande=orders[i].split(",");
			String id=demande[0];
			int num=Integer.parseInt(demande[1]);
			buyBooks(id, num);
			List<Book>books=bookService.selectBooks(id);
			Demande userDemande=new Demande();
			userDemande.setBookId(id);
			userDemande.setCreateDate(time);
			userDemande.setDemandeId(demandeId);
			userDemande.setPayOrNot(0);
			userDemande.setQuantity(num);
			userDemande.setUserId(userId);
			float fPrice=num*(books.get(0).getBookUnitPrice());
			userDemande.setTotalPrice(fPrice);
			demandeService.insertDemande(userDemande);
			System.out.println(orders[i]);
		}
		System.out.println("over");
		return "order num:"+demandeId;
	}*/
	
	@ResponseBody
	@RequestMapping("/{demandeId}/info")//可完善
	public List<String> getDemandeInfo(@PathVariable String demandeId)
	{
		String userId=(String) session.getAttribute("userId");
		List<Demande> demandes=demandeService.getDemande(demandeId);
		List<String> orders=new ArrayList<String>();
		float fPrice=0;
		for(Demande demande:demandes)
		{
			orders.add(demandeService.inverseDemandeToString(demande));
			fPrice=fPrice+demande.getTotalPrice();
		}
		return orders;
	}
	
	/*
	@ResponseBody
	@RequestMapping("/{demandeId}/demandeInfo")//可完善
	public List<Demande> userGetDemandeInfoByDemnandeId(@PathVariable String demandeId)
	{
		//String userId=(String) session.getAttribute("userId");
		List<Demande> demandes=demandeService.getDemande(demandeId);
		return demandes;
	}*/
	
	/*
	@ResponseBody
	@RequestMapping("/{demandeId}/pay")//可完善
	public String payDemande(@PathVariable String demandeId)
	{
		String userId=(String) session.getAttribute("userId");	
		List<Demande> demandes=demandeService.getDemande(demandeId);
		float fPrice=0;
		for(Demande demande:demandes)
		{
			demande.setPayOrNot(1);
			demandeService.updateDemande(demande);
			fPrice=fPrice+demande.getTotalPrice();
			//System.out.println(demande.getTotalPrice());
		}
		return "pay successfully:"+fPrice;
	}*/
	
	@ResponseBody
	@RequestMapping("/{demandeId}/deleteAll")//可完善 待调试
	public String userDeleteDemande(@PathVariable String demandeId)
	{
		String userId=(String) session.getAttribute("userId");	
		List<Demande> demandes=demandeService.getDemande(demandeId);
		for(Demande demande:demandes)
		{
			demandeService.deleteDemande(demandeId,demande.getBookId());
		}
		return "delete successfully:"+demandeId;
	}
	
	@ResponseBody
	@RequestMapping("/{demandeId}/{bookId}/{quantity}/modify") 
	public String modifyDemande(@PathVariable String demandeId,@PathVariable String bookId,@PathVariable String quantity)
	{
		int num=Integer.parseInt(quantity);
		Demande demande=demandeService.getDemandeByBookId(demandeId, bookId).get(0);
		demande.setQuantity(num);
		demandeService.updateDemande(demande);
		return "change demande successfully"+demandeService.inverseDemandeToString(demande);
	} 
	/*
	@ResponseBody
	@RequestMapping("/{deliveryId}/arrive")
	public String signDelivery(@PathVariable String deliveryId)
	{
		Delivery delivery=deliveryService.searchDelivery(deliveryId).get(0);
		delivery.setSignOrNot(1);
		Timestamp timestamp=new Timestamp(System.currentTimeMillis());
		delivery.setArriveDate(timestamp);
		deliveryService.updateDelivery(delivery);
		return "thanks for your using delivery.";
	}*/
	
	 /*
		@ResponseBody
		@RequestMapping("/{demandeId}/startToDeliver")
		public String starToDeliver(@PathVariable String demandeId)
		{
			String adress=demandeService.getDemande(demandeId).get(0).getDeliveryAdress();
			Timestamp time=new Timestamp(System.currentTimeMillis());
			Delivery delivery=new Delivery();
			delivery.setCreateDate(time);
			delivery.setArriveDate(null);
			delivery.setDeliveryAdress(adress);
			delivery.setDeliveryId(deliveryService.setRandomDeliveryId(4));
			delivery.setDemandeId(demandeId);
			delivery.setSignOrNot(0);
			delivery.setUserId(demandeService.getDemande(demandeId).get(0).getUserId());
			deliveryService.insertDelivery(delivery);
			return delivery.getDeliveryId()+"  starts to delivery.";
		} */
		
	/*
	@ResponseBody
	@RequestMapping("/{deliveryId}/{arriveAt}/nowArriveAt")
	public String updateArriveAt(@PathVariable String deliveryId,@PathVariable String arriveAt)
	{
		Delivery delivery=deliveryService.searchDelivery(deliveryId).get(0);
		delivery.setNowArriveAt(arriveAt);
		deliveryService.updateDelivery(delivery);
		return "update delivery arrive station successfully";
	}*/
	
	/*
	function allDemande(){
		document.getElementById("userAllDemandes_table").innerHTML="";
		var table=$('<table border="1">');
		table.appendTo($("#userAllDemandes_table"));
		var row1=$('<tr></tr>');
		row1.append('<th width=200 id="range_demandeByUser">序号</th>');
		row1.append('<th width=200 id="demandeIdSearchDemande">demandeId</th>');
		row1.append('<th width=200 id="userIdSearchDemande">userId</th>');
		row1.append('<th width=200 id="bookNameSearchDemande">bookName</th>');
		row1.append('<th width=200 id="quantitySearchDemande">quantity</th>');
		row1.append('<th width=200 id="totalPriceSearchDemande">totalPrice</th>');
		row1.append('<th width=200 id="createDateSearchDemande">createDate</th>');
		row1.append('<th width=200 id="deliveryAdressSearchDemande">deliveryAdress</th>');
		row1.appendTo(table);	
		$.ajax({
			url:"http://localhost:8080/test/user/listDemande.do",
			type:'GET',
			async:false,
			dataType:'json',
			success:function(result){
				var number;
				if(result['status']!="1")
				{
					alert(result['errorMsg']);
					document.getElementById("number_allDemande").innerHTML="0 条记录";
				}
				else
				{
				$(result['data']).each(function(i){
					//var rowLength=$("table tr").length;
					var rowId="row";
					var range_demandeByUser="range_demandeByUser";
					var demandeIdSearchDemande="demandeIdSearchDemande";
					var userIdSearchDemande="userIdSearchDemande";
					var bookNameSearchDemande="bookNameSearchDemande";
					var quantitySearchDemande="quantitySearchDemande";
					var totalPriceSearchDemande="totalPriceSearchDemande";
					var createDateSearchDemande="createDateSearchDemande";
					var deliveryAdressSearchDemande="deliveryAdressSearchDemande";

					rowId=rowId+(i+1);
					range_demandeByUser=range_demandeByUser+(i+1);
					demandeIdSearchDemande=demandeIdSearchDemande+(i+1);
					userIdSearchDemande=userIdSearchDemande+(i+1);
					bookNameSearchDemande=bookNameSearchDemande+(i+1);
					quantitySearchDemande=quantitySearchDemande+(i+1);
					totalPriceSearchDemande=totalPriceSearchDemande+(i+1);
					createDateSearchDemande=createDateSearchDemande+(i+1);
					deliveryAdressSearchDemande=deliveryAdressSearchDemande+(i+1);
					var dId=result['data'][i].demandeId;
					//alert(dId);
					
					var row=$('<tr id="'+rowId+'"></tr>');
					row.append('<td id="'+range_demandeByUser+'">'+(i+1)+'</td>');
					row.append('<td id="'+demandeIdSearchDemande+'">'+dId+'</td>');
					var a=result['data'][i].userId;
					row.append('<td id="'+userIdSearchDemande+'">'+a+'</td>');//
					
					var b=result['data'][i].bookId;
					var bookName;
					$.ajax({
						url:"http://localhost:8080/test/user/readBookName.do",
						type:'POST',
						async:false,
						data:{bookId:b},
						dataType:'json',
						success:function(result){
							//alert(b);
							bookName=JSON.stringify(result);
						},
						error:function(){
							alert('error2.');
						}
					});
					
					row.append('<td id="'+bookNameSearchDemande+'">'+bookName+'</td>');//
					
					var c=result['data'][i].quantity;
					row.append('<td id="'+quantitySearchDemande+'">'+c+'</td>');//
					var d=result['data'][i].totalPrice;
					row.append('<td id="'+totalPriceSearchDemande+'">'+d+'</td>');//
					var e=result['data'][i].createDate;
					var time=new Date(e).toLocaleString().substring(0, 19)
					row.append('<td id="'+createDateSearchDemande+'">'+time+'</td>');//
					var f=result['data'][i].deliveryAdress;
					row.append('<td id="'+deliveryAdressSearchDemande+'">'+f+'</td>');//
					
					row.appendTo(table);
					number=i+1;
				});
				 $("#userAllDemandes_table").append("</table>");
				 document.getElementById("number_allDemande").innerHTML=number+" 条记录";
				}
			},
			error:function(){
				alert('error3.');
			}
		});
	}*/
	
	/*
	@ResponseBody
	@RequestMapping("listDemandeNotPay")//
	public Map<String, Object> listUserDemandeNotPay(HttpServletRequest request)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(session==null || request.getSession(false)==null)
		{
			result.put("status", "0");
			result.put("errorMsg", "please log in again.");
		}
		else
		{
			String id=(String) session.getAttribute("userId");
			if(demandeService.getDemandeNotPay(id).size()==0)
			{
				result.put("status", "0");
				result.put("errorMsg", "no demandes");
			}
			else
			{
				List<Demande> demandes=demandeService.getDemandeNotPay(id);
				result.put("status", "1");
				result.put("data", demandes);
			}
		}
		
		return result;
	}*/
}
