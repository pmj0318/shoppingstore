<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head id="hh">
    <base href="<%=basePath%>">
    <title></title>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath%>resource/js/sHover.min.js"></script>
    <link rel="stylesheet" href="<%=basePath%>resource/css/example.css">


</head>
<body id="body">
<div id="part3" class="part">
    <div class="container">
        <%--云心有个写死的div,但是我们和数据库相连的,就不想要写死的数据,就要想办法让这里面的数据变成活的,--%>


    </div><!-- /container -->
</div>

<%--就是原生的js，就是会有节点加载不出来，所以建议srcpt代码放到下面，好管理，就是建议jsp放到下面--%>
<script>
    $(function(){

        //就是在这次函数然后 就是查询。
        $.ajax({
            url:"selectAllProductsByP_type",
            type:"post",
            data:{
                "p_type":getQueryString("p_type")
            },
            success:function(data){
                // alert(data);
                //console.log(data);//就是在控制台打印信息(就是所有的获取的信息)..

                for(var i=0;i<data.length;i++){
                    var str="<div  class='sHoverItem'>" +
                        "    <img  src='"+data[i].pic+"'>" +
                        "    <span  class='sIntro'>" +
                        "<h4 style='color:white'>"+data[i].pName+"</h4>" +
                        "<p>"+data[i].intro+"</p>" +
                        "<p>$"+data[i].price+"</p>"+
                        "<button>立即购买</button>" +
                        "<button>加入购物车</button>" +
                        "</span>" +
                        " </div>";
                    $(".container").append(str);
                }



                var b=new sHover('head','headIntro');
                var a=new sHover("sHoverItem","sIntro");
                a.set({
                    slideSpeed:5,
                    opacityChange:true,
                    opacity:80
                })

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
        });






















    });

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

    function loadjscssfile(filename, filetype) {
        if (filetype == "js") { //判定文件类型
            var fileref = document.createElement('script');//创建标签
            fileref.setAttribute("type", "text/javascript");//定义属性type的值为text/javascript
            fileref.setAttribute("src", filename);//文件的地址
        }
        else if (filetype == "css") { //判定文件类型
            alert("css");
            var fileref = document.createElement("link");
            fileref.setAttribute("rel", "stylesheet");
            fileref.setAttribute("type", "text/css");
            fileref.setAttribute("href", filename);
            document.getElementsByTagName("head")[0].appendChild(fileref);
            alert("拼接到head");
        }
        // if (typeof fileref != "undefined")
        //     document.getElementsByTagName("head")[0].appendChild(fileref);
    }



</script>


</body>
</html>
