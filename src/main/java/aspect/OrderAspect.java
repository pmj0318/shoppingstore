package aspect;

import entity.Orderdetail;
import entity.Orderinfo;
import entity.Userinfo;
import mapper.OrderinfoMapper;
import mapper.UserinfoMapper;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.springframework.beans.factory.annotation.Autowired;
import serviceImpl.OrderInfoServciceImpl;
import serviceImpl.OrderdetailServiceImpl;
import serviceImpl.UserServiceImpl;

import java.text.SimpleDateFormat;
import java.util.Date;

public class OrderAspect {
    @Autowired
    OrderdetailServiceImpl odsi;

    @Autowired
    OrderInfoServciceImpl osi;

    @Autowired
    UserServiceImpl usi;

    /*
     * 前置通知
     * */
    public void beforeCheck(JoinPoint joinPoint) {
       // Signature sig=joinPoint.getSignature();

 /*       System.out.println("before at "+sig.getName()+"and arg[0] is "+joinPoint.getArgs()[0]);*/

    }

    /*
     *后置通知
     *无法获取返回值 。可以通过返回通知获取返回值
     *且后置通知无论方法是不是异常都会执行
     * */
    public void afterCheck(JoinPoint joinPoint) {
       // Signature sig=joinPoint.getSignature();

        /*System.out.println("After at "+sig.getName()+"and arg[0] is "+joinPoint.getArgs()[0]);*///就会报错,控制空指针异常

    }

    /*
     * 返回通知
     * 就是能或获取方法的返回结果,就是订单结束的结果,返回的yes就是菜会执行aop
     * 就是配置了环绕了,就是result记结果就是从环绕里面解的,就是环绕是不能注释的
     * */
    //Object res和配置文件里的returning="res"名字一致,用来获取Controller里方法的返回值

    /**
     * 1.获取上一订单结算yes,那个放的里名字,和里面的参数,事项完的参数怎么获取point.参数是不是有顺序的
     * Signature sig=joinPoint.getSignature();joinPoint.getArgs()[0]获取里面的参数
     * 2.数据表设计就是主键没法是获取的,因为是主键没序列生成的,,没办法获取的序列号,也不适合我们,就是pid就是叮单号,就是和普通名字,和时间锤,和用户名随机生成
     * 3.参数是3个是开那直白哦
     *
     */
    public void afterReturn(JoinPoint joinPoint,Object res) {

        if(res.toString().equals("yes")){
            System.out.println("===="+joinPoint.getArgs()[0]);//这个顺序是有顺序的
            System.out.println("===="+joinPoint.getArgs()[1]);
            System.out.println("===="+joinPoint.getArgs()[2]);

            Orderinfo oi = new Orderinfo() ;//这个东西是不是可以new,能不能获取,想获取必须在类上面家族间,@compnent
            Userinfo ui = new Userinfo();
            Orderdetail od = new Orderdetail();

            oi.setUserid(usi.selectUidByUsername((String) joinPoint.getArgs()[0]));//需要强转
            oi.setStatus(0);//商品的状态,默认是0
            Date date = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH:mm:ss");
            oi.setOrdertime(sdf.format(date));//      String orderTime=sdf.format(date);

             Long time = System.currentTimeMillis();//毫秒数.太大了//这里就是给他强转,因为设置的时候设置pid的时候低num类型
            int randomNum =(int)((Math.random()*9+1)*100000);
            System.out.println(randomNum);
            // String realNum = time+""+randomNum;
          //  oi.setoId(randomNum);
            oi.setPid(randomNum);

            od.setOdId(randomNum);//关联是上了
            od.setpId((Integer)joinPoint.getArgs()[1]);//获取第二参数
            od.setOdNum((Integer)joinPoint.getArgs()[2]);

            osi.insert(oi);
            odsi.insert(od);//然后就是插入



        }

/*        Signature sig=joinPoint.getSignature();
        System.out.println("After at "+sig.getName()+"return. res= "+res);*/

    }


    /*
     * 异常通知
     * 注意如果这个方法的参数：假设异常类型为数学除零的异常
     * afterThrow(JoinPoint joinPoint,空指针异常类 ex) 然后我这里写了空指针异常
     * 那afterThrow这个方法就执行不了 因为类型不对
     * */
    public void afterThrow(JoinPoint joinPoint,Exception ex) {

        Signature sig=joinPoint.getSignature();
        System.out.println("After at "+sig.getName()+"Throw. message= ");
        System.out.println(ex.getMessage());
    }

    /*
     * 环绕通知
     * 环绕通知就等于整个代理过程交给你自己处理  连被代理对象的要执行的目标方法要不要执行也取决你
     * 上面几个通知比较像 处理目标方法调用的某个时刻的 处理过程
     * */
    public Object around(ProceedingJoinPoint pJoinPoint) {

       Object res=null;
        String methodName=pJoinPoint.getSignature().getName();

        System.out.println(methodName+" 执行前(前置通知)");
        try {

            res=pJoinPoint.proceed();
            System.out.println(methodName+" 执行后有结果(返回通知)");
        } catch (Throwable e) {

            System.out.println("异常通知 "+e.getMessage());
        }
        System.out.println(methodName+" 执行后(后置通知)");
        return res;
      //return null;//就是相当当于不要环绕通知,后期就是配置了就是哟啊用他那个result结果就是从环绕里的面接的结果
    }

}



