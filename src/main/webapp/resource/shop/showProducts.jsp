<%--
  Created by IntelliJ IDEA.
  User: pmj
  Date: 2019/11/27
  Time: 14:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <%--加上项目名,在访问路径的时候,--%>
    <base href="<%=basePath%>">
    <title>Title</title>
        <meta charset="UTF-8">
        <title>sHover|感应鼠标进出方向悬浮效果</title>
        <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <link rel="stylesheet" href="<%=basePath%>resource/css/example.css">
        <script src="<%=basePath%>resource/js/sHover.min.js"></script>
</head>
<body id="body">
<div id="part3" class="part">
    <div class="container">


    </div><!-- /container -->


</div><!-- /part3 -->

<%--就是原生的js，就是会有节点加载不出来，所以建议srcpt代码放到下面，好管理，就是建议jsp放到下面--%>
<script>
    //window.onload==$.
    window.onload=function(){


        $.ajax({
            url:"selectAllProductsByP_type",
            type:"post",
            data:{
                "p_type":getQueryString("p_type")

            },
            success:function (data) {
               // alert(data);
            //console.log(data);//就是在控制台打印信息(就是所有的获取的信息)..
                for(var i=0;i<data.length;i++){
                    var str = " <div id='item1'  class='sHoverItem'>" +
                        "<img id='img1' src='<%=basePath%>resource/images/1.jpg'>" +
                        "<span id='introl' class='sIntro'>" +
                        "<h2>"+data[i].pName+"</h2>" +
                        "<p>"+data[i].intro+"</p>" +
                        "<p>$"+data[i].price+"</p>" +
                        "<button>立即购买<tton>" +
                        "<button>加入购物车<tton>" +
                        "</span>" +
                        "</div>"


                    $(".container").append(str);
                }
            }

        })

        var b=new sHover('head','headIntro');

        var a=new sHover("sHoverItem","sIntro");
        a.set({
            slideSpeed:5,
            opacityChange:true,
            opacity:80
        });


        var example1Btn=document.getElementById('example1Btn');
        var part1arrow=document.getElementById('part1arrow');
        var example1=document.getElementById('example1');


        var example2=new sHover('example2','intro2');
        example2.set({
            slideSpeed:7,
            opacity:80,
            opacityChange:true
        });
        var example2prev=new sHover('example2prev','intro2prev');
        example2prev.set({
        });

    }
    function scrollToBottom(a){
        if(windowHeight()){
            clearInterval(a.scrollTimer);
            var scrollSpeed=100;
            a.scrollTimer=setInterval(function(){
                document.documentElement.scrollTop+=scrollSpeed;
                document.body.scrollTop+=scrollSpeed;
                if((document.documentElement.scrollTop>=(document.documentElement.scrollHeight-windowHeight()))||(document.body.scrollTop>=(document.documentElement.scrollHeight-windowHeight()))){
                    clearInterval(a.scrollTimer);
                }
            },13);
        }else{
            //a.setAttribute('href', 'http://www.baidu.com');
        }
    }
    function windowHeight(){
        if(document.documentElement){
            return document.documentElement.clientHeight;
        }else{
            return document.body.clientHeight;
        }
    }

    //就是地址栏获取里一个页面传过来的参数,就是个格式固定的,只需要改一下响应的参数就可以了
    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)
            return  decodeURI(r[2]);
        return null;
    }

</script>



</body>
</html>
