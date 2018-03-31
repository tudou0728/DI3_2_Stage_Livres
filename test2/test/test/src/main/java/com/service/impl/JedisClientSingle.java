package com.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.service.JedisClient;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
@Repository
public class JedisClientSingle implements JedisClient {
	
	@Resource
	private JedisPool jedisPool; 
	
	public String get(String key) {
		Jedis jedis = jedisPool.getResource();
		String string = jedis.get(key);
		jedis.close();
		return string;
	}
	
	public String set(String key, String value) {
		Jedis jedis = jedisPool.getResource();
		String string = jedis.set(key, value);
		jedis.close();
		return string;
	}

	//返回哈希表中指定字段的值
	public String hget(String hkey, String key) {
		Jedis jedis = jedisPool.getResource();
		String string = jedis.hget(hkey, key);
		jedis.close();
		return string;
	}

	//为哈希表中的字段赋值
	public long hset(String hkey, String key, String value) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.hset(hkey, key, value);
		jedis.close();
		return result;
	}

	//将key中存储的数值增加1
	public long incr(String key) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.incr(key);
		jedis.close();
		return result;
	}

	//为指定的key设置过期时间
	public long expire(String key, int second) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.expire(key, second);
		jedis.close();
		return result;
	}

	//剩余生存空间
	public long ttl(String key) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.ttl(key);
		jedis.close();
		return result;
	}

	//删除key
	public long del(String key) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.del(key);
		jedis.close();
		return result;
	}

	//删除1个或多个指定字段
	public long hdel(String hkey, String key) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.hdel(hkey, key);
		jedis.close();
		return result;
	}

	//将一个或多个值插入到列表头部
	public long lpush(String key, String... strings) {
		Jedis jedis = jedisPool.getResource();
		Long result=jedis.lpush(key, strings);
		jedis.close();
		return result;
	}

	//获取列表指定范围内的元素
	public List<String> lrange(String key, long start, long end) {
		Jedis jedis = jedisPool.getResource();
		List<String> lrange = jedis.lrange(key, start, end);
		jedis.close();
		return lrange;
	}

	//将key中存储的数值减去1
	public long decr(String key) {
		Jedis jedis = jedisPool.getResource();
		Long result = jedis.decr(key);
		jedis.close();
		return result;
	}	
}
