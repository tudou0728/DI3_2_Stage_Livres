package com.service.impl;

import java.util.List;
import java.util.Random;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.dao.UserDao;
import com.entity.Book;
import com.entity.User;
import com.service.UserService;
@Service
public class UserServiceImpl implements UserService 
{
	@Resource
	private UserDao userDao;
	private List<Book> books;
	

	public String getPassword(String name)
	{
		return userDao.getPassword(name);
	}
	
	public List<User> verifyUserName(String name)
	{
		return userDao.verifyUserName(name);
	}
	
	public List<User> userLogIn(String id,String password)
	{
		return userDao.userLogIn(id,password);
	}

	public void insertUser(User user) {
		// TODO Auto-generated method stub
		userDao.insertUser(user);
	}
	
	public void updateUserName(User user) {
		// TODO Auto-generated method stub
		userDao.updateUserName(user);
	}
	
	public void updateUserPassword(User user)
	{
		userDao.updateUserPassword(user);
	}

	public void updateUser(User user)
	{
		userDao.updateUser(user);
	}

	public void deleteUser(String id)
	{
		userDao.deleteUser(id);
	}
	
	public boolean isCharNum(String str)
	{
		String pattern="^[a-z0-9A-Z]+";
		return str.matches(pattern);
	}
	
	public List<User> verifyUserId(String id)
	{
		return userDao.verifyUserId(id);
	}
	
	public String setRandomUserId()
	{
		Random ra=new Random();
		int length=ra.nextInt(10)+1;
		String base="0123456789";
		Random random=new Random();
		StringBuffer buffer=new StringBuffer();
		for(int i=0;i<length;i++)
		{
			int eNumber=random.nextInt(base.length());
			buffer.append(base.charAt(eNumber));
		}
		String string=buffer.toString();
		if(verifyUserId(string).size()==0 && string.charAt(0)!='0')
		{
			return string;
		}
		else
		{
			return setRandomUserId();
		}
	}
	
	public List<User> userGetDemandes(String id){
		return userDao.userGetDemandes(id);
	}

	public String ceshi(String str){
		return "hello"+str;
	}

}
