package controller;

import com.sun.imageio.plugins.common.I18N;
import entity.Productinfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import serviceImpl.ProductInfoServiceImpl;

import java.util.List;

@RestController
public class adminCotroller {
    @Autowired
    ProductInfoServiceImpl psi;

    @RequestMapping("/getUpAndDownProducts")
    public  List<Productinfo>getUpAndDownProducts(){
        List<Productinfo> list=psi.selectUpAndDownProducts();
        System.out.println(list.toString());
        return list;
    }

    /*点击商品下架，把商品状态修改为1，1是下架,o是上架.2是修改*/
    @RequestMapping("/upAndDownProdunts")
    public int upAndDownProdunts(@RequestParam  String pId,@RequestParam String status){
        Productinfo pi = new Productinfo();
       pi.setpId(Integer.parseInt(pId));

        System.out.println(pId);
        System.out.println(status);
       if(status.equals("上架")){
        pi.setStatus(0);
       }else if(status.equals("下架")){
           pi.setStatus(1);
       }else if(status.equals("打折")){
           pi.setStatus(2);
       }

        return psi.updateByPrimaryKeySelective(pi);
     /*  if(i>0){
           return "ok";
       }else{
           return "false";
       }*/

    }



}
