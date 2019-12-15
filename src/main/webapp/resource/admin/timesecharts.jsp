<%--
  Created by IntelliJ IDEA.
  User: pmj
  Date: 2019/12/10
  Time: 15:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <base href="<%=basePath%>">
    <title>Title</title>
    <script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-gl/dist/echarts-gl.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts-stat/dist/ecStat.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/dataTool.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/china.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/map/js/world.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/echarts/dist/extension/bmap.min.js"></script>

</head>
<body style="height: 100%; margin: 0">
<div id="container" style="height: 100%"></div>

<script type="text/javascript">

    /*1.折线图*/
    /*json数组，同时塞值，塞月份的时候保证同时塞值*/
    /*x轴月份*/
    var datax=[];
    /*y轴访问数据*/
    var datay=[];
    /*2.饼状图*/
    var data3=[];

    $(function(){

        $.ajax({
            url:"getWebData",
            type:"post",
            //就是参数,不用带参数,带参数有没有用,不需要参数,
            success:function (data) {
                //day12-怎么访问,就是统计,设置拦截器,

                for(var i=0;i<data.length;i++){
                    var json={};
                    /*使用for循环同时给数组赋值，保证一一对应*/

                   // datax.console(data[i].visittime);
                   // datay.console(data[i].visittimes);
                    datax.push(data[i].visittime);   /*x轴月份*/
                    datay.push(data[i].visittimes);  /*y轴数组*/


                    /*var json={};*///{"age":20,"gender":"男"}
                    //json.age=20,json.gender="男";
                    json.value=data[i].visittimes;
                    json.name=data[i].visittime;
                    //json对象放入data3数组
                    data3.push(json);
                }


                var dom = document.getElementById("container");
                var myChart = echarts.init(dom);
                var app = {};
                option = null;
                option = {
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        // data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
                        data:datax
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        //  data: [820, 932, 901, 934, 1290, 1330, 1320],现在数据是死的,就是动态的获取
                        data:datay,
                        type: 'line',
                        areaStyle: {}
                    }]
                };
                ;
                if (option && typeof option === "object") {
                    myChart.setOption(option, true);
                }




            }

        })

    })

    
    
    
    


</script>




</body>
</html>
