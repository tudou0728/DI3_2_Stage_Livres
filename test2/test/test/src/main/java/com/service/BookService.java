package com.service;

import java.util.List;

import com.entity.Book;
import com.entity.User;

public interface BookService 
{
	public List<Book> listBooks();
	
	public  List<Book> listBooksOnSale();
	
	public List<Book> selectBooks(String bookId);
	
	public void insertBook(Book book);
	
	public void deleteBook(String id);
	
	public void updateBook(Book book);
	
	public String setRandomBookId();
	
	public List<Book> searchBooksByBookName(String bookName);
	
	public List<String> selectSellerNameDistinct(String sellerName);
	
	public List<Book> selectBooksBySellerName(String sellerName);
	
	public List<Book> selectBooksNotSaleBySellerName(String sellerName);
	
	public List<Book> bookMostSale();
}
