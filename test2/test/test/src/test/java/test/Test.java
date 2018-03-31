package test;

import java.util.List;

import javax.annotation.Resource;

import com.entity.Book;
import com.entity.Delivery;
import com.entity.User;
import com.service.BookService;
import com.service.DeliveryService;
import com.service.DemandeService;
import com.service.JedisClient;
import com.service.UserService;

public class Test extends AbstractTest
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
	private JedisClient jedisClient;
	
	@org.junit.Test
	public void test()
	{
		List<Book> books=bookService.selectBooksBySellerName("fgjg");
		System.out.println(books.size());
		//String x=deliveryService.setRandomDeliveryId(3);
		//int num=userService.userGetDemandes("1").size();
		//int num=deliveryService.demandeWaitingForDelivery().size();
		//Delivery delivery=new Delivery();
		//delivery=deliveryService.listDelivery().get(0);
		//delivery.setNowArriveAt("kjkjkj");
		//System.out.println(delivery.getNowArriveAt());
		//deliveryService.updateDelivery(delivery);
		/*List<Delivery> deliverys=deliveryService.searchDelivery("56");
		System.out.println(deliverys.size());
		Timestamp time=new Timestamp(System.currentTimeMillis());
		deliverys.get(0).setArriveDate(time);
		deliverys.get(0).setSignOrNot(1);*/
		/*deliveryService.deleteDelivery("3");
		List<Delivery> deliverys=deliveryService.listDelivery();
		System.out.println(deliverys.size());*/
		
		/*Demande demande=new Demande();
		demande.setBookId("5");
		demande.setDemandeId(userService.setRandomUserId(2));
		demande.setPayOrNot(0);
		demande.setQuantity(1);
		demande.setTotalPrice((float) 18.5);
		demande.setUserId("809");
		Timestamp time=new Timestamp(System.currentTimeMillis());
		demande.setCreateDate(time);*/
		/* 
		List<Demande> demandes=demandeService.getDemande("88", "809");
		System.out.println(demandes.get(0).getCreateDate());
		
		List<Demande> demandes=demandeService.getDemande("115");
		for(Demande demande:demandes)
		{
			demande.setDeliveryAdress("a988 0sdfsd");
			demandeService.updateDemande(demande);
		}
		System.out.println("change successfully");*/
		
		/*Book book=new Book();
		book.setBookID("5");
		book.setBookName("yellow");
		book.setBookQuantity(123);
		book.setBookUnitPrice((float) 18.5);
		bookService.updateBook(book);
		bookService.insertBook(book);
		bookService.deleteBook("2");
		List<Book> books=bookService.selectBooks("1");
		System.out.println(books.get(0).getBookUnitPrice());*/
		/*
		List<Book> books=bookService.listBooks();
		for (Book book: books) 
		{
			System.out.println(book.getBookID());
			System.out.println(book.getBookName());
		}
		System.out.println(books.size()); */
		/*
		List<User> users = userService.userLogIn("1", "1");
		User u=users.get(0);
		System.out.println(u.getUserEnterprise());
		System.out.println(u.getCreateDate());*/
		//list all
		/*
		List<User> users = userService.getUser();
		for (User user : users) 
		{
			System.out.println(user.getUserId());
			System.out.println(user.getCreateDate());
		}
		System.out.println(users.size());*/
		
		/*
		User utemp=new User();
		utemp.setUserName("haha");
		utemp.setPassWord("1");
		users = userService.userLogIn(utemp);
		System.out.println(users.get(0).getUserName());
		System.out.println(users.get(0).getPassWord());*/
		
		//System.out.println(userService.verifyUserName("beast"));
		
		//insert	
		/*
		System.out.println("insert a user:");
		User u = new User();
		u.setUserEnterprise("C");
		u.setUserId(userService.setRandomUserId(2));
		u.setUserName("LJKJ");
		u.setPassWord("989");
		Timestamp time=new Timestamp(System.currentTimeMillis());
		u.setCreateDate(time);
		u.setDeleteDate(null);
		userService.insertUser(u);
		List<User> users=userService.getUser();
		System.out.println(users.size());*/
		
		//update
		/*
		u.setUserName("ABCDEFG");
		userService.updateUser(u);
		System.out.println("update successfully");*/
		
		//delete
		/*
		userService.deleteUser("7");
		System.out.println("delete successfully");*/
		
		
		//delete
		/*
		userService.deleteUser(u);
		users = userService.getUser();
		System.out.println(users.size());*/
		
		//update name
		/*
		User u2 = new User();
		u2.setUserName("abcd");
		u2.setPassWord("1");
		userService.updateUserName(u2);
		System.out.println("update name successfully!");*/
		
		//update password
		/*
		User u3=new User();
		u3.setUserName("haha");
		u3.setPassWord("32123");
		userService.updateUserPassword(u3);
		System.out.println("update password successfully!");*/
		
		//jedisClient.set("hehe", "123098");
		//System.out.println(jedisClient.get("hehe"));
	}
}
