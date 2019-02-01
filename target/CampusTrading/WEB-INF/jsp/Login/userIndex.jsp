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
    <title>用户主页</title>
    <link rel="stylesheet" type="text/css" href="css/userIndex.css"/>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>


</head>
<body>
<input type="hidden" id="username" value="${username}">
<!--头部，导航-->
<div class="layui-header layui-bg-black" >
    <div class="layui-logo" id="logo" title="墨寒校园二手交易">墨寒校园二手交易</div>
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
            <a href="javascript:;" id="orderKinds">
                我的二手
            </a>
            <dl class="layui-nav-child">
                <dd><a href="/CampusTrading/PaymentView" target="content" title="待付款">待付款<span class="orderNum" id="paymentNum"></span></a></dd>
                <dd><a href="/CampusTrading/ShippedView" target="content" title="待发货">待发货<span class="orderNum" id="shippedNum"></span></a></dd>
                <dd><a href="/CampusTrading/ReceiptView" target="content" title="待收货">待收货<span class="orderNum" id="receiptNum"></span></a></dd>
                <dd><a href="/CampusTrading/EvaluateView" target="content" title="待评价">待评价<span class="orderNum" id="evaluationNUm"></span></a></dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;" class="shoppingCart" id="shoppingCart">
                <i class="layui-icon layui-icon-cart" style="font-size: 18px;"></i> 购物车
                <span id="goodsTotal"></span>
            </a>
            <dl class="layui-nav-child cart-goods" id="cart-goods"></dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;" class="sellerCenter" >
                卖家中心
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javaScript:void(0);" id="openShop" title="免费开店">免费开店</a></dd>
                <dd><a href="javaScript:void(0)" title="出售中的商品" id="onSale">出售中的商品&ensp;
                    <span style="color: rgba(238,90,150,0.98);font-size: 18px" id="goodsNum"></span></a></dd>
                <dd><a href="/CampusTrading/NeedShippedView" id="mangeOrder" target="content" title="需处理的订单">需处理的订单
                    <span style="color: rgba(238,90,150,0.98);font-size: 18px" id="dealOrder"></span></a></dd>
                <dd><a href="/CampusTrading/AddGoods/${username}" title="发布新商品" id="addGoods" target="content">发布新商品</a></dd>

            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img src="images/user.jpg" class="layui-nav-img">
                ${username}
            </a>
            <dl class="layui-nav-child">
                <dd><a href="/CampusTrading/BasicInfo/${username}" target="content" title="基本资料">基本资料</a></dd>
                <dd><a href="/CampusTrading/ChangePsw/${username}" target="content" title="安全设置">安全设置</a></dd>
                <dd><a href="/CampusTrading/ReceiptAddress/${username}" target="content" title="收货地址">收货地址</a></dd>
                <dd><a href="/CampusTrading/Logout" title="退出">退&emsp;&emsp;出</a></dd>
            </dl>
        </li>

    </ul>
</div>

<div class="shopping" id="shopping">
   <iframe src="/CampusTrading/Shopping" name="content" width="100%" height="100%" frameborder="0" ></iframe>
</div>
<!--免费开店的界面，隐藏的点击免费开店按钮是类似弹出框弹出-->
<div id="seller" class="seller">
    <div>
        <h2>我要开店</h2>
        <p>一个身份只能开一家店;开店后店铺无法注销;申请到正式开通预计需1个工作日。了解更多请看<a title="开店必看的规则">开店规则必看</a>。</p>
        <h4>1、我在已经开了个店了，我用别人的身份证再开一个店可以吗？</h4>

        答：不可以。未经平台同意，将本人账号提供给他人作开店使用，否则由此导致相关争议、诉讼及因店铺经营中的违法违规行为导致一切人身、财产权益损害，均由本人自行承担全部民事、行政及刑事责任。

        <h4>2、我可以把店铺转租给其他人吗?</h4>

        答：不可以。未经平台同意，将本人淘宝账号提供给他人作开店使用，否则由此导致相关争议、诉讼及因店铺经营中的违法违规行为导致一切人身、财产权益损害，均由本人自行承担全部民事、行政及刑事责任。

        <h4>3、我可以开多个二手店吗?</h4>

        答：不可以。一张身份证（一张营业执照）只能开一个二手店铺。开店后请保持营业执照存续状态，不得注销；如若发现营业执照被注销、吊销，将会自动对店铺做出永久关闭的处置。

        <h4>4、我已经开过店，现在想要注销原来的店铺重新开店，可以吗?</h4>

        答：不可以，暂时不提供注销店铺的服务。用户一但成功开店就无法再用身份证（营业执照）另开一家店铺。
    </div>
    <input type="checkbox" name="agree" id="agree">&ensp;<span style="color: #0C0C0C;">我同意以上规则。</span><br>
    <button class="layui-btn layui-btn-warm" id="sureShop">确认开店</button>
</div>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    var username=$("#username").val();
    //点击logo刷新页面，返回主页
     $("#logo").click(function () {
         location.reload();
     })
    //ajax请求，看他是否是卖家，卖家中心显示的内容不同
    $.ajax({
        url:"/CampusTrading/SellerOrNot/"+username,
        type:"post",
        success:function (data) {
            if(data=="1"){
                $("#onSale").hide();
                $("#mangeOrder").hide();
                $("#addGoods").hide();
            }else{
                $("#openShop").hide();
            }
        }
    });
    //点击免费开店按钮，成为卖家
    $("#openShop").click(function () {
        layui.use('layer', function(){
            var layer = layui.layer;
            layer.open({
                type: 1,
                title:'成为卖家',
                area: '682px',
                anim: 1,
                shade: [0.1, '#333333'],
                content:$('#seller')
            });
        });
    });

    //点击确认开店事件
    $("#sureShop").click(function () {
        //判断是否勾选同意，没勾选，提醒勾选
        if($("#agree").is(':checked')){
            $.ajax({
                url:"/CampusTrading/OpenShop/"+username,
                type:"post",
                success:function (data) {
                    if(data=="1"){
                        location.reload();//成为卖家后刷新页面
                    }else {
                        layui.use('layer', function() {
                            var layer = layui.layer;
                            layer.msg('很抱歉，开店失败，请稍后再试。',{icon: 5,time:2000,anim:3});
                        });
                    }
                }
            });
        }else{
            layui.use('layer', function() {
                var layer = layui.layer;
                layer.msg('请勾选"我同意以上规则",才能免费开店',{icon: 5,time:2000,anim:3});
            });
        }

    });

    //获取购物车中商品总数
    $.ajax({
        url:"/CampusTrading/CartGoodsTotal",
        data:{"username":username},
        type:"post",
        success:function (data) {
            if(data!="0"){
                $("#goodsTotal").html(data);
            }
        }
    });

    //获取购物车有哪些商品，用于在鼠标放在购物车上时，显示出一部分商品
    $("#shoppingCart").mouseover(function () {
        $.ajax({
            url:"/CampusTrading/QueryCartGoodsByUName",
            data:{"name":username},
            type:"post",
            async:false,
            dataType:"json",
            success:function (data) {
                var goodsInfo="";
                //先判断是否有数据
                if(data.length<=0){
                    goodsInfo="<span style='color: #555555;line-height: 20px'>&emsp;你的购物车空空如也，<br>快去浏览商品吧。<span>"
                    $("#cart-goods").html(goodsInfo);
                }
                else {
                    //只展示前3件物品
                    if(data.length>3){
                        data.length=3;
                    }
                    for(var i=0;i<data.length;i++){
                        goodsInfo+="<dd><div class='goods_con'><ul><input type='hidden' value='"+data[i].g_id+"'><li><img src='"+data[i].picture+"'></li>" +
                            "<li><a href='/CampusTrading/QueryGoodsDetail/"+data[i].g_id+"' target='content' title='"+data[i].content+"'>"+data[i].content+"</a></li>" +
                            "<li><p>￥"+data[i].price.toFixed(2)+"</p><a title='删除' href='javascript:void(0);' onclick='delGoods("+data[i].g_id+")'>" +
                            "删除</a></li></ul></div></dd>";
                    }
                    goodsInfo+="<dd><a href='/CampusTrading/EnterMyCart' class='layui-btn layui-btn-warm' target='content' title='查看我的购物车' id='enterCart'>查看我的购物车</a></dd>"
                    $("#cart-goods").html(goodsInfo);
                }

            }
        });
    });


    //删除购物车中的商品
    function delGoods(id) {
        layui.use('layer',function () {
            var layer=layui.layer;
            layer.confirm('您确定要删除您购物车中这件宝贝吗？',{
                btn:['确认','取消'],
                anim:1,
                title:'删除商品',
                shade: [0.5, '#cccccc'],
                icon:3,
                yes:function (index) {
                   layer.close(index);
                   $.ajax({
                       url:"/CampusTrading/DeleteGoodsOfCart",
                       data:{"uName":username,"gId":id},
                       type:"post",
                       success:function (data) {
                           if(data=="1"){
                               layer.msg('成功删除,但宝贝舍不得您。',{icon:5,time:2000});
                               location.reload();
                           }
                           else{
                               layer.msg('删除失败',{icon:2,time:2000});
                           }
                       }

                   })
                },
                btn2:function (index) {
                    layer.close(index);

                }
            })
        })
    }

    //如果用户是卖家，在显示卖家正在出售的商品数量,需要处理的订单的数量
    (function () {
        if($("#onSale").is(':hidden')){
            $.ajax({
                url:"/CampusTrading/SelectGoodsNum",
                data:{"username":username},
                type:"post",
                success:function (data) {
                    //当商品数量大于0是
                    if(data!="0"){
                        $("#goodsNum").html(data);
                    }
                }
            })
        }

        if($("#mangeOrder").is(':hidden')){
            $.ajax({
                url:"/CampusTrading/NeedShippedNum",
                data:{"name":username},
                type:"post",
                success:function (res) {
                    //当商品数量大于0是
                    if(res!="0"){
                        $("#dealOrder").html(res);
                    }
                }
            })
        }
    })();

    //获取用户各种订单（待付款，待发货，待收货、待评价）的数量
    $("#orderKinds").mouseover(function () {
        $.ajax({
            url:"/CampusTrading/AllKindsOrderNum",
            data:{"uName":username},
            type:"post",
            success:function (data) {
                var dataArr=data.split(",");
                if(dataArr[0]>0){
                    $("#paymentNum").html(dataArr[0]);
                }
                if(dataArr[1]>0){
                    $("#shippedNum").html(dataArr[1]);
                }
                if(dataArr[2]>0){
                    $("#receiptNum").html(dataArr[2]);
                }
                if(dataArr[3]>0){
                    $("#evaluationNUm").html(dataArr[3]);
                }
            }
        })

    });


</script>
</body>

</html>
