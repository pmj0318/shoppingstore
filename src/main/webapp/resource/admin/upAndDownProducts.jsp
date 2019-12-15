<%--
  Created by IntelliJ IDEA.
  User: pmj
  Date: 2019/12/10
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
<head>
 <%--   <meta http-equiv="refresh" content="20"> 刷新自动--%>
    <title>上架商品</title>
    <base href="<%=basePath%>">
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>

    <style>

        .up{
            width: 90px;
            height: 35px;
            background-color:green;
            color: white;
            font-family: 微软雅黑;
        }

        th,td{
            text-align: center;
            color: white;
            font-family: 微软雅黑;
        }
    </style>


</head>
<body id="body">


<table class="table1">
    <thead>
    <tr>
        <th>商品ID</th>
        <th>商品编号</th>
        <th>商品名称</th>
        <th>商品类型</th>
        <th>品牌</th>
        <th>商品数量</th>
        <th>商品价格</th>
        <th>商品折扣</th>
        <th>商品介绍</th>
        <th>商品状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="tbody1"><%--就是表格的正文--%>

    </tbody>


</table>

<hr>
<hr>

<table class="table">
    <thead>
    <tr>
        <th>商品ID</th>
        <th>商品编号</th>
        <th>商品名称</th>
        <th>商品类型</th>
        <th>品牌</th>
        <th>商品数量</th>
        <th>商品价格</th>
        <th>商品折扣</th>
        <th>商品介绍</th>
        <th>商品状态</th>
        <th>操作</th>
    </tr>
    </thead>
    <tbody id="tbody"><%--就是表格的正文--%>

    </tbody>


    <div class='pieces'>

        <div class='future_ui__piece blank'></div>
    </div>


    <hr>
    <hr>

</table>



<script type="text/javascript">
   $(function () {

       /*一进页面就发请求查询所有的类别*/
       var data=[];
       $.ajax({
           url:"selectAllp_type",//可以拦截请求,就是一上来就是拦截
           type:"post",
           success:function(data){

               for(var i=0;i<data.length;i++){
                   var str="            <div class='future_ui__piece'><span><a ><font color ='white' size='7'>"+data[i]+"</font></a></span>" +
                       "            </div>";
                   $(".pieces").prepend(str);
               }
               type=data;
           }
       });

       $(".pieces").on("click",".future_ui__piece",function(){
           var type=$(this).children().text();
          alert(type);
           $.ajax({
               url: "selectAllProductsByP_types",
               type: "post",
               data: {
                   "p_type": type,
               },
               success: function (data) {

                   for (var i = 0; i < data.length; i++) {
                    //   $("#u_a").html("");//就是清除，就是自己，不然会追加,就是数据会追加
                       var tr = "<tr class='active'>" +
                           "<td>" + data[i].pId + "</td>" +
                           "<td>" + data[i].pCode + "</td>" +
                           "<td>" + data[i].pName + "</td>" +
                           "<td>" + data[i].pType + "</td>" +
                           "<td>" + data[i].brand + "</td>" +
                           "<td>" + data[i].pNum + "</td>" +
                           "<td>" + data[i].price + "</td>" +
                           "<td>" + data[i].sale + "</td>" +
                           "<td>" + data[i].intro + "</td>" +
                           "<td id=" + data[i].pId + ">" + data[i].status + " </td>" +
                           "<td><button class='up'>" + str + "</button></td>" +
                           "<tr>";
                       $("#tbody1").append(tr);
                   }
                   }
           })

       })



        var str;
       $.ajax({
           url:"getUpAndDownProducts",
           type:"post",
           success:function (data) {
               for (var i=0;i<data.length;i++){
                       if(data[i].status==0) {
                           data[i].status = '上架';
                           str="下架";
                       }else if(data[i].status==1){
                           data[i].status = '下架';
                           str="上架";
                       }else if(data[i].status==2){
                           data[i].status='打折';
                           str="打折";
                       }

                    //   alert(data.p_type);
                   var tr="<tr class='active'>"+
                       "<td>"+data[i].pId+"</td>"+
                       "<td>"+data[i].pCode+"</td>"+
                       "<td>"+data[i].pName+"</td>"+
                       "<td>"+data[i].pType+"</td>"+
                       "<td>"+data[i].brand+"</td>"+
                       "<td>"+data[i].pNum+"</td>"+
                       "<td>"+data[i].price+"</td>"+
                       "<td>"+data[i].sale+"</td>"+
                       "<td>"+data[i].intro+"</td>"+
                       "<td id="+data[i].pId+">"+data[i].status+" </td>"+
                       "<td><button class='up'>"+str+"</button></td>"+
                   "<tr>";
                   $("#tbody").append(tr);

               }
           }
       });

       $("#tbody").on("click",".up",function () {
           var  status =$(this).text();
           alert(status);
           var pId=$(this).parent().parent().find("td").eq(0).text();
           alert(pId);
       $.ajax({
           url:"upAndDownProdunts" ,
           type:"post",
           data:{
               "pId":pId,
               "status":status

           },
           success:function (data) {
            if(data>0){
                alert("修改成功");
                //window.onload;不对  href.load;
               // $("#"+id+"").load("上架");
                location.reload();//或者location.replace(URL)

            }else{
                alert("修改失败");
            }
           }

       })
       })



   }) 


</script>


</body>
</html>
