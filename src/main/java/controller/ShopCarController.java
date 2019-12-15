package controller;

import entity.Productinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.io.IOException;
import java.util.*;

import entity.Productinfo;
import serviceImpl.ProductInfoServiceImpl;
import serviceImpl.UserServiceImpl;


import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@Controller
//注解?w为什么在注解加进来?spring带他玩  ,原来就什么样的数据类型,就会找不到,就会下面respondbody
//为甚要用注解,
//@ResponseBody  //加在整个类上面就是这个ctorller返回的就是json的数据格式
@RestController//等价属于 @Controller +@ Responbody
public class ShopCarController {
    @Autowired
    JedisPool jedisPool;//这类就是已经存在spring容器中,就是自动注入

    @Autowired
    ProductInfoServiceImpl psi;

    @Autowired
    UserServiceImpl usi;


    @RequestMapping("/addCar")
    public String addCar(@RequestParam String pid, @RequestParam String username) {
        //为什么一定String.//使用数据粗只是某些数据频繁使用的清数据,存在redis中.//明确是是就是不需要dao等等等..
        /**
         *    //redis的存储结构，就是大map（username，map） 小map（pid，pnum）
         *
         * id就是主要就是,就是当加入购物车,就是js怎么检查怎有没有登录?值?--登录的时候cookie,里面有没有值
         * 购物车的存储,结构,
         * redis的hmset存储啊,hemset是一个map集合,该集合的key的存储的username用户名
         * value存储的额一个map集合,其中一个map集合,的key的pid(商品的唯一标识),value存储的是商品的数量,
         * 为什么一办使用就是map,map比较好用,我们说使用数组也可以,list可以,就是hmset就是map
         */
        Jedis jedis = jedisPool.getResource();//就是获取jedis对象,就是没有连接处,就是自己new,

        //1.就是判断用户的购物车有没有商品:hgetAll通过与用户名得value,
        //1.1如果value是不为空,就是说明有商品,直接添加就可以i
        //1.2如果value为空,就需要创建一个map集合

        Map<String, String> map = jedis.hgetAll(username);//hgetALL返会的类型Map<String,String>,泛型就是,所以就是pid就是String,
        if (map.isEmpty()) {//判断里面是否有元素,
       //     map = new HashMap<String, String>();//这样你才能put进去,,或会包空指针异常
            map.put(pid, "1");//就是数量int,但是这里家伙是哪个双引号,变成String
            jedis.hmset(username, map);//千万别忘存入redis

        } else {
            //就是哟可能就是有不同的商品.同判断pid是否有判断
            if (map.containsKey(pid)) {
                map.put(pid, String.valueOf(Integer.parseInt(map.get(pid))+1));//map.get(pid)+1就是获取原来的数量+1转话完成,加上1
                jedis.hmset(username, map);
            } else {
                map.put(pid, "1");
                jedis.hmset(username, map);
            }
        }
     return "";
    }


    @RequestMapping("/getCar")
    //该注解是用来映射一个URL到一个类或一个特定的方处理法上。
    public List<Productinfo>getCar(@RequestParam String username){//为什么要使用是对象,为什么要使用list,
        Jedis jedis = jedisPool.getResource();
        Map<String, String> map = jedis.hgetAll(username);//就是不满足需求,mapkey,value不满度创许多个对象,而且map里面不好取
        List<Productinfo> list = new ArrayList<>();


        //Prdunctinfo pNum,(库存)//pid=123,pNum=100(数据库里面 的信息)
        //my  pid=123,pNum=5.就是自己的购物车pNum.
        if(!map.isEmpty()){//非空就是比遍历集合.就是map集合转list集合
            for (Map.Entry<String,String> entry:map.entrySet()){
           Productinfo pi = psi.selectByPrimaryKey(Integer.parseInt(entry.getKey()));//pid
          pi.setpNum(Integer.parseInt(entry.getValue()));//就是要库存就是要修改自己的购物车里面的数量
          list.add(pi);
            }

        }
        return list;

    }

    //移除购物车的数量
@RequestMapping("/removeItems")
    public void removeItems(@RequestParam String pid,@RequestParam String username){
    Jedis jedis = jedisPool.getResource();
    Map <String,String> map = jedis.hgetAll(username);
    //就是不用做非控判断,
    map.remove(pid);
    jedis.del(username);//redis的机制,就是redis就是先删除,在噻进去,,就是用过key删除整个map
    jedis.hmset(username,map);//然后就是噻会回去在还回去,逻辑没有问题


}

@RequestMapping("/reduceItemsNum")
public void reduceItemsNum(@RequestParam String pid,@RequestParam String username,@RequestParam String pnum){
    Jedis jedis = jedisPool.getResource();
    Map <String,String> map = jedis.hgetAll(username);
    if(Integer.parseInt(pnum)>1){
        map.remove(pid);
        map.put(pid,pnum);
        jedis.del(username);//hdel
        jedis.hmset(username, map);
    }else{

      /*   //亲测.就是是要美好值这样方法实事假上就是会一致进行件数,是会有漏洞的
      map.put(pid, String.valueOf(Integer.parseInt(map.get(pid))-1));//map.get(pid)+1就是获取原来的数量+1转话完成,加上1
         jedis.hmset(username, map);
*/
        //或者就是方法2,自己方法,
        map.remove(pid);
        jedis.del(username);
        jedis.hmset(username,map);

    }
}


    @RequestMapping("/reduceItemsNum1")
    public  void reduceItemsNum1(@RequestParam String pid,@RequestParam String username,@RequestParam String pnum){
    Jedis jedis = jedisPool.getResource();
    Map <String,String> map = jedis.hgetAll(username);
        map.put(pid, String.valueOf(Integer.parseInt(map.get(pid))-1));//map.get(pid)+1就是获取原来的数量+1转话完成,加上1
        jedis.hmset(username, map);
}

@RequestMapping("/handdata")
    public void handdata(@RequestParam String pid,@RequestParam String username,@RequestParam String pnum){
    Jedis jedis = jedisPool.getResource();
    Map <String,String> map = jedis.hgetAll(username);
    map.remove(pid);
    map.put(pid,pnum);
    jedis.del(username);//就是用hdel也可以删除hdel(username,pid)
    jedis.hmset(username,map);

}

//付款
@RequestMapping("/sendEmail")
public String getEmailCount(@RequestParam String username,  HttpServletResponse resp, HttpServletRequest req) throws IOException {
        String email = usi.selectEmailByUsername(username);
          System.out.println(email);
        int randomNum=(int)((Math.random()*9+1)*100000);//随机生成.想测试可以在这里打印一下随机谁然后及时在前台获取alert一下
         sendEmail(email,randomNum,req,resp);
        return String.valueOf(randomNum);//怎么把String转字符串

}


@RequestMapping("/deleteProductNum")
    public synchronized  String deleteProductNum (@RequestParam String username,@RequestParam Integer pid,@RequestParam Integer pnum){//username是干嘛的.就是aop,获取是谁买的,

    Productinfo pi = psi.selectByPrimaryKey(pid);//就是先查后改,

/**
 * 1. pi.setpNum(pi.getpNum()-pnum);//剩下库存=数据库获取的库存-购买的数量
 *  *     psi.updateByPrimaryKey(pi);
 * 2.就是判断就是库存是否大于0,才能购买,这样的谁就是不是VCiudad但是要给个返回变成String
 * 3.有没有并发问题,当有没有同时库存都为1的时候,两个人都付款了,锁,代码的快,还是方法,就是大名if这里所上还是会有问题
 * 就是直接带所方法让每一用户就是支付完在走,其他用户排对,就是自己的这样即使速度慢点,但是不会有 问题
 * 每一个用户都是一个线程,这样都进行排队,没哟真正的并发,cpu帮你调度,所以就是优先,可以看源码
 *4.就是当是yes的时候,证明是可以付款,库里面也有库存,就是说可以生成订单,要想怎么才能生成订单?既然是在你return的时候,
 * 干脆就在你return"yes"的时候,配置一个切面,生成订单
 *默认:就是一加商家,当有好多商家怎么实现生成订单..
 * 根据用户名,查询pid,怎么对list集合分类,怎么实现?pid是唯一的,pid的可以查询商家id
 */
if(pi.getpNum()>=pnum){
    pi.setpNum(pi.getpNum()-pnum);
        psi.updateByPrimaryKey(pi);
        return "yes";
    }else{
      return "no";
    }
}





//发送验证码
    public  void sendEmail(String emailCount, int randomNum, HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        String from="1422803488@qq.com";//你自己的邮箱
        String host="smtp.qq.com";//本机地址
        //Properties可以确定系统的属性,就是为了寻找我们的host
        Properties properties=System.getProperties();
        properties.setProperty("mail.smtp.host", host);
        properties.setProperty("mail.smtp.port", "25");
        properties.put("mail.smtp.auth","true");//开启代理

        Authenticator aut=new Authenticator() {//创建Authenticator内部类来填入代理的用户名前缀和密码

            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication("1422803488","jgtphqmvugmcidec");//填用户名和代理密码

            }

        };

        //创建Session会话,Session是java.mail API最高入口
        Session session= Session.getDefaultInstance(properties,aut);
        //MimeMessage获取session对象,就可以创建要发送的邮箱内容和标题
        MimeMessage message=new MimeMessage(session);
        try {
            message.setFrom(new InternetAddress(from));//设置你自己的邮箱
            message.addRecipients(Message.RecipientType.TO, emailCount);//设置接受邮箱
            message.setSubject("验证码");//设置邮箱标题
            message.setText("您本次的验证码是:"+randomNum);//邮箱内容
            Transport.send(message);//发送邮箱

        } catch (AddressException e) {
            e.printStackTrace();
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }




}
