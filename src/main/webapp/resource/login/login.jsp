<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false"%>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <base href="<%=basePath%>">
  <title>登录注册</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
  <link rel="stylesheet" href="<%=basePath%>resource/css/login.css" type="text/css" media="all">
  <style>
    #msg,#msg2{
      color: white;
    }

  </style>



</head>

<body>
<h1>登录注册</h1>
<div class="container w3layouts agileits">
  <div class="login w3layouts agileits">
    <h2>登 录</h2>

    <input type="text"      id="username1"  placeholder="用户名" >
    <input type="password"  id="password1" placeholder="密码"   >

    <ul class="tick w3layouts agileits">
      <li>
        <input type="checkbox" id="brand1" value="" >
        <label for="brand1"><span></span>记住我</label>
      </li>
    </ul>

    <div class="send-button w3layouts agileits">
      <input type="button" value="登 录" id="btnLogin">
      <div id="msg"></div>
    </div>



    <a href="<%=path%>/resource/login/forgetPwd.jsp" target="_blank">忘记密码?</a>



  </div>

  <div class="register w3layouts agileits" id="registerDiv">
    <h2>注 册</h2>
    <input type="text"       id="username2"         placeholder="用户名"   >
    <input type="password"   id="password2"     placeholder="密码"     >
    <input type="text"       id="email"        placeholder="邮箱"     >

    <div class="send-button w3layouts agileits">
      <input type="button" value="免费注册" id="btnRegister">
      <div id="msg2"></div>

    </div>


    <div class="clear"></div>

  </div>

  <div class="clear"></div>
</div>

<div class="footer w3layouts agileits">
  <p>Copyright &copy; More Templates</p>
</div>

<input type="hidden" value="<%=basePath%>" id="hidd">

<script type="text/javascript">
    //就是没哟进行修改执勤的代码可以翻看一下以前的代码可以尽心看一下...
    // 1.这个代码还是有冗余.后面的else代码是不是很多余..进行适当的修改.就是当返回值为yes/或者no的时候
    //2.才是代码记住密码选框会发现虽然选中是掉了.你会发现刷新一下,记住密码还是刷掉..
    //3.当用户记住密码的时候,怎么刷新也不行,就是依然是默认选中记住密码的.
    //4.当用户不记住密码的时候的而又应该是怎么实现的
    //5.进行功能的完善,就在密码和用户名不为空的时候,进行如下ajax判断
    //6.当标签内没有内容的时候在增加一种判断"用户名或者不为空",注册和登录
  $(function(){

//就是把session取出来,在jsp页面中使用
    var username = "${sessionScope.info.username}";
    var password = "${sessionScope.info.password}";

//记住密码后从session中获取用户名或密码,填充到页面里
    $("#username1").val(username);
    $("#password1").val(password);

    //3.就是判断当用户名文本框不为空的时候,就取来记住我的那个标签,往里面attr值,就是选中的,4.否则不选中的
    if($("#username1").val()!=''&&$("#password1").val()!=''){
      $("input[type='checkbox']").attr("checked","checked");
    }else{
      $("input[type='checkbox']").removeAttr("checked");
    }

    $("#btnLogin").click(function(){
      var flag;//1.就是出之前代码的多余的else{ajax},就是当返回值为yes/或者no的时候
      //在C之前就判断这个标签是否被选中,就是地址栏id是否等于on
      if($("input[type='checkbox']").is(':checked')){
        flag="yes";
      }else{
        flag="no";
      }
      if($("#username1").val()!=''&&$("#password1").val()!=''){//5.进行功能的完善,就在密码和用户名不为空的时候,进行如下ajax
        $.ajax({
          url:"login",
          type:"post",
          data:{
            "username":$("#username1").val(),
            "password":$("#password1").val(),
            "flag":flag
          },
          success:function(data){

            if(data=="none"){
              $("#msg").html("用户不存在")
            }else if(data=="yes"){
              //跳转页面
              $("#msg").html("成功")
            }else{
              $("#msg").html("用户名或密码错误")
            }
          }
        })
      }else{//6.
        $("#msg").html("用户名或密码为空")
      }
    });

    //就是先写注册的页面
    $("#btnRegister").click(function(){
      if($("#username2").val()!=''&&$("#password2").val()!=''&&$("#email").val!=''){//就是在用户文本框都给空的情况给个判断
        $.ajax({
          url:"register",
          type:"post",
          async:false,
          data:{//参数的回调,就是获取这小额标签的返回值
            "username":$("#username2").val(),
            "password":$("#password2").val(),
            "email":$("#email").val()
          },
          success:function(data){
            if(data=="existed"){//根据controller写的是什么在做判断
              $("#msg2").html("用户名已存在");
            }else if(data=="yes"){
              $("#msg2").html("注册成功");
            }else{
              $("#msg2").html("注册失败");
            }
            return false;//就是为了防止虚读=幻读,这种情况防止通知,就是同时一秒钟插入7条数据
          }
        })
      }else{
        $("#msg2").html("信息填写不完整")
      }
    })
  })

</script>

</body>


</html>
