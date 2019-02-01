<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/24
  Time: 11:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>卖家需处理的订单</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notNode{margin-left: 30px;color: #666666;letter-spacing: 2px;}
        /*需要付款的订单的样式*/
        .needShipped{width: 920px;margin-right: auto;margin-left: auto;}
        .needShipped h3{width: 100%;text-align: center;font-size: 26px;letter-spacing: 2px;font-family: 华文隶书;margin-top: 20px;}
        .needShipped ul{margin-top: 16px;}
        .needShipped ul li{width:100%;height: 160px;margin-top: 16px;background: rgba(181,211,233,0.63)}
        .needShipped ul li>div{float: left;margin-left: 20px;}
        .needShipped ul li>div p{margin-top: 8px;}
        .needShipped ul li a{color: #555555;}
        .needShipped ul li a:hover{cursor: pointer;color: #ff780e}
        .needShipped ul li .pic{margin-left: 6px;}
        .needShipped ul li img{width: 150px;height: 150px;margin-top: 5px;}
        .needShipped ul li img:hover{cursor: pointer;}
        .needShipped ul li .goods{width: 210px;margin-top: 22px;}
        .needShipped ul li .price{width: 120px;margin-top: 22px;}
        .needShipped ul li .receive{width: 250px;margin-top: 16px;height: 142px;overflow: hidden;color: #666666;}
        .needShipped ul li .operate button{margin-top: 10px;margin-top: 60px;font-size: 16px;border-radius: 16px;}
    </style>
</head>
<body>
<!--没有订单时-->
<div class="notOrder" id="notOrder">
    <img src="images/none.png" width="150" height="150" alt="没有相关订单">
    <i class="notNode">您还没有需要处理的订单哟</i>

</div>
<!--待处理的订单-->
<div class="needShipped" id="needShipped">
    <h3>我的需处理的订单</h3>
    <ul id="needShippedUl"></ul>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //var sName=parent.$("#username").val();//获取卖家，用户的用户名
    var sName='云龙';
    //请求我的需要处理的订单
    $.ajax({
        url:"/CampusTrading/NeedShipped",
        data:{"sName":sName},
        type:"post",
        dataType:"json",
        success:function (data) {
            if(data.length<=0){
                $("#notOrder").show();
                $("#needShipped").hide();
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
                    payLi+="</div><div class='operate'><button class='layui-btn layui-btn-normal'" +
                        "onclick='delivery("+data[i].oId+","+data[i].gId+","+data[i].goodsNumber+")' title='发货'>发&emsp;货</button></div> </li>";;

                }
                $("#needShippedUl").append(payLi);
            }

        }
    });

    //点击发货按钮，进行发货处理
    function delivery(oId,gId,gNum) {
        //卖家发货，修改订单状态
        $.ajax({
            url:"/CampusTrading/SendGoods",
            data:{"oId":oId},
            type:"post",
            success:function (data) {
                if(data=="1"){
                    $.ajax({
                        url:"/CampusTrading/ModifyGoodsNum",
                        data:{"number":gNum,"gId":gId},
                        type:"post",
                        success:function (res) {
                            if(res=="1"){
                                layer.msg('发货成功',{icon:1,time:1500},function () {
                                    window.location.reload();
                                });
                            }
                        }

                    })
                }
                else {
                    layer.msg('发货失败',{icon:1,time:1500});
                }
            }
        });

    }
</script>

</body>
</html>
