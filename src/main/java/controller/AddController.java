package controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AddController {

    @RequestMapping("/addCar")
    public String addCar() {
        //使用数据粗只是某些数据频繁使用的清数据,存在redis中.
        //明确是是就是不需要dao等等等..
        /**
         * id就是主要就是
         * 就是当加入购物车,就是js怎么检查怎有没有登录?值?--登录的时候cookie,里面有没有值
         */
        return "no";

    }


}
