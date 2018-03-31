package com.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.entity.Book;
import com.entity.User;

public interface UserService 
{
	
	 String getPassword(String name);
	
	 public List<User> userLogIn(String id,String password);
	 
	 List<User> verifyUserName(String name);
	 
	 public List<User> verifyUserId(String id);
	
	 void insertUser(User user);
	
	 void updateUserName(User user);
	
	 void updateUserPassword(User user);
	
	 public String setRandomUserId();
	 
	 public void deleteUser(String id);
	 
	 public void updateUser(User user);
	 
	 boolean isCharNum(String str);
	 
	 public List<User> userGetDemandes(String id);
	 
	 public String ceshi(String str);
}
