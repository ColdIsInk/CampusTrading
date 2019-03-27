<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2018/12/15
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>管理员主页</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        *{margin: 0;padding: 0;}
        img{
            border:none;
        }

        .zuoce{
            background: #2F4056;
        }
        iframe body{
            margin: 0;padding: 0;
        }
        .layui-layout-admin .layui-body{bottom:0}
        .layui-nav-child dd{text-align: center;letter-spacing: 2px;}
        .layui-logo{
            cursor: pointer;
        }
    </style>

</head>
<body>
<div class="layui-layout  layui-layout-admin">
    <div class="layui-header layui-bg-blue">
        <div class="layui-logo layui-bg-black" title="校园二手交易平台">校园二手交易平台</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item">
                <a href="javascript:;">
                    <!--http://t.cn/RCzsdCq-->
                    <img src="images/user.jpg" class="layui-nav-img">
                    ${username}
                </a>
                <dl class="layui-nav-child" style="text-align: center;">
                    <dd><a href="/CampusTrading/BasicInfo/${username}" target="content">基本资料</a></dd>
                    <dd><a href="/CampusTrading/ChangePsw/${username}" target="content">安全设置</a></dd>
                    <dd><a href="/CampusTrading/Logout" title="退出">退&emsp;&emsp;出</a></dd>
                </dl>
            </li>
        </ul>
    </div>

    <div class="layui-side zuoce">
        <div class="layui-side-scroll">
            <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
            <ul class="layui-nav layui-nav-tree" lay-filter="test" lay-shrink="all">
                <li class="layui-nav-item">
                    <a class="" href="javascript:;" title="用户管理">用户管理</a>
                    <dl class="layui-nav-child zuoce">
                        <dd><a href="/CampusTrading/UserList" title="用户信息" target="content">用户信息</a></dd>
                        <dd><a href="/CampusTrading/AddUser" title="新增用户" target="content">新增用户</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;" title="商品管理">商品管理</a>
                    <dl class="layui-nav-child zuoce">
                        <dd><a href="/CampusTrading/AllGoods" title="查看商品" target="content" id="queryGoods">查看商品</a></dd>
                        <dd><a href="/CampusTrading/GoodsType" title="商品类型" target="content">商品类型</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;" title="订单管理">订单管理</a>
                    <dl class="layui-nav-child zuoce">
                        <dd><a href="/CampusTrading/AllOrdersView" title="查看订单" target="content" id="queryOrder">查看订单</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item">
                    <a class="" href="javascript:;" title="公告管理">公告管理</a>
                    <dl class="layui-nav-child zuoce">
                        <dd><a href="/CampusTrading/NoticesList" title="查看公告" target="content" id="queryNotice">查看公告</a></dd>
                        <dd><a href="/CampusTrading/EnterAddNotice" title="发布公告" target="content">发布公告</a></dd>
                    </dl>
                </li>

            </ul>
        </div>
    </div>

    <div class="layui-body">
        <iframe src="/CampusTrading/Welcome" name="content" width="100%" height="100%" frameborder="0" ></iframe>
    </div>

</div>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    $(".layui-logo").click(function () {
        window.location.reload();
    });
</script>

</body>
</html>
