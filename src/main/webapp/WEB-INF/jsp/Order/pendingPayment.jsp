<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/24
  Time: 10:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待付款订单页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notNode{margin-left: 30px;color: #666666;letter-spacing: 2px;}
        /*需要付款的订单的样式*/
        .pendingPay{width: 920px;margin-right: auto;margin-left: auto;}
        .pendingPay h3{width: 100%;text-align: center;font-size: 26px;letter-spacing: 2px;font-family: 华文隶书;margin-top: 20px;}
        .pendingPay ul{margin-top: 16px;}
        .pendingPay ul li{width:100%;height: 160px;margin-top: 16px;background: rgba(181,211,233,0.63)}
        .pendingPay ul li>div{float: left;margin-left: 20px;}
        .pendingPay ul li>div p{margin-top: 8px;}
        .pendingPay ul li a{color: #555555;}
        .pendingPay ul li a:hover{cursor: pointer;color: #ff780e}
        .pendingPay ul li .pic{margin-left: 6px;}
        .pendingPay ul li img{width: 150px;height: 150px;margin-top: 5px;}
        .pendingPay ul li img:hover{cursor: pointer;}
        .pendingPay ul li .goods{width: 210px;margin-top: 22px;}
        .pendingPay ul li .price{width: 120px;margin-top: 22px;}
        .pendingPay ul li .receive{width: 248px;margin-top: 16px;height: 142px;overflow: hidden;color: #666666;}
        .pendingPay ul li .operate button{margin-top: 10px;margin-top: 24px;}
        /*付款弹窗*/
        .payFor{width: 320px;height: 300px;margin-left: auto;margin-right: auto;
            margin-top: 20px;line-height: 22px;display: none;}
        .payFor i{width:100%;display: block;font-size: 18px;margin-top: 6px;text-align: center;color: #ff48b1;}
        .payFor p{margin-left: 30px;margin-top: 6px;}
        .payFor span{margin-left: 8px;font-size: 18px;}
        .payFor .payBtn{float: right;margin-top: 100px;}

    </style>
</head>
<body>
<!--没有订单时-->
<div class="notOrder" id="notOrder">
    <img src="images/none.png" width="150" height="150" alt="没有相关订单">
    <i class="notNode">您还没有相关订单哟</i>

</div>
<!--待付款的订单-->
<div class="pendingPay" id="pendingPay">
    <h3>我的待付款的订单</h3>
    <ul id="pendingPayUl"></ul>
</div>

<!--点击付款后的弹窗-->
<div id="payFor" class="payFor">
    &emsp;&emsp;由于本系统的付款板块出现一些问题，请您直接与卖家联系，
    商量如何付款!如果你并未付款给卖家，卖家将不会发货给您。
    <i>给您带来不便敬请谅解。</i>
    <p>卖家姓名:<span id="sellerName"></span></p>
    <p>卖家电话:<span id="sellerTel"></span></p>
    <input type="hidden" id="goodsId">
    <div class="payBtn">
        <button class="layui-btn layui-btn-primary" id="cancelPay" title="取消付款">取消付款</button>
        <button class="layui-btn layui-btn-warm" id="successPay" title="成功付款">成功付款</button>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    var uName=parent.$("#username").val();//获取买家，用户的用户名
    //var uName='绫清竹';
    //请求我的待付款的订单
    $.ajax({
        url:"/CampusTrading/PendingPayment",
        data:{"uName":uName},
        type:"post",
        dataType:"json",
        success:function (data) {
            if(data.length<=0){
                $("#notOrder").show();
                $("#pendingPay").hide();
            }
            else {
                var payLi="";
                for(var i=0;i<data.length;i++){
                    //获取商品Id,来获取商品的具体信息
                    var gid=data[i].gId;
                    var goodsDetail=null;
                    $.ajax({
                        url:"/CampusTrading/GetGoodsDetail",
                        data:{"gid":gid},
                        type:"post",
                        async:false,
                        dataType:"json",
                        success:function (res) {
                            goodsDetail=res;
                        }
                    });
                    //获取收货人姓名，地址的id来查询收货地址的详情
                    var receiveId=data[i].receiveId;
                    var receive=null;
                    $.ajax({
                        url:"/CampusTrading/QueryAddressById",
                        data:{"id":receiveId},
                        type:"post",
                        async:false,
                        dataType:"json",
                        success:function (ref) {
                            receive=ref;
                        }
                    });
                    payLi+="<li><div class='pic'><img src='"+goodsDetail.picture+"'> </div><div class='goods'>" +
                        "<p><a title='"+goodsDetail.name+"'>"+goodsDetail.name+"</a></p> <p><a title='"+goodsDetail.content+"'>"+goodsDetail.content+"</a></p> </div>" +
                        " <div class='price'><p>单价:&emsp;￥"+data[i].unitPrice.toFixed(2)+"</p>" +
                        "<p>数量:&emsp;"+data[i].goodsNumber+"</p><p>总价:&emsp;￥"+data[i].totalPrice.toFixed(2)+"</p>" +
                        "</div><div class='receive'><p>收货人姓名:&ensp;"+receive.receiveMan+"</p>" +
                        "<p>收货人电话:&ensp;"+receive.receiveTel+"</p><p>收货人地址:&ensp;"+ receive.receiveAddress+"</p>";
                    if(data[i].buyerNote!=""){
                        payLi+="<p>备注:&ensp;"+data[i].buyerNote+"</p>";
                    }
                    payLi+="</div><div class='operate'><button class='layui-btn layui-btn-radius layui-btn-normal' " +
                        "onclick='pay("+data[i].oId+",&#39;"+data[i].sName+"&#39;)' title='付款'>付&emsp;&emsp;款</button><br>" +
                        "<button class='layui-btn layui-btn-radius layui-btn-primary' onclick='cancelOrder("+data[i].oId+")' title='取消订单'>取消订单</button></div> </li>";;

                }
                $("#pendingPayUl").append(payLi);
            }

        }
    });

    //点击取消订单按钮，删除这条订单,取消订单的方法，
    function cancelOrder(oId) {
        //弹窗询问是否确定
        layui.use('layer',function () {
            var layer=layui.layer;
            layer.confirm('您确定要取消该订单?',{icon:3,anim:2,title:'取消订单'},function (index) {
                //执行取消订单事件
                $.ajax({
                    url:"/CampusTrading/DeleteOrder",
                    data:{"oId":oId},
                    type:"post",
                    success:function (data) {
                        if(data=="1"){
                            layer.msg('取消订单成功',{icon:1,time:1500},function () {
                               window.location.reload();
                            });
                        }else{
                            layer.msg('取消订单失败',{icon:2,time:1500});
                        }
                    }
                });
            });

        });
    };

    //点击付款按钮，对订单进行付款
    function pay(oId,sName) {
        $("#payFor #sellerName").html(sName);
        $("#payFor #goodsId").val(oId);
        $.ajax({
            url:"/CampusTrading/QueryPhoneByName",
            data:{"name":sName},
            type:"post",
            success:function (data) {
                $("#payFor #sellerTel").html(data);
            }
        });
        layui.use('layer',function () {
            layer.open({
                type:1,
                title:['付款','background: #f9a0d5;font-size:18px'],
                anim:5,
                area:["420px",'380px'],
                shade: [0.4, '#cccccc'],
                content:$('#payFor'),
                cancel:function (index) {
                    $('#payFor').hide();
                }
            });
        });
    };

    //点击弹窗里面的取消付款
    $("#cancelPay").click(function () {
        $('#payFor').hide();
        layer.closeAll();
    });

    //点击弹窗里面的成功付款按钮
    $("#successPay").click(function () {
        var oId=$("#payFor #goodsId").val();
        $.ajax({
            url:"/CampusTrading/PayForOrder",
            data:{"oId":oId},
            type:"post",
            success:function (data) {
                if(data=="1"){
                    layer.msg('付款成功，卖家马上回核对订单后发货',{icon:1,time:1500,anim:2},function () {
                        window.location.reload();
                    });
                }
                else {
                    layer.msg('付款失败',{icon:2,time:1500,anim:3});
                }
            }
        })
    });
</script>
</body>
</html>
