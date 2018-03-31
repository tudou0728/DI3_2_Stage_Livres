package com.dao;

import java.util.List;

import com.entity.Demande;
import com.entity.User;

public interface UserDao 
{
	
	public String getPassword(String name);
	
	public List<User> userLogIn(String id,String password);
	
	public List<User> verifyUserName(String name);
	
	public List<User> verifyUserId(String id);
	
	public void insertUser(User user);

	public void updateUserName(User user);
	
	public void updateUserPassword(User user);
	
	public void updateUser(User user);

	public void deleteUser(String id);
	
	public List<User> userGetDemandes(String id); 
}
