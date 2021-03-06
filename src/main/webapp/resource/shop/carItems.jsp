<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>My JSP 'shopping.jsp' starting page</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="<%=basePath%>resource/css/resetcar.css">
    <link rel="stylesheet" href="<%=basePath%>resource/css/carts.css">
    <link rel="stylesheet" href="<%=basePath%>resource/css/search.css">

    <style>

        label .mark{
            background: url("<%=basePath%>images/mark1.png") no-repeat -1px -1px;
        }



        .calBtn1{
            border:1px solid #708090;
            width:100px;
            height:50px;
            float: right;
            line-height: 50px;
            text-align: center;
        }

        .payDiv:hover{
            cursor: pointer;
        }


        #pop{
            border:5px solid #2F4F4F;
            width: 800px;
            height:480px;
            position: absolute;
            top:20px;
            left:230px;
            background-color: #87CEFA;

        }

        body{
            z-index: 10;
        }

        #closeImg{
            width: 40px;
            height:40px;
            position: absolute;
            right:0;
            top:0;
            z-index: 5;

        }

        #big{
            display: none;
            background-color: black;
            width:100%;
            height:100%;
            top:0;
            opacity: 0.8;
            position: fixed;
            z-index:100;

        }

        #MyDiv{

            display: none;
            width: 65%;
            height: 80%;
            border:16px solid #2E8B57;
            background-color:	#BDB76B;
            position: fixed;
            top:8%;
            left: 16%;
            z-index:120;

        }

        .calBtn1:hover{
            cursor: pointer;
        }

        #closeImg:hover{
            cursor: pointer;
        }


        #sendMail{
            position: absolute;
            right:120px;
            top:34px;
        }

        #surePay{
            position: absolute;
            left:247px;
            top:100px;
        }


    </style>
</head>
<body>
<section class="cartMain">

    <div class="cartMain_hd"><%--就是后期是商家的页面的商家的页面商品里面--%>
        <ul class="order_lists cartTop">
            <li class="list_chk">
                <!--所有商品全选-->
                <input type="checkbox" id="all" class="whole_check">
                <label for="all" id="firstLabel"></label>
                全选
            </li>
            <li class="list_con">商品名称</li>
            <li class="list_info">商品介绍</li>
            <li class="list_price">单价</li>
            <li class="list_amount">数量</li>
            <li class="list_sum">金额</li>
            <li class="list_op">操作</li>
        </ul>
    </div>



    <div class="cartBox">

        <div class="shop_info">
            <div class="all_check">
                <!--店铺全选-->
                <input type="checkbox" id="shop_a" class="shopChoice">
            </div>

        </div>

        <div class="order_content">


        </div>



    </div>





    <!--底部-->
    <div class="bar-wrapper">
        <div class="bar-right">
            <div class="piece">已选商品<strong class="piece_num">0</strong>件</div>
            <div class="totalMoney">共计: <strong class="total_text" >0.00</strong></div>
            <div class="calBtn1">结算</div>
        </div>
    </div>
</section>

<div id="big"></div>
<div id="MyDiv">
    <img src="<%=basePath%>resource/images/close.png" id="closeImg">
    <div class="search d1">
        <form>
            <input type="text" placeholder="请输入验证码完成付款" id="code">
        </form>

    </div>

    <button type="button" class="btn btn-success" id="sendMail">发送验证码</button>
    <button type="button" class="btn btn-success" id="surePay">确认付款</button>
    <div id="msg"></div>

</div>




<script type="text/javascript">
    var flag=true;
    $(function (){

        $.ajax({
            url:"getCar",//就是一上来就取购物车的信息
            type:"post",
            data:{
                //或者就是"${cookie.username.value }"
                "username":getCookie("username")
            },
            success:function(data){
                for(var i=0;i<data.length;i++){
                    var ul="<ul class='order_lists'>" +

                        "                <li class=\"list_chk\">\n" +
                        "                    <input type=\"checkbox\" id=\"checkbox_2\" class=\"son_check\">\n" +
                        "                    <label for=\"checkbox_2\"  pid='"+data[i].pId+"' pnum='"+data[i].pNum+"'></label>\n" +
                        "                </li>\n" +
                        "                <li class=\"list_con\">\n" +
                        "                    <div class=\"list_img\"><a href=\"<%=basePath%>resource/shop/productdetail.jsp?pi="+data[i].pId+"\" target=\"_blank\"><img src='<%=basePath%>"+data[i].pic+"' alt=\"\"></a></div>\n" +
                        "                    <div class=\"list_text\"><a href=\"<%=basePath%>resource/shop/productdetail.jsp?pi="+data[i].pId+"\" target=\"_blank\">"+data[i].pName+"</a></div>\n" +
                        "                </li>" +
                        "                <li class=\"list_info\">" +
                        "                    <p>"+data[i].intro+"</p>" +
                        "                </li>" +
                        "                <li class=\"list_price\">" +
                        "                    <p class=\"price\">"+data[i].price+"</p>" +
                        "                </li>" +
                        "                <li class=\"list_amount\">" +
                        "                    <div class=\"amount_box\">" +
                        "                        <a href='javascript:;' class='reduce reSty' pid='"+data[i].pId+"'>-</a>" +
                        "                        <input type='text' value='"+data[i].pNum+"' class='sum' >" +
                        "                        <a href='javascript:;' class='plus' pid='"+data[i].pId+"'>+</a>" +
                        "                    </div>" +
                        "                </li>" +
                        "                <li class='list_sum'>" +
                        "                    <p class='sum_price'>"+(data[i].price*data[i].pNum)+"</p>" +
                        "                </li>" +
                        "                <li class='list_op'>" +
                        "                    <p class='del'><a href='javascript:;' class='delBtn' pid='"+data[i].pId+"'>移除商品</a></p>" +
                        "                </li>" +
                        "            </ul>";

                    $(".order_content").append(ul);

                }


                $("section").on("click","label",function () {

                    var lid=$(this).attr("id");
                    //全选
                    if(flag&&(lid=='firstLabel')){
                        $("label").addClass("mark");
                        flag=false;

                    }else if(!flag&&(lid=='firstLabel')){
                        $("label").removeClass("mark");
                        flag=true;
                    }

                    //单个多选

                    if(flag&&lid!='firstLabel'){
                        // $(this).addClass("mark");

                        if($(this).attr("class")=="mark"){
                            $(this).removeClass("mark");

                        }else{
                            $(this).addClass("mark");
                        }
                        flag=false;
                    }else if(!flag&&lid!='firstLabel'){
                        if($(this).attr("class")=="mark"){
                            $(this).removeClass("mark");
                        }else{
                            $(this).addClass("mark");
                        }
                        flag=true;
                    }

                    if($("label[class='mark']").length==$("label").length){
                        var labels=$("label");

                    }else if($("label[id='firstLabel']").attr("class")!='mark'&&($("label[class='mark']").length==$("label").length-1)){
                        $("label[id='firstLabel']").addClass("mark");

                    }else{
                        $("label[id='firstLabel']").removeClass("mark");
                    }


                    var labels=$("label[id!='firstLabel']label[class='mark']");
                    calcuPrice(labels);

                })

            }

        });

     //day11,就是点击事件点击图片就是跳转到详情页
     /*   $(".cartBox").on("click",".",function(){

        }*/

        $(".cartBox").on("click",".plus",function(){//数量是加数量
//就是说今后商家不同,商品就不是拼在order_lists,而是就是拼在,cartMain_hd这个标签里面
            $(this).prev().val(parseInt($(this).prev().val())+1);

            var labels=$("label[id!='firstLabel']label[class='mark']");
            var price=parseInt($(this).parent().parent().parent().children().eq(3).find("p").text());
            var totalNum=parseInt($(this).parent().parent().parent().children().eq(4).find("input").val());
            var totalCount=price*totalNum;
            $(this).parent().parent().parent().children().eq(5).find("p").html(totalCount);
            $(this).parent().parent().parent().children().eq(0).find("label").attr("pnum",$(this).prev().val());

            calcuPrice(labels);

            $.ajax({
                url:"reduceItemsNum",
                type:"post",
                data:{
                    "pnum":$(this).prev().val(),
                    "username":getCookie("username"),
                    "pid":$(this).attr("pid")
                }
            });

        });


        $(".cartBox").on("click",".reduce",function(){
            if($(this).next().val()<=1){
               // $(this).next().val(0);

                //当值不等于1等发送请求,就是移除掉,然后就是掉用下面的请求

                $(this).parent().parent().parent().hide();
            }else{
                $(this).next().val(parseInt($(this).next().val())-1);
            }

            $(this).parent().parent().parent().children().eq(0).find("label").attr("pnum",$(this).next().val());


            var labels=$("label[id!='firstLabel']label[class='mark']");
            var price=parseInt($(this).parent().parent().parent().children().eq(3).find("p").text());
            var totalNum=parseInt($(this).parent().parent().parent().children().eq(4).find("input").val());
            var totalCount=price*totalNum;
            $(this).parent().parent().parent().children().eq(5).find("p").html(totalCount);

            calcuPrice(labels);

            $.ajax({
                url:"reduceItemsNum",
                type:"post",
                data:{
                    "pnum":$(this).next().val(),
                    "username":getCookie("username"),
                    "pid":$(this).attr("pid")
                }
            });
        });


        $(".cartBox").on("onkeyup",".sum",function() {
 //功能带测试
                $.ajax({
                    url: "handdata",
                    type: "post",
                    data: {
                        "pid": $(this).attr("pid"),
                        "username": getCookie("username")
                    }
                    //移除了就移除了就不需要fankui
                })

        });



        $(".cartBox").on("click",".delBtn",function(){
            $(this).parent().parent().parent().remove();
            $.ajax({
                url:"removeItems",
                type:"post",
                data:{
                    "pid":$(this).attr("pid"),
                    "username":getCookie("username")
                }
                //移除了就移除了就不需要fankui
            })
        });







        $(".calBtn1").click(function(){
            if($("label[class='mark']").length>=1){
                $("#big").show();
                $("#MyDiv").show();
                $("#code").val('');
            }

        });


        $("#closeImg").click(function(){
            $("#big").hide();
            $("#MyDiv").hide();

        })


        var checkCode;
        $("#sendMail").click(function () {
            alert(getCookie("username"));
            $.ajax({
                url:"sendEmail",//就是发送邮箱
                type:"post",
                data:{
                    "username":getCookie("username"),
                    "sendMail":$("sendMail").val()
                },
                success:function(data){
                    checkCode=data;//验证码,检验
                   if(data =='yes' ) {//就是写个div定时显示,以后消失,自己就是一个人功能
                   }


                }
            })
        })


        $("#surePay").click(function () {//确认付款,就是多个订单一起支付
            // if($("#code").val()==checkCode){
            $("#big").hide();
            $("#MyDiv").hide();


            var labels=$("label[id!='firstLabel']label[class='mark']");
            for(var i=0;i<labels.length;i++){//labels多个商品支付,一个进行遍历,循环进行发送ajax

                labels.eq(i).parent().parent().remove();
                $("total_text").html("0.00");

                $(".calBtn1").removeClass("payDiv");
                $(".calBtn1").css("background","#E5E5E5");

                $.ajax({//进行循环发送ajax
                    url:"removeItems",
                    type:"post",
                    data:{
                        "username":getCookie("username"),
                        "pid":labels.eq(i).attr("pid")
                    }

                });


                $.ajax({//进行循环发送ajax,删茶数量并结算订单
                    url:"deleteProductNum",
                    type:"post",
                    data:{
                        "username":getCookie("username"),
                        "pid":labels.eq(i).attr("pid"),
                        "pnum":labels.eq(i).attr("pnum")
                    }

                });





            }

            // }
        })

        //就是定时器
        function clearMsg(){
            $("#msg").html('');
        }



    });



    function calcuPrice(labels) {//calcuPrice就是计算价钱//labels就是标签
        changepayDivColor(labels);

        if(labels.length>=2){
            var totalCount=0;
            var totalNum=0;
            for(var i=0;i<labels.length;i++){
                var totalCount2=labels.eq(i).parent().parent().children().eq(5).find("p").text();
                var totalNum2=labels.eq(i).parent().parent().children().eq(4).find("input").val();
                totalCount+=parseInt(totalCount2);
                totalNum+=parseInt(totalNum2);
                $(".total_text").text(totalCount);
                $(".piece_num").text(totalNum);
            }


        }else if(labels.length==1){
            var totalCount=labels.eq(0).parent().parent().children().eq(5).find("p").text();
            var totalNum=labels.eq(0).parent().parent().children().eq(4).find("input").val();
            $(".total_text").text(totalCount);
            $(".piece_num").text(totalNum);
        }else{
            $(".total_text").text("0.00");
            $(".piece_num").text("0");
        }

    }

    function changepayDivColor(labels) {
        if (labels.length > 0) {
            $(".calBtn1").addClass("payDiv");
            $(".calBtn1").css("background","#FFD700");

        }else{
            $(".calBtn1").removeClass("payDiv");
            $(".calBtn1").css("background","#E5E5E5");

        }
    }

    function getQueryString(name){
        var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if(r!=null)
            return  unescape(r[2]);
        return null;
    }

    function getCookie(name){
        var strcookie = document.cookie;
        var arrcookie = strcookie.split("; ");
        for ( var i = 0; i < arrcookie.length; i++) {
            var arr = arrcookie[i].split("=");
            if (arr[0] == name){
                return arr[1];
            }
        }
        return null;
    }



</script>

</body>
</html>
