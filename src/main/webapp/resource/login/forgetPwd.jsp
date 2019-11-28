<%--
  Created by IntelliJ IDEA.
  User: pmj
  Date: 2019/11/26
  Time: 15:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>

<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>

    <script>
        $(function () {
            $("#btn").click(function () {
                $.ajax({
                   url:"../../ChangePassword",//或者就是自己上面定义就是自己引入一个
                    type:"post",
                        data:{
                       "username":$("#username").val(),
                            "password":$("#password").val(),
                            "email":$("#email").val()
                        },
                    success :function (data) {
                        if(data=="noexisted"){
                        $("#msg").html("用户名不存在");
                        }else if(data=="yes"){
                            $("#msg").html("修改成功");
                        }else{
                            $("#msg").html("修改失败");
                        }
                        return false;//就是为了防止虚读或者幻读,这种情况防止通知
                    }

                })
            })

        })
    </script>
</head>
<body>
<h1>忘记密码,请输入你的用户名</h1>
<input type="text"       id="username"         placeholder="用户名"   ><br>
<input type="password"   id="password"     placeholder="新密码"     ><br>
<input type="text"       id="email"        placeholder="邮箱"     ><br>
<button id="btn">找回密码</button>
<div id="msg"></div>
</body>
</html>
