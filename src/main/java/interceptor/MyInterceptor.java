package interceptor;

import entity.WebInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import serviceImpl.WebInfoServiceImpl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MyInterceptor implements HandlerInterceptor {

    //    注入WebInfoServiceImpl
    @Autowired
    WebInfoServiceImpl wsi;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    //获取时间将时间,将date类型时间转为String类型,
        Date date = new Date();
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM");//时间就是大概就是到月份
        String now=sdf.format(date);
        //通过时间查询
       WebInfo wi = wsi.selectByVisitTime(now);
         if(wi==null){
             //信息为空，则把此刻的信息塞进表格
             wi=new WebInfo();//如果为空就是new一下
          wi.setVisittime(now);
          wi.setVisittimes(1);
          wsi.insert(wi);
         }else{
            //不等于空,就把信息更新,就是sql语句已经+1,在这个里就不用了+1操作
             wsi.update(wi);
         }


        return true;//false就是不放行,过不了
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
