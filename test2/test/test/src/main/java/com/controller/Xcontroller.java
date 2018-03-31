package com.controller;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Delivery;
import com.entity.Demande;
import com.entity.DemandeCal;
import com.entity.User;
import com.service.BookService;
import com.service.DeliveryCalService;
import com.service.DeliveryService;
import com.service.DemandeCalService;
import com.service.DemandeService;
import com.service.UserService;

@Controller
@RequestMapping("/user")
public class Xcontroller  
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
	
	private HttpSession session;
	
	@ResponseBody
	@RequestMapping("hehe")
	public String hehe(HttpServletRequest request){
		String path = request.getContextPath();  
		String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		return basePath;
	}
	
	
	@ResponseBody
	@RequestMapping("verifySession")
	public Map<String, Object> verifySession(HttpServletRequest request)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		//System.out.println(session!=null);
		//System.out.println(request.getSession(false)!=null);
		if( (session!=null && session.getAttribute("userName")!=null) && (request.getSession(false)!=null))
		{
			result.put("status", "1");
			result.put("userId", session.getAttribute("userId"));
			result.put("userName", session.getAttribute("userName"));
			System.out.println(session.getAttribute("userName"));
		}
		else
		{	
			result.put("status","0");
			result.put("errorMsg", "please log in again");
			System.out.println("please log in again");
		}
		return result;
	}
	@ResponseBody
	@RequestMapping("verifyUser")
	public Map<String, Object> verifyUser(@RequestParam(value="userPassword")String userPassword,HttpServletRequest request)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(request.getSession(false)==null)
		{
			 result.put("status", "0");
			 result.put("errorMsg", "please log in again");
		}
		else if(session.getAttribute("userPassword").equals(userPassword))
		{
			result.put("status", "1");
			result.put("data", true);
		}
		else 
		{
			result.put("status", "0");
			result.put("errorMsg", "wrong password.");
		}
		return result;
	}
	
	public String ceshi()
	{
		return "ceshi";
	}
	
	@RequestMapping("")
	public String shi(){
		return "/user";
	}
	
	@RequestMapping("inverseBook")//
	public String inverseBook(){
		return "/book";
	}
	
	@RequestMapping("inverseInfo")//
	public String inverseInfo(){
		return "/information";
	}
	
	@RequestMapping("inverseDelivery")//
	public String inverseDelivery(){
		return "/delivery";
	}
	
	@RequestMapping("inverseBookBuy")
	public String inverseBookBuy(){
		return "/buyBook";
	}
	
	@RequestMapping("inverseToaBook")
	public String inverseToaBook(){
		return "/aBook";
	}
	
	@RequestMapping("inverseToaUser")
	public String inverseToaUser(){
		return "/aUser";
	}
	
	@RequestMapping("inverseArrive")//
	public String inverseArrive(){
		return "/userSignForDelivery";
	}
	
	@RequestMapping("inverseDemandes")//
	public String inverseDemandes(){
		return "/userDemandes";
	}
	
	@RequestMapping("inverseDemandeDetails")//
	public String inverseDemandeDetails(){
		return "/ADemande";
	}
	
	@ResponseBody
	@RequestMapping("returnUserName")
	public String returnUserName()
	{
		String name=(String) session.getAttribute("userName");
		System.out.println(name);
		return name;
	}
	
	@ResponseBody
	@RequestMapping("getUserName")
	public String getUserName(@RequestParam(value="userId") String userId)
	{
		if(userService.verifyUserId(userId).size()==0)
		{
			return "wrong userId";
		}
		else
		{
			return userService.verifyUserId(userId).get(0).getUserName();
		}
	}
	
	@ResponseBody
	@RequestMapping("getUserId")
	public String getUserId(@RequestParam(value="userName") String userName)
	{
		if(userService.verifyUserName(userName).size()==0)
		{
			return "wrong userId";
		}
		else
		{
			return userService.verifyUserName(userName).get(0).getUserId();
		}
	}
	
	
	@ResponseBody
	@RequestMapping("logIn")//
	public String user(@RequestParam(value="userId") String userId,@RequestParam(value="userPassword") String userPassword,HttpServletRequest request)
	{
		try {
		System.out.println(session==null);
		System.out.println(request.getSession(false)==null);	
		//session=request.getSession(false);
		if(session!=null)
		{
			System.out.println(session.getAttribute("userName"));
		}
		if(request.getSession(false)!=null)
		{
			System.out.println(request.getSession(false).getAttribute("userName"));
		}
	 if(session==null || request.getSession(false)==null || (session!=null && session.getAttribute("userName")==null) ||(request.getSession(false)!=null && request.getSession(false).getAttribute("userName")==null ))
		{	
			if(userService.userLogIn(userId,userPassword).size() ==1)
			{
				session=request.getSession();
				//session.setMaxInactiveInterval(60*1);
				String sessionId=session.getId();
				User u=new User();
				u.setUserId(userId);
				u.setPassWord(userPassword);
				u=userService.userLogIn(userId, userPassword).get(0);
				session.setAttribute("userName", u.getUserName());
				session.setAttribute("userId", userId);
				session.setAttribute("userPassword", userPassword);	
				System.out.println(u.getUserName()+ ", welcome to your homepage! your sessionID:"+sessionId);
				return u.getUserName();
				//return u.getUserName()+ ", welcome to your homepage! your sessionID:"+sessionId;
			}
			else
			{
				System.out.println("wrong id or password.");
				return "wrong id or password.";
			}
		}
		else
		{
			System.out.println("deja log in.");
			return "deja log in.";
		}
	} catch (Exception e) {
		e.printStackTrace();// TODO: handle exception
		return "deja log in error.";
	}
	}
	
	@ResponseBody
	@RequestMapping("create")//
	public String userCreate(@RequestParam(value="userName") String userName, @RequestParam(value="userPassword") String userPassword, @RequestParam(value="enterprise") String enterprise)
	{
		if(userName=="" || userPassword==""||enterprise==""||userName.trim().isEmpty()||userPassword.trim().isEmpty()||enterprise.trim().isEmpty())
		{
			return "please input your total information.";
		}
		else
		{
		if(userName.charAt(0)==' '|| userPassword.charAt(0)==' '|| enterprise.charAt(0)==' ')
		{
			return "the first character can't be a space.";
		}
		if(!userService.isCharNum(userPassword) )
		{
			return "userName/password/enterprise can only use character or number.";
		}
		else
		{
			if(userService.verifyUserName(userName).size()== 0)
			{				
				User u=new User();
				u.setUserId(userService.setRandomUserId());
				u.setUserName(userName);
				u.setPassWord(userPassword);
				u.setUserEnterprise(enterprise);
				Timestamp time=new Timestamp(System.currentTimeMillis());
				u.setCreateDate(time);
				u.setDeleteDate(null);
				userService.insertUser(u);
				System.out.println("welcome! your userId:"+u.getUserId());
				return "welcome! your userId:"+u.getUserId();
			}
			else
			{
				System.out.println("please change another name.");
				return "please change another name.";
			}
		}
		}
	}
	
	@ResponseBody
	@RequestMapping("destroy") 
	public String userDestroy(HttpServletRequest request)
	{	
		if( request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			String name = (String) session.getAttribute("userName");
			String password =(String) session.getAttribute("userPassword");
			String id=(String) session.getAttribute("userId");
			//System.out.println(userName);
			System.out.println(password);
			userService.deleteUser(id);
			return "thanks for your using.";
		}
	}
	
	@ResponseBody
	@RequestMapping("modifyName")//
	public String changeName(@RequestParam(value="userChangeName") String userChangeName,HttpServletRequest request)//必须要有@PathVariable
	{		
		if( request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			if(userService.verifyUserId(userChangeName).size() ==0)
			{
				String id=(String)session.getAttribute("userId");
				String password=(String)session.getAttribute("userPassword");
				List<User> users=userService.userLogIn(id,password);
				User u=users.get(0);
				u.setUserName(userChangeName);
				userService.updateUser(u);
				session.setAttribute("userName", userChangeName);
				//System.out.println(userChangeName);
			return userChangeName+" change successfully!";
			}
			else
			{
				return "please change another name.";
			}
		}
	}
	
	
	@ResponseBody
	@RequestMapping("modifyPassword")//
	public String changePassword(@RequestParam(value="userChangePassword") String userChangePassword,HttpServletRequest request)
	{
		if( request.getSession(false)==null || session==null)
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
				session.setAttribute("userPassword", userChangePassword);
				return "change password successfully!";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping("/modifyEnterprise/{userChangeEnterprise}")
	public String changeEnterprise(@PathVariable String userChangeEnterprise,HttpServletRequest request)
	{
		if( request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
			String id=(String)session.getAttribute("userId");
			String password=(String)session.getAttribute("userPassword");
			List<User> users=userService.userLogIn(id,password);
			if(users.size()==0)
			{
				return "no such user.";
			}
			else
			{
				User u=users.get(0);
				u.setUserEnterprise(userChangeEnterprise);
				userService.updateUser(u);	
				return "change enterprise successfully!";
			}
		}
	}	
	
	@ResponseBody
	@RequestMapping("pay")// 
	public String payDemande(@RequestParam(value="demandeId") String demandeId,HttpServletRequest request)
	{
		if( request.getSession(false)==null || session==null)
		{
			return "session invalidated,please log in again.";
		}
		else
		{
		String userId=(String) session.getAttribute("userId");
		List<Demande> demandes=demandeService.getDemande(demandeId);
		if(demandes.size()==0)
		{
			return "not found";
		}
		else
		{
			float fPrice=0;
			for(Demande demande:demandes)
			{
				demande.setPayOrNot(1);
				demandeService.updateDemande(demande);
				fPrice=fPrice+demande.getTotalPrice();
				
				String bookId=demande.getBookId();
				String sellerId=bookService.selectBooks(bookId).get(0).getBookSellerId();
				
				DemandeCal demandeCal=new DemandeCal();
				demandeCal.setdemandeId(demande.getDemandeId());; 
				demandeCal.setSellerId(sellerId);
				demandeCal.setUserId(userId);
				demandeCal.setbookId(bookId);
				demandeCalService.insertDemandeCal(demandeCal);
				//System.out.println("insert demandeCal");
			}
			return "pay successfully:"+fPrice;
		}
		}
	}
	
	@ResponseBody
	@RequestMapping("arrive")//
	public String signDelivery(@RequestParam(value="deliveryId") String deliveryId,HttpServletRequest request)
	{
		if( request.getSession(false)==null || session==null)
		{
			return "please log in again.";
		}
		else if(deliveryService.searchDelivery(deliveryId).size() ==0)
		{
			return "no such delivery";
		}
		else
		{
			String userId=(String)session.getAttribute("userId");
			if(userId.equals(deliveryService.searchDelivery(deliveryId).get(0).getUserId()))
			{
				Delivery delivery=deliveryService.searchDelivery(deliveryId).get(0);
				delivery.setSignOrNot(1);
				Timestamp timestamp=new Timestamp(System.currentTimeMillis());
				delivery.setArriveDate(timestamp);
				deliveryService.updateDelivery(delivery);
				return "thanks for your using delivery.";
			}
			else
			{
				return "wrong deliveryId.";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping("userSearchNowArriveAt")//
	public String userSearchArriveAt(@RequestParam(value="deliveryId") String deliveryId,HttpServletRequest request)
	{
		if( request.getSession(false)==null || session==null)
		{
			return "please log in again.";
		}
		else
		{
			if(deliveryService.searchDelivery(deliveryId).size()==0)
			{
				return "wrong deliveryId";
			}
			else
			{
				String id=(String)session.getAttribute("userId");
				if(id.equals(deliveryService.searchDelivery(deliveryId).get(0).getUserId()))
				{
					Delivery delivery=deliveryService.searchDelivery(deliveryId).get(0);
					return delivery.getNowArriveAt();
				}
				else
				{
					return "no such delivery";
				}
			}
		}
	}
	
	@ResponseBody 
	@RequestMapping("logOut")//
	public String userLogOUt(HttpServletRequest request)
	{
		if(request.getSession(false)==null)
		{
			session=null;
			return "deja log out";
		}
		else
		{
			if(session!= null)
			{
				session.invalidate();
				session=null;
				return "log out successfully";
			}
			else
			{
				return "please log in firstly.";
			}
		}
	}
}
