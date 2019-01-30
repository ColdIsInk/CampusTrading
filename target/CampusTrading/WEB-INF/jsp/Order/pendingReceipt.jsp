<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/24
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待收货订单详情页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notNode{margin-left: 24px;color: #666666;letter-spacing: 2px;}
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

        /*查看物流*/
        .logistics{width: 400px;margin-right: auto;margin-left: auto;margin-top: 20px;display: none;}
        .logistics img{margin-left: 10px;}
        .logistics i{display:inline-block;width: 170px;float: right;margin-right: 8px;color: #555555;margin-top: 60px;}
        .logistics .logTel{margin-top: 10px;margin-left: 30px;}
        .logistics .logTel p{margin-left: 30px;margin-top: 8px;}
        .logistics .logTel p span{color: #ff48b1;font-size: 18px;}
    </style>
</head>
<body>
<!--没有订单时-->
<div class="notOrder" id="notOrder">
    <img src="images/none.png" width="150" height="150" alt="没有相关订单">
    <i class="notNode">您还没有相关订单哟</i>
</div>
<!--待收货的订单-->
<div class="pendingPay" id="pendingPay">
    <h3>我的待收货的订单</h3>
    <ul id="pendingPayUl"></ul>
</div>

<!--查看物流的弹窗-->
<div class="logistics" id="logistics">
    <img src="images/logistics.jpg" width="200" height="180">
    <i>您的宝贝卖家正在飞速送来中，请稍稍等待。</i>
    <div class="logTel">
        <span>如果您想询问物流的详细信息,可致电卖家</span>
        <p>卖家联系电话:&emsp;<span id="sTel"></span></p>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //var uName=parent.$("#username").val();//获取买家，用户的用户名
    var uName='绫清竹';
    //请求我的待收货的订单
    $.ajax({
        url:"/CampusTrading/PendingReceipt",
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
                    payLi+="</div><div class='operate'><button class='layui-btn layui-btn-radius layui-btn-primary' " +
                        "onclick='checkLog("+receive.receiveTel+")' title='查看物流'>查看物流</button><br>" +
                        "<button class='layui-btn layui-btn-radius layui-btn-warm' onclick='confirmGoods("+data[i].oId+")' title='确认收货'>确认收货</button></div> </li>";;

                }
                $("#pendingPayUl").append(payLi);
            }

        }
    });

    /*点击订单里面的查看物流事件，查看宝贝在那里了*/
    function checkLog(tel) {
        $("#sTel").html(tel);
        layer.open({
            type:1,
            title:['查看物流','background:#dfffe4;font-size:16px;'],
            shade: [0.4, '#cccccc'],
            btn:['确认'],
            anim:2,
            area: ['480px', '360px'],
            content:$('#logistics'),
            cancel:function () {
                $("#logistics").hide();
            },
            yes:function (index) {
                layer.close(index);
                $("#logistics").hide();
            }

        });
    }
    /*点击确认收货按钮，用户确认收到货物，改变订单状态*/
    function confirmGoods(oId) {
        layer.confirm('请确定您购买的宝贝已收到',{icon:3,anim:2,title:'确认收货'},function(){
            $.ajax({
                url:"/CampusTrading/ReceiveGoods",
                data:{"oId":oId},
                type:"post",
                success:function (data) {
                    if(data=="1"){
                        layer.alert('已确认收货,可去评价该商品',{icon:1,title:'已收货'},function () {
                            window.location.href="/CampusTrading/EvaluateView";
                        });
                    }
                    else {
                        layer.msg('不好意思，失败了',{icon:2,time:1800});
                    }
                }
            });
        });

    }
</script>
</body>
</html>
