<%--
  Created by IntelliJ IDEA.
  User: 12829  墨水之寒
  Date: 2018/12/24
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>购物主页</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="css/shopping.css"/>
</head>
<body>
<!--搜索栏，搜索框-->
<div class="search">
    <input type="text" id="search_text" placeholder="请输入您想宝贝的名字或类型"/>
    <button id="search" class="layui-btn layui-btn-warm" title="搜 索">搜 索</button>
</div>
<!--展示部分商品-->
<div class="allGoods" id="allGoods">
    <div id="noGoods" class="noGoods">抱歉，本平台没有您想要的宝贝。本平台会尽快添加您喜欢的宝贝的，您可以看看其他宝贝。</div>
    <ul id="allGoodsUl"></ul>
</div>
<!--在购物页面显示公告栏-->
<div class="allNotices">
    <h3>公告栏</h3>
    <ul id="noticesUl"></ul>
</div>
<!--点击公告标题查看公告详情-->
<div class="noticeDetail" id="noticeDetail">
    <p id="noticeTitle" class="noticeTitle"></p>
    <p id="noticeContent" class="noticeContent"></p>
</div>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //ajax请求所有商品
    $.ajax({
        url:"/CampusTrading/SelectGoods",
        type:"post",
        dataType:"json",
        async:false,
        success:function (data) {
            var allGoods="";
            for(var i=0;i<data.length;i++){
                allGoods+="<li><img src='"+data[i].picture+"'><div class='introduce'>" +
                    "<a href='javascript:void(0);' class='name'>"+data[i].name+"</a><span class='price'>￥"+data[i].price+"</span>" +
                    " <p>"+data[i].content+"</p></div><input type='hidden' value='"+data[i].g_id+"'></li>"
            }
            $("#allGoodsUl").html(allGoods);
        }
    });
    //点击搜索按钮
    $("#search").click(function () {
        var search_text=$("#search_text").val();
        $.ajax({
            url:"/CampusTrading/QueryGoodsByName/"+search_text,
            type:"post",
            dataType:"json",
            success:function (data) {
                var allGoods="";
                if(data==""){
                    $("#noGoods").show();
                }else{
                    for(var i=0;i<data.length;i++){
                        allGoods+="<li><img src='"+data[i].picture+"'><div class='introduce'>" +
                            "<a href='javascript:void(0);' class='name'>"+data[i].name+"</a><span class='price'>￥"+data[i].price+"</span>" +
                            " <p>"+data[i].content+"</p></div><input type='hidden' value='"+data[i].g_id+"'></li>"
                    }
                    $("#allGoodsUl").html(allGoods);
                }

            }
        })

    });
    //点击商品信息li查看商品详情,根据商品ID
    $("#allGoodsUl li").click(function () {
        var gId=$(this).find("input").val();
        location.href="/CampusTrading/QueryGoodsDetail/"+gId;

    });
    //ajax请求公告栏的内容,只显示公告的标题
    $.ajax({
        url:"/CampusTrading/GetAllNotices",
        type:"post",
        async:false,
        dataType:"json",
        success:function (data) {
            var j=1;
            var notices="";
            for(var i=0;i<data.length;i++){
                notices+="<li><a title='"+data[i].title+"'>"+j+").&ensp;"+data[i].title+"</a>" +
                    "<input type='hidden' value='"+data[i].id+"'></li>";
                j++;
            }
            $("#noticesUl").append(notices);

        }
    });
    //点击某条公告的标题，了查看公告的详情
    $("#noticesUl>li a").click(function () {
        var id=$(this).parent().find("input").val();
        $.ajax({
            url:"/CampusTrading/QueryNoticeById",
            data:{"id":id},
            type:"post",
            async:false,
            dataType:"json",
            success:function (data) {
                //调用layui的弹出层，弹出某天公告的具体内容
                $("#noticeTitle").html(data.title);
                $("#noticeContent").html(data.content);
                layui.use('layer',function () {
                   var layer=layui.layer;
                   layer.open({
                       type: 1,
                       title:['公告详情','font-size:18px;'],
                       content:$('#noticeDetail'),
                       btn:['关闭'],
                       shade: 0,
                       anim:2,
                       area: ['500px', '300px'],
                       cancel:function(index) {
                           layer.close(index);
                           $("#noticeDetail").hide();
                       },
                       yes:function (index) {
                           layer.close(index);
                           $("#noticeDetail").hide();
                       }

                   });
                })
            }
        })
    })
    //

</script>
</body>
</html>
