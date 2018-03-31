package com.service.impl;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.dao.BookDao;
import com.entity.Book;
import com.entity.User;
import com.service.BookService;

@Service
public class BookServiceImpl implements BookService
{
	@Resource
	private BookDao bookDao;
	
	public List<Book> listBooks()
	{
		return bookDao.listBooks();
	}
	public  List<Book> listBooksOnSale()
	{
		return bookDao.listBooksOnSale();
	}
	public List<Book> selectBooks(String bookId)
	{
		return bookDao.selectBooks(bookId);
	}
	public void insertBook(Book book)
	{
		bookDao.insertBook(book);
	}
	
	public void deleteBook(String id)
	{
		bookDao.deleteBook(id);
	}
	
	public void updateBook(Book book)
	{
		bookDao.updateBook(book);
	}
	
	public String setRandomBookId()
	{
		Random ran=new Random();
		int length=ran.nextInt(10)+1;
		String base="0123456789";
		Random random=new Random();
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<length;i++)
		{
			int eNumber=random.nextInt(base.length());
			buffer.append(base.charAt(eNumber));
		}
		String string=buffer.toString();
		if(selectBooks(string).size()==0 && string.charAt(0)!='0')
		{
			return string;
		}
		else
		{
			return setRandomBookId();
		}
	}
	
	public List<Book> searchBooksByBookName(String bookName)
	{
		return bookDao.searchBooksByBookName(bookName);
	}
	public List<Book> selectBooksBySellerName(String sellerName)
	{
		return bookDao.selectBooksBySellerName(sellerName);
	}
	public List<String> selectSellerNameDistinct(String sellerName)
	{
		return bookDao.selectSellerNameDistinct(sellerName);
	}
	public List<Book> selectBooksNotSaleBySellerName(String sellerName)
	{
		return bookDao.selectBooksNotSaleBySellerName(sellerName);
	}
	public List<Book> bookMostSale()
	{
		return bookDao.bookMostSale();
	}
}
