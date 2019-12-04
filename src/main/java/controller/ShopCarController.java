package controller;

import entity.Productinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import entity.Productinfo;
import serviceImpl.ProductInfoServiceImpl;

@RestController
public class ShopCarController {
    @Autowired
    JedisPool jedisPool;//这类就是已经存在spring容器中,就是自动注入

    @Autowired
    ProductInfoServiceImpl psi;



    @RequestMapping("/addCar")
    public String addCar(@RequestParam String pid, @RequestParam String username) {
        //为什么一定String.//使用数据粗只是某些数据频繁使用的清数据,存在redis中.//明确是是就是不需要dao等等等..
        /**
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
    public List<Productinfo>getCar(@RequestParam String username){
        Jedis jedis = jedisPool.getResource();
        Map<String, String> map = jedis.hgetAll(username);//就是不满足需求,mapkey,value不满度创许多个对象,
        List<Productinfo> list = new ArrayList<>();

        //Prdunctinfo pNum,(库存)//pid=123,pNum=100(数据库里面 的信息)
        //my  pid=123,pNum=5.就是自己的购物车pNum.
        if(!map.isEmpty()){//非空就是比遍历集合.就是map集合转list集合
            for (Map.Entry<String,String> entry:map.entrySet()){
           Productinfo pi = psi.selectByPrimaryKey(Integer.parseInt(entry.getKey()));
          pi.setpNum(Integer.parseInt(entry.getValue()));//就是要库存就是要修改自己的购物车里面的数量
          list.add(pi);
            }

        }
        return list;

    }

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
         map.put(pid, String.valueOf(Integer.parseInt(map.get(pid))-1));//map.get(pid)+1就是获取原来的数量+1转话完成,加上1
         jedis.hmset(username, map);

        //或者就是方法2,自己方法,
       /* map.remove(pid);
        jedis.del(username);
        jedis.hmset(username,map);*/

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



}
