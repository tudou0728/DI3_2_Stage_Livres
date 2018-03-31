package com.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Book;
import com.service.BookService;
import com.service.DeliveryService;
import com.service.DemandeService;
import com.service.UserService;

@Controller
@RequestMapping("/book")
public class BookController 
{
	@Resource
	private UserService userService;
	@Resource
	private BookService bookService;
	@Resource
	private DemandeService demandeService;
	@Resource
	private DeliveryService deliveryService;
	
	@ResponseBody
	@RequestMapping("books")
	public  Map<String, Object> books()
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.listBooks().size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg","no books");
		}
		else
		{
			List<Book> books=bookService.listBooks();
			result.put("status", "1");
			result.put("data",books);
			System.out.println(books.size()+"success");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("booksOnSale")
	public  Map<String, Object> booksOnSale()
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.listBooksOnSale().size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg","no books");
		}
		else
		{
			List<Book> books=bookService.listBooksOnSale();
			result.put("status", "1");
			result.put("data",books);
			System.out.println(books.size()+"success");
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="booksId",method = RequestMethod.GET)
	public List<String> getBooksId()
	{
		List<String> ids=new ArrayList<>();
		List<Book> books=bookService.listBooks();
		for(Book book:books)
		{
			ids.add(book.getBookId());
		}
		return ids;
	}
	
	@ResponseBody
	@RequestMapping("readBookName")
	public String readBookName(@RequestParam (value="bookId") String bookId)
	{
		if(bookService.selectBooks(bookId).size()==0)
		{
			return "wrong bookId or this book is already deleted.";
		}
		else
		{
			return bookService.selectBooks(bookId).get(0).getBookName();
		}
	}
	
	@ResponseBody
	@RequestMapping("insertBook")
	public Map<String, Object> manageInsertBook(@RequestParam(value="bookName") String bookName,@RequestParam(value="bookQuantity") String bookQuantity,@RequestParam(value="bookUnitPrice") String bookUnitPrice,@RequestParam(value="userId") String userId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		String id=bookService.setRandomBookId();
		Book book=new Book();
		book.setBookId(id);
		book.setBookName(bookName);
		String pattern="^[0-9]+";
		if(!bookQuantity.matches(pattern)||bookQuantity.charAt(0)=='0')
		{
			System.out.println("1");			
			result.put("status", 0);
			result.put("errorMsg", "wrong input information.");
			//return "wrong input information.";
		}
		else
		{
			int quantity=Integer.parseInt(bookQuantity);
			book.setBookQuantity(quantity);
			String pattern2="^[0-9\\.]+";	
			if(!bookUnitPrice.matches(pattern2))
			{
				System.out.println("2");
				result.put("status", 0);
				result.put("errorMsg", "wrong input information.");
				//return "wrong input information.";
			}
			else
			{
				String[]temp=bookUnitPrice.split("\\.");
				if((temp.length==1 && bookUnitPrice.charAt(0)!='0') || (temp.length==2 && bookUnitPrice.charAt(bookUnitPrice.length()-1)!='0'))
				{
					float price=Float.parseFloat(bookUnitPrice);
					book.setBookUnitPrice(price);
					book.setBookSellerId(userId);
					book.setSaleOrNot(1);
					bookService.insertBook(book);
					System.out.println("4");
					result.put("status", 1);
					result.put("data", id);
					//return id;
				}
				else
				{			
					System.out.println(temp.length);
					System.out.println(bookUnitPrice.charAt(0));
					System.out.println(bookUnitPrice.charAt(bookUnitPrice.length()-1));
					result.put("status", 0);
					result.put("errorMsg", "wrong input information.");
					//return "wrong input information.";
				}
			}
		}					
		return result;
	}
	
	@ResponseBody
	@RequestMapping("update")
	public  String updateBookInformation(@RequestParam(value="bookId")String bookId,@RequestParam(value="bookName")String bookName,@RequestParam(value="bookQuantity")String bookQuantity,@RequestParam(value="bookUnitPrice")String bookUnitPrice,@RequestParam(value="userId")String userId)
	{		
		if(bookService.selectBooks(bookId).size()==0)
		{
			System.out.println("1");
			return "wrong bookId.";
		}
		else
		{
			Book book=bookService.selectBooks(bookId).get(0);
			if(userId.equals(book.getBookSellerId()))
			{
				String pattern="^[0-9]+";
				if(!bookQuantity.matches(pattern) || bookQuantity.charAt(0)=='0')
				{
					System.out.println("2");
					return "wrong input information.";
				}
				else
				{
					book.setBookName(bookName);
					book.setBookQuantity(Integer.parseInt(bookQuantity));
					String pattern2="^[0-9\\.]+";	
					if(!bookUnitPrice.matches(pattern2))
					{
						System.out.println("3");
						return "wrong input information.";
					}
					else
					{
						String[]temp=bookUnitPrice.split("\\.");
						if((temp.length==1 && bookUnitPrice.charAt(0)!='0') || (temp.length==2 && bookUnitPrice.charAt(bookUnitPrice.length()-1)!='0'))
						{
							float price=Float.parseFloat(bookUnitPrice);
							book.setBookUnitPrice(price);
							book.setBookSellerId(userId);
							bookService.updateBook(book); 
							System.out.println("5");
							return "change successfullt";
						}
						else
						{	
							System.out.println("4");
							return "wrong input information.";
						}
					}
				}
			}
			else
			{
				return "wrong bookId.";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping(value="buy") //
	public String buyBooks(@RequestParam(value="bookId") String bookId,@RequestParam(value="quantity") String quantity)
	{
		List<Book> books=bookService.selectBooks(bookId);
		Book book=books.get(0);
		String pattern="['0-9']+";
		if(quantity.matches(pattern) && quantity.charAt(0)!='0')
		{
			int eNum=book.getBookQuantity();
			if(eNum>=Integer.parseInt(quantity))
			{
			book.setBookQuantity(eNum-Integer.parseInt(quantity));
			//bookService.updateBook(book);
			float cost=(Integer.parseInt(quantity))*(book.getBookUnitPrice());
			return String.valueOf(cost);
			}
			else
			{
				return "no enough books";
			}
		}
		else
		{
			return "wrong input number.";
		}
	}
	
	@ResponseBody
	@RequestMapping(value="searchBookName") //
	public Map<String, Object> searchBookName(@RequestParam(value="bookName")String bookName)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		System.out.print(bookName);
		if(bookService.searchBooksByBookName(bookName).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no such books");
		}
		else
		{
			List<Book> books=bookService.searchBooksByBookName(bookName);
			result.put("status", "1");
			result.put("data",books);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("searchSeller")
	public Map<String, Object> searchSeller(@RequestParam(value="sellerName")String sellerName)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.selectBooksBySellerName(sellerName).size()==0)
		{
			result.put("status1", "0");
			result.put("errorMsg", "no books on sale");
			if(bookService.selectBooksNotSaleBySellerName(sellerName).size()==0)
			{
				result.put("status2", "0");
				result.put("errorMsg", "no books not sale");
			}
			else
			{
				result.put("status2", "1");
				List<Book> books=bookService.selectBooksNotSaleBySellerName(sellerName);
				result.put("booksNotSale", books);
			}
		}
		else
		{
			List<Book> books=bookService.selectBooksBySellerName(sellerName);
			result.put("status1", "1");
			result.put("booksOnSale", books);
			if(bookService.selectBooksNotSaleBySellerName(sellerName).size()==0)
			{
				result.put("status2", "0");
				result.put("errorMsg", "no books not sale");
			}
			else
			{
				result.put("status2", "1");
				List<Book> bookNotSale=bookService.selectBooksNotSaleBySellerName(sellerName);
				result.put("booksNotSale", bookNotSale);
			}
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("searchSellerDistinct")
	public Map<String, Object> searchSellerDistinct(@RequestParam(value="sellerName")String sellerName)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.selectSellerNameDistinct(sellerName).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no  books");
		}
		else
		{
			List<String> name=bookService.selectSellerNameDistinct(sellerName);
			result.put("status", "1");
			result.put("data", name);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/{sellerName}/searchSeller2")
	public Map<String, Object> searchSeller2(@PathVariable String sellerName)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.selectBooksBySellerName(sellerName).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no  books");
		}
		else
		{
			List<Book> books=bookService.selectBooksBySellerName(sellerName);
			result.put("status", "1");
			result.put("data", books);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("selectBook")
	public Map<String, Object> selectBook(@RequestParam (value="bookId")String bookId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.selectBooks(bookId).size()==0)
		{
			result.put("status", 0);
			result.put("errorMsg", "no such book");
		}
		else
		{
			Book book=bookService.selectBooks(bookId).get(0);
			result.put("status", 1);
			result.put("data", book);
		}
		return result;
	}
	
	/*
	@ResponseBody
	@RequestMapping("/{bookId}/select_Book")
	public Map<String, Object> select_Book(@PathVariable String bookId)
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.selectBooks(bookId).size()==0)
		{
			result.put("status", "0");
			result.put("errorMsg", "no such book");
		}
		else
		{
			Book book=bookService.selectBooks(bookId).get(0);
			result.put("status", "1");
			result.put("data", book);
		}
		return result;
	}*/
	
	@ResponseBody
	@RequestMapping("deleteBook")
	public String deleteBook(@RequestParam(value="bookId")String bookId,@RequestParam(value="userId")String userId)
	{
		if(bookService.selectBooks(bookId).size()==0)
		{
			return "no such books";
		}
		else
		{
			Book book=bookService.selectBooks(bookId).get(0);
			if(userId.equals(book.getBookSellerId()))
			{
			book.setSaleOrNot(0);
			bookService.updateBook(book);
			String bookName=book.getBookName();
			return bookName+" deja delete";
			}
			else
			{
				return "wrong bookId.";
			}
		}
	}
	
	@ResponseBody
	@RequestMapping("mostSale")
	public Map<String, Object>mostSale()
	{
		Map<String, Object> result=new HashMap<String,Object>();
		if(bookService.bookMostSale().size()==0)
		{
			result.put("status", 0);
			result.put("errorMsg", "can not find.");
		}
		else
		{
			Book book=bookService.bookMostSale().get(0);
			result.put("status", 1);
			result.put("data", book);
		}
		return result;
	}
}
