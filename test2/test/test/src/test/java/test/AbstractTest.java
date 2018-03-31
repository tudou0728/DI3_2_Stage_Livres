package test;

import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * ClassName:AbstractTest <br/>
 * Function: 所有单元测试的父类. <br/>
 * Date:     2016年3月13日 下午1:15:50 <br/>
 * @author   
 * @version  
 * @see 	 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:spring.xml","classpath:spring-mvc.xml","classpath:spring-mybatis.xml" })
public abstract class AbstractTest {

}

