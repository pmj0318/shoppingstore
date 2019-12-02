<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    //这段代码的意思是获取当前项目的路径，如：http://localhost:8080/项目名称。
%>
<html>
<head id="hh">
    <base href="<%=basePath%>">
    <%--这是设置基础路径的,basePath为变量,表示href属性,就以你设置的为准--%>
    <title>展示商品</title>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
    <script src="<%=basePath%>resource/js/modernizr.custom.js"></script>
    <link href="http://cdn.bootcss.com/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>resource/css/demo.css"/>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>resource/css/component.css"/>


    <style>

        body {
            background: #2A2B30;
        }

    </style>

</head>
<body>
<!-- Compare basket -->
<div class="compare-basket">
    <button class="action action--button action--compare"><i class="fa fa-check"></i><span
            class="action__text">Compare</span></button>
</div>
<!-- Main view -->
<div class="view">
    <!-- Product grid -->
    <section class="grid">
        <!-- Products -->


    </section>
</div><!-- /view -->


<!-- product compare wrapper -->
<section class="compare">
    <button class="action action--close"><i class="fa fa-remove"></i><span class="action__text action__text--invisible">Close comparison overlay</span>
    </button>
</section>


<script src="<%=basePath%>resource/js/classie.js"></script>
<script src="<%=basePath%>resource/js/main.js"></script>

<script>
    $(function () {

        $.ajax({
            url: "selectAllProductsByP_type",
            type: "post",
            data: {
                "p_type": getQueryString("p_type")
            },
            success: function (data) {

                for (var i = 0; i < data.length; i++) {
                    var str = "<div class='product'>" +
                        "            <div class='product__info'>" +
                        "                <img class='product__image' src='<%=basePath%>resource/images/1.png' alt='Product 1' />" +
                        "                <h3 class='product__title'>" + data[i].pName + "</h3>" +
                        "                <span class='product__region extra highlight'>" + data[i].intro + "</span>" +
                        "                <span class='product__price highlight'>" + data[i].price + "</span>" +
                        "                <button class='action action--button action--buy'pid='" + data[i].pId + "'><i class='fa fa-shopping-cart'></i><span class='action__text cd-add-to-cart' >加入购物车</span></button>" + '' +
                        "                 <button class='action action--button action--buy'pid='" + data[i].pId + "'><i class='fa fa-shopping-cart'></i><span class='action__text cd-add-to-cart' >立即购买</span></button>" +
                        "            </div>" +
                        "            <label class='action action--compare-add'><input class='check-hidden' type='checkbox' /><i class='fa fa-plus'></i><i class='fa fa-check'></i><span class='action__text action__text--invisible'>比较商品</span></label>'" +
                        "        </div>";

                    $(".grid").append(str);
                }

                loadjscssfile("<%=basePath%>resource/js/classie.js", "js");//loadjscssfile 打开页面时浏览器动态的加载文件
                loadjscssfile("<%=basePath%>resource/js/main.js", "js");

            }
        });


        $(".grid").on("click", ".action ", function () {
            // alert($(this).attr("pid"));
            //$(this).childrend.eq(1);就是获取第二个孩子,,比较常用
            //day06,就是获取cookie,返回的是字符串,就是取当前用户cookie
            var username = getQueryString("username");

            if (username == "null" || username == "" || username == undefined) {
                alert("没登录")
                location.href = "<%=basePath%>resource/login/login.jsp";
            } else {
                alert(username);
                alert("登录");
            }
        });

    });


    //就是地址栏获取里上一个页面传过来的参数,就是个格式固定的,只需要改一下响应的参数就可以了
    function getQueryString(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
        var r = window.location.search.substr(1).match(reg);
        if (r != null)
            return decodeURI(r[2]);
        return null;
    }

    function loadjscssfile(filename, filetype) {
        if (filetype == "js") { //判定文件类型
            var fileref = document.createElement('script');//创建标签
            fileref.setAttribute("type", "text/javascript");//定义属性type的值为text/javascript
            fileref.setAttribute("src", filename);//文件的地址
        } else if (filetype == "css") { //判定文件类型
            var fileref = document.createElement("link");
            fileref.setAttribute("rel", "stylesheet");
            fileref.setAttribute("type", "text/css");
            fileref.setAttribute("href", filename);
        }
        if (typeof fileref != "undefined")
            document.getElementsByTagName("head")[0].appendChild(fileref);
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
