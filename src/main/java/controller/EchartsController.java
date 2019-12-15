package controller;

/*设置折线图和饼状图*/
//    动态的json数组怎么塞东西,

import entity.WebInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import serviceImpl.WebInfoServiceImpl;

import java.util.List;

/*折线图*/
@RestController
public class EchartsController {
 @Autowired
    WebInfoServiceImpl wsi;

    @RequestMapping("/getWebData")
    public List<WebInfo>  selectAll(){
        return  wsi.selectAll();
    }

}
