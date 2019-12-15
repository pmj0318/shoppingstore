package controller;

import entity.Productinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import serviceImpl.ProductInfoServiceImpl;

import java.util.List;

//@Controller
//注解?w为什么在注解加进来?spring带他玩  ,原来就什么样的数据类型,就会找不到,就会下面respondbody
//为甚要用注解,
//@ResponseBody  //加在整个类上面就是这个ctorller返回的就是json的数据格式
@RestController  //等价属于 @Controller +@ Responbody

public class NavigatorAndShowProductController {
    ////就是实现自己不用new就能实现这个类,用了自动注入

    @Autowired
    ProductInfoServiceImpl psi;


    //@RequestMapping会根据请求名找到对应的方法.,写在方法上面就绑定了,请我这个请求过来了就执行这个方法.
//通过url找方法,这个注解就是@RequestMapping
    @RequestMapping("/selectAllp_type")
    //需要单个就是String,需要多个list,
    public List<String> selectAllp_type() {//这里是不要参数,主界面的种类
        return psi.selectAllp_type();
    }


    @RequestMapping("/selectAllProductsByP_type")//day11.进行页面条数的计算,传产品和页数
    public List<Productinfo> selectAllProductsByP_type(@RequestParam String p_type,@RequestParam Integer page) {
        return psi.selectAllProductsByP_type(p_type,page);
    }

    @RequestMapping("/selectTotallPage")//day11进行根据个数,动态算页面数
    public Integer selectTotallPage(@RequestParam String p_type){
        return  psi.selectTotallPage(p_type);
    }

    @RequestMapping("/getproductinfo")//day11.详情页
    public Productinfo getproductinfo(@RequestParam Integer pId){
        return psi.selectByPrimaryKey(pId);
    }


    @RequestMapping("/selectAllProductsByP_types")//day12,后台上下架根据商品查询出来所有的产品,用上衣个页面,就是只会有显示第一页的产品
    public List<Productinfo> selectAllProductsByP_type(@RequestParam String p_type) {
        return psi.selectAllProductsByP_types(p_type);
    }


}
