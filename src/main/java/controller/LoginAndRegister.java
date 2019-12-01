package controller;

import entity.Userinfo;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import serviceImpl.UserServiceImpl;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.Date;

//你好的你的夫人
@RestController//等价属于 @Controller +@ Responbody
public class LoginAndRegister {
    //如果就是报错,就看service那个注解家里没有..
    //为甚new不行,注入就行了,就是会把错了,null空指针异常,为什么
    //就是spring装的组件, 任何组件就是得给spring管理,找不大就会报空指针异常,,就是 相当不属于就是淡季游戏,空顶不可以
    //就是so手动加入bean
//意义上就是注入的service是实现类,可以不可以创建service 是是实现类,,没有就是后面springboot就是到服务没法发布
    @Autowired
    UserServiceImpl usi;

    @RequestMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, @RequestParam String flag, HttpServletRequest req, HttpServletResponse rsp){
    //先判断,是否哟这个用户,
    Userinfo ui = usi.selectByName(username);
    if (ui==null){
        return "none";
    }else{
        //就是密码要从页面(也就是标签的文本)获取pssword.进行加密,然后在和数据查询出来的密码进行比对.
        if(DigestUtils.md5Hex(password.getBytes()).equals(ui.getPassword())){
            //用户名都正确的请情况才能进行设置
            //这个flag就是判断是否勾选住了密码.怎么让他记住使用session.
            if(flag.equals("yes")){
                ui.setPassword(password);//就往文本框里面设置密码.

                //1.就是使用sesion获取is
               // req.getSession().setAttribute("info",ui);//就是怎么在页面取值就是,el表达式,就是seesion.scope.属性
              //  System.out.println("****"+req.getSession().getAttribute("info"));//测试用的信息.就是打印出的信息



                //2.使用cookie记住密码
               // String loginInfo = username+";"+password;
                // Cookie userCookie=new Cookie("loginInfo",loginInfo);


                Cookie cookie = new Cookie("username",username);
                Cookie cookie1 = new Cookie("password",password);

                cookie.setMaxAge(30*24*60*60);   //存活期为一个月 30*24*60*60
                cookie1.setMaxAge(30*24*60*60);

                rsp.addCookie(cookie);
                rsp.addCookie(cookie1);

                System.out.println("**********************************"+req.getCookies());//测试用的

            }else {
                //   req.getSession().removeAttribute("info");//如果mei有就是移除我们的session,当用户名下次不勾选的时候就是不记住的选项

                Cookie[] cookies = req.getCookies();
                System.out.println(cookies + "不选中");
                if (cookies.length > 0) {
                    for (Cookie c : cookies) {
                        if (c.getName().equals("username") || c.getName().equals("password")) {
                            c.setValue(null);
                            c.setMaxAge(0);
                            rsp.addCookie(c);
                        }
                    }
                }

            }
            return "yes";
        }else{
            return "no";
        }
    }

    }


    @RequestMapping("/register")
  public String register(@RequestParam String username, @RequestParam String password,  @RequestParam String email){
  if(usi.selectByName(username)!=null){
    /*如果查询结果不额为空,说明该用户已将存在,不允许注册*/
    return  "existed";
  }else{
    Userinfo ui  = new Userinfo();
    ui.setUsername(username);
    ui.setPassword(DigestUtils.md5Hex(password.getBytes()));
    ui.setEmail(email);
    Date date  = new Date();
    SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    ui.setRegisterTime(sdf.format(date));

    int line = usi.insert(ui);
    if (line>0){
        return "yes";
    }else {
        return "no";
    }
}
    }

@RequestMapping("/ChangePassword")
    public  String ChangePassword(@RequestParam String username, @RequestParam String password){
    Userinfo ui = usi.selectByName(username);
    if (ui==null){
       //如果查询的结果为空的话说明,该用户名不存在
        return  "noexisted";
    }else{
        //不为空,说明有值...就可以对其进行修改
        ui.setPassword(DigestUtils.md5Hex(password.getBytes()));
        int line = usi.updateByPrimaryKeySelective(ui);
        if(line>0){
            return "yes";
        }else{
            return "no";
        }

    }
}


}
