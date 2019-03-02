<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/1
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>商品详情页面</title>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="../css/goodsDetail.css">
</head>
<body>
<!--商品详细信息-->
<div class="detail">
    <input type="hidden" id="goods_id" value="${Goods.g_id}">
    <ul>
        <li>
            <img src="${Goods.picture}" alt="${Goods.content}">
        </li>
        <li>
            <div id="goodsContent" class="goodsContent">
                <p class="name">${Goods.name}</p>
                <p class="content">${Goods.content}</p>
                <p class="price"></p>
                <div style="margin-left: 40px;margin-top: 16px">
                    数量&ensp;
                    <input type="button" id="reduce" value="-" class="layui-btn layui-btn-xs" title="减">
                    <input type="number" value="1" min="1" id="sum">
                    <input type="button" id="add" value="+" class="layui-btn layui-btn-xs" title="加">
                    <span style="margin-left: 30px">库存${Goods.number}件</span>
                </div>
            </div>
            <div>
                <button id="directBuy" class="layui-btn layui-btn-normal layui-btn-lg" title="直接购买">直接购买</button>
                <button id="addToCart" class="layui-btn layui-btn-warm addCart layui-btn-lg" title="加入购物车">
                    <i class="layui-icon layui-icon-cart" style="font-size: 22px;color:#FFFFFF;"></i>加入购物车</button>
            </div>
        </li>
    </ul>
</div>

<!--商品的评价信息-->
<div class="evaluate" id="evaluate">
    <h3>&emsp;用户评价</h3>
    <div class="noEva" id="noEva">暂时没有用户对该商品进行评价</div>
    <ul id="evaluateUl"></ul>
</div>



<!--点击购买后进入提交订单的界面,是一个弹窗-->
<div id="createOrder" class="createOrder">
    <div class="receive" id="receive">
        <div id="receive-child" class="receive-child">
            收货人:<span id="receiveMan"></span>
            <span id="receiveTel" style="margin-left: 50px;font-size: 14px;"></span>
            <input type="hidden" id="receiveId">
            <p>
                <i class="layui-icon layui-icon-location" style="font-size: 20px; color: #999999;"></i>
                <span id="receiveAddress"></span>
            </p>
        </div>
    </div>
    <ul>
        <li><img src="${Goods.picture}" alt="${Goods.content}" title="${Goods.name}"></li>
        <li>
            <a class="name" title="${Goods.name}">${Goods.name}</a>
            <a class="content" title="${Goods.content}">${Goods.content}</a>
        </li>
    </ul>
    <p>商品单价:&emsp;<span class="price"></span><span class="gNum" id="gNum"></span></p>
    <div style="margin-left: 30px;margin-top: 10px;">购买数量:
        <input type="button"  id="oReduce" value="-" class="layui-btn layui-btn-xs oReduce" title="减">
        <span id="oSum" class="oSum"></span>
        <input type="button" id="oAdd" value="+" class="layui-btn layui-btn-xs" title="加">
    </div>
    <p style="margin-top: 6px;">配送方式:&emsp;&emsp;&emsp;快递(免邮)</p>
    <div class="note">买家留言:<input type="text" id="buyerNote" placeholder="选填:填写内容协和卖家协商确定"></div>
    <div class="subOrder">
        总&emsp;&ensp;价:<span id="totalPrice"></span>
        <button class="layui-btn layui-btn-warm" id="submitOrder" title="提交订单">提交订单</button>
    </div>

</div>

<!--提交订单后付款的弹窗-->
<div id="payFor" class="payFor">
    &emsp;&emsp;由于本系统的付款板块出现一些问题，请您直接与卖家联系，
    商量如何付款!如果你并未付款给卖家，卖家将不会发货给您。
    <i>给您带来不便敬请谅解。</i>
    <p>卖家姓名:<span id="sellerName"></span></p>
    <p>卖家电话:<span id="sellerTel"></span></p>
    <div class="payBtn">
        <button class="layui-btn layui-btn-primary" id="cancelPay" title="取消付款">取消付款</button>
        <button class="layui-btn layui-btn-warm" id="successPay" title="成功付款">成功付款</button>
    </div>
</div>

<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script>
    //给类为price的标签赋值为两位小数的
    var price=(${Goods.price}).toFixed(2);
    var gId=$("#goods_id").val();//获取当前商品ID
    $(".price").html("￥"+price);
    var inventory=${Goods.number};//商品的库存量
    var uName=parent.$("#username").val();//获取买家，用户的用户名

    //获取用户对商品的评价
    $.ajax({
        url:"/CampusTrading/QueryAllEvaluate",
        data:{"gid":gId},
        type:"post",
        async:false,
        dataType:"json",
        success:function (data) {
            var liHtml="";
            if(data.length==0){
                $("#noEva").show();
            }
            else {
                for(var i=0;i<data.length;i++){
                    liHtml+="<li><div><img src='../images/people.png'><span class='eName'>"+data[i].uname+"</span>" +
                        "<span id='test"+i+"' class='score'></span></div><p>"+data[i].content+"</p>" +
                        "<input type='hidden' value='"+data[i].score+"'></li>";
                }
                $("#evaluateUl").append(liHtml);
            }
        }
    });
    //商品评价里面的评分的星星的多少
    layui.use(['rate'], function() {
        var rate = layui.rate;
        //基础效果
        var score=new Array();
        for(var i=0;i<$("#evaluateUl li").length;i++){
            score[i]=$("#evaluateUl li").eq(i).find("input").val();
        }
        for(var i=0;i<$("#evaluateUl li").length;i++){
            rate.render({
                elem: '#test'+i,
                value:score[i],
                readonly: true
            });
        }

    });

    //根据商品的ID来获取卖家的姓名，联系方式
    $.ajax({
        url:"/CampusTrading/QuerySellerByGid",
        type:"post",
        data:{"gId":gId},
        dataType:"json",
        success:function (data) {
            $("#sellerName").html(data.username);
            $("#sellerTel").html(data.phone);
        }
    });

    //点击+或-增加或减少购买商品数量
    layui.use('layer',function () {
        var layer=layui.layer;
        $("#add").click(function () {
            var sum=$("#sum").val();
            $("#reduce").removeClass("layui-btn-disabled");
            if(sum>=inventory){
                $("#add").addClass("layui-btn-disabled");
                layer.msg('商品数量已经达到库存上限，不能再增加了',{icon:2,time:1500});
            }
            else {
                sum++;
                $("#sum").val(sum);
            }
        });
        $("#reduce").click(function () {
            var sum=$("#sum").val();
            $("#add").removeClass("layui-btn-disabled");
            if(sum<=1){
                $("#reduce").addClass("layui-btn-disabled");
                layer.msg('当前已经是最小购买数量了',{icon:2,time:1500});
            }
            else {
                sum=sum-1;
                $("#sum").val(sum);
            }
        });
        //商品数量里面的值输入变化时
        $("#sum").on("input propertychange",function () {
            var sum=$(this).val();
            if(sum>inventory){
                $("#sum").val(inventory);
                layer.msg('您输入的商品数量以及超过库存了',{icon:2,time:1500});
            }
            else if(sum<=1) {
                $("#sum").val(1);
                layer.msg('当前已经是最小购买数量了',{icon:2,time:1500});
            }

        });
        //创建订单里面的加减号
        $("#oAdd").click(function () {
            var oSum=$("#oSum").text();
            $("#oReduce").removeClass("layui-btn-disabled");
            if(oSum>=inventory){
                $("#oAdd").addClass("layui-btn-disabled");
                layer.msg('商品数量已经达到库存上限，不能再增加了',{icon:2,time:1500});
            }
            else {
                oSum++;
                $("#oSum").html(oSum);
                $("#gNum").html("x"+oSum);//单价后面的x数量的变化
                $("#totalPrice").html("￥"+(oSum*price).toFixed(2));//总价变化

            }
        });
        $("#oReduce").click(function () {
            var oSum=$("#oSum").html();
            $("#oAdd").removeClass("layui-btn-disabled");
            if(oSum<=1){
                $("#oReduce").addClass("layui-btn-disabled");
                layer.msg('当前已经是最小购买数量了',{icon:2,time:1500});
            }
            else {
                oSum=oSum-1;
                $("#oSum").html(oSum);
                $("#gNum").html("x"+oSum);//单价后面的x数量的变化
                $("#totalPrice").html("￥"+(oSum*price).toFixed(2));//总价变化
            }
        });
    })
    
    //点击直接购买，生成订单
    $("#directBuy").click(function () {
        var num=$("#sum").val();
        var price=${Goods.price};
        $("#gNum").html("x"+num);
        $("#oSum").html(num);
        $("#totalPrice").html("￥"+(price*num).toFixed(2));
        //商品信息,ajxa获取用户的默认地址
       $.ajax({
           url:"/CampusTrading/QueryDefaultAddress",
           data:{"username":uName},
           type:"post",
           async:false,
           dataType:"json",
           success:function (data) {
               if(data==null){
                   $("#receive-child").hide();
                   var notReceive="<p class='notRece'>您还没有默认的收货地址快去添加一个吧</p>"
                   $("#receive").append(notReceive);
               }
               else {
                   $("#receiveId").val(data.id)
                   $("#receiveMan").html(data.receiveMan);
                   $("#receiveTel").html(data.receiveTel);
                   $("#receiveAddress").html(data.receiveAddress);
               }
               layui.use('layer',function () {
                   var layer=layui.layer;
                   layer.open({
                       type:1,
                       title:['提交订单','background: rgba(98,238,222,0.98);font-size:18px'],
                       anim:2,
                       area:["540px",'450px'],
                       shade: [0.4, '#cccccc'],
                       content:$('#createOrder'),
                       cancel:function (index) {
                           $('#createOrder').hide();
                       }
                   })

               });
           }
       })
    });
    
    //点击添加到购物车，把商品添加到购物车中去
    $("#addToCart").click(function () {
        var uName=$(window.parent.document).find("#username").val();
        var gId=$("#goods_id").val();
        $.ajax({
            url:"/CampusTrading/AddGoodsToCart" ,
            data:{"uName":uName,"gId":gId},
            type:"post",
            success:function (data) {
                var gTotal=parent.$("#goodsTotal").html();
                layui.use('layer',function () {
                    var layer=layui.layer;
                    if(data=="-1"){
                        layer.alert('您已经该改宝贝加入您的购物车中了，快去购买吧。',{icon:6,anim:1});
                    }
                    else if(data=="1"){
                        //改变购物车旁边的购物车中商品的数量，改变父框里面的值
                        gTotal++;
                        parent.$("#goodsTotal").html(gTotal);
                        layer.msg('成功将该件商品加入您的购物车中,快去查看吧',{icon:6,anim:1,time:2500});
                    }
                    else {
                        layer.alert('抱歉，该改件商品添加失败，去看看其他宝贝',{icon:6,anim:1});
                    }
                })
            }
        });
    });
    
    //点击弹窗里面的提交订单按钮，进行订单的提交
    $("#submitOrder").click(function () {
        var receiveID=$("#receive input").val();
        if(receiveID==""){
            layer.alert('请选择收货地址',{icon:3});
        }
        else {
            layer.open({
                type:1,
                title:['付款','background: #f9a0d5;font-size:18px'],
                anim:5,
                area:["420px",'400px'],
                shade: [0.4, '#cccccc'],
                content:$('#payFor'),
                cancel:function (index) {
                    $('#payFor').hide();
                }
            });
        }


    });

    //点击取消付款，生成状态为1的订单
    $("#cancelPay").click(function () {
        var receiveId=$("#receiveId").val();//收货地址deID
        var sName=$("#sellerName").html();//卖家的用户名
        var gNum=$("#oSum").html();//获取买家选择的商品数量
        var buyerNote=$("#buyerNote").val();//获取买家留言
        $.ajax({
            url:"/CampusTrading/CreateOrder",
            data:{"uName":uName,"sName":sName,"receiveId":receiveId,"gId":gId,"goodsNum":gNum,"unitPrice":price,"buyerNote":buyerNote,"state":1},
            type:"post",
            success:function (data) {
                if(data=="1"){
                    layer.msg('已取消付款，但我会在未付款的地方等您哟!',{icon:1,time:1500},function () {
                        layer.closeAll();
                        $('#payFor').hide();
                        $('#createOrder').hide();
                    });
                }
            }
        });
    });

    //点击付款成功，生成状态为2的订单
    $("#successPay").click(function () {
        var receiveId=$("#receiveId").val();//收货地址deID
        var sName=$("#sellerName").html();//卖家的用户名
        var gNum=$("#oSum").html();//获取买家选择的商品数量
        var buyerNote=$("#buyerNote").val();//获取买家留言
        $.ajax({
            url:"/CampusTrading/CreateOrder",
            data:{"uName":uName,"sName":sName,"receiveId":receiveId,"gId":gId,"goodsNum":gNum,"unitPrice":price,"buyerNote":buyerNote,"state":2},
            type:"post",
            success:function (data) {
                if(data=="1"){
                    layer.msg('购买成功,请等待卖家发货吧!',{icon:1,time:1500},function () {
                        layer.closeAll();
                        $('#payFor').hide();
                        $('#createOrder').hide();
                    });
                }
            }
        });
    });

    //点击选择收货地址和方式
    $("#receive").click(function () {
        window.location.href="/CampusTrading/ReceiptAddress/"+uName;
    });


</script>
</body>
</html>
