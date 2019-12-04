<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //就是拼项目的全路径.仔细看还有端口号
    //这段代码的意思是获取当前项目的路径，如：http://localhost:8080/项目名称。
%>

<html>
<head>
    <base href="<%=basePath%>">
    <title>商城主页</title>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>resource/css/style.css">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>

   <style>

       #myframe{
           display: none;
           width: 100%;
           height: 1000px;
           border:0;
           scrolling: no;
           margin-top: 0;
       }

       #topImg{
           display: none;
           position: fixed;
           right:10px;
           bottom:200px;
       }

      #carImg{
          position: fixed;
          right:10px;
          bottom:150px;
       }


   </style>

</head>
<body>
<div class='intro'>
    <div class='center'>
        <div class='core'></div>
        <div class='outer_one'>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
            <div class='outer_one__piece'></div>
        </div>
        <div class='outer_two'>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
            <div class='outer_two__piece'></div>
        </div>
        <div class='outer_three'>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
            <div class='outer_three__piece'></div>
        </div>
        <div class='outer_four'>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
            <div class='outer_four__piece'></div>
        </div>
        <div class='outer_five'>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>
            <div class='outer_five__piece'></div>

        </div>

        <div class='pieces'>








            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>
            <div class='future_ui__piece blank'></div>

        </div>
    </div>
</div>
<iframe  id="myframe"></iframe>
<%--动态的引入图片--%>
<img src="<%=basePath%>resource/images/top.png" id="topImg"/>
<img src="<%=basePath%>resource/images/car.png" id="carImg"/>
<script>

$(function(){
/*一进页面就发请求查询所有的类别*/
   $.ajax({
      url:"selectAllp_type",
       type:"post",
       success:function(data){

         for(var i=0;i<data.length;i++){
             var str="            <div class='future_ui__piece'><span><a ><font color ='white' size='7'>"+data[i]+"</font></a></span>" +
                 "                <div class='line'></div>" +
                 "                <div class='tip'></div>" +
                 "            </div>";
             $(".pieces").prepend(str);
         }
       }
   });


   //2.就是这个on就是是想要获取点击当前想要的信息,哟啊不然那我怎么知道我点点击是哪个文本框
   $(".pieces").on("click",".future_ui__piece",function(){
       // alert($(this).children().children().children().text());//显示就是文本内容,嵌套.就是也能获取.会有包所以在网页上追加text(),会选择在前面children
       var type=$(this).children().children().children().text();
       //   $("#myframe").attr("src","<%=basePath%>resource/shop/showProducts.jsp?p_type="+type+"&username="+getQueryString("username"));就是从上一个页面传值,到下一个页面接受
       $("#myframe").attr("src","<%=basePath%>resource/shop/showProducts.jsp?p_type="+type);//就是使用cokie

       $(".intro").hide();
       $("#myframe").show();
       $("#topImg").show();


   });

   $("#topImg").click(function(){
       $(".intro").show();
       $("#myframe").hide(1000);
       $("#topImg").hide();
   });


   $("#carImg").click(function () {//购物车引入发哦那个界面函数在那个界面写
       if (getCookie("username") == "null" ||getCookie("username") == "" || getCookie("username") == undefined) {
           //alert("没登录")测试用的
           location.href = "<%=basePath%>resource/login/login.jsp";
       }else{
           //就是代开新页面,还是替换新页面,(window.loaction.href)
           window.open("<%=basePath%>resource/shop/carItems.jsp");
       }

   })

});

//就是地址栏获取里上一个页面传过来的参数,就是个格式固定的,只需要改一下响应的参数就可以了
function getQueryString(name){
    var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if(r!=null)
        return  decodeURI(r[2]);
    return null;
}

//就是是否cookie的方法,
function getCookie(name) {
    var strcookie = document.cookie;
    var arrcookie = strcookie.split(";");
    for (var i = 0; i < arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if (arr[0] == name) {
            return arr[1];
        }
    }
    return "";
}


</script>

</body>
</html>
