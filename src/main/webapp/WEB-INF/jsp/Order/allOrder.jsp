<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/25
  Time: 13:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>所有交易未完成的订单</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .orderDetail{width: 320px;height: 320px;margin-right: auto;margin-left: auto;margin-top:10px;font-size:15px;display: none;}
        .orderDetail label{margin-top: 5px;display: block;}
        .orderDetail label span{margin-left: 10px;}

    </style>
</head>
<body>
<table id="ordersTable" class="layui-table" lay-filter="orders"></table>

<!--某条订单的详细情况-->
<div class="orderDetail" id="orderDetail">
    <label>订单编号:<span id="oId"></span></label>
    <label>卖家姓名:<span id="sName"></span></label>
    <label>买家姓名:<span id="bName"></span></label>
    <label>商品编号:<span id="gId"></span></label>
    <label>商品数量:<span id="num"></span></label>
    <label>商品单价:<span id="price"></span></label>
    <label>订单总价:<span id="tPrice"></span></label>
    <label>买家备注:<span id="buyNote"></span></label>
    <label>收货人名:<span id="rName"></span></label>
    <label>收货地址:<span id="address"></span></label>
    <label>电话号码:<span id="phone"></span></label>
    <label>创建时间:<span id="createTime"></span></label>
    <label>订单状态:<span id="state"></span></label>
</div>
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<!--在表格的每行数据后加编辑和删除按钮-->
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-sm" lay-event="edit" title="查看详情">查看详情</a>
</script>
<!--订单状态-->
<script type="text/html" id="stateDemo">
    {{#if (d.state == 1) { }}
    <span>待付款</span>
    {{# }else if(d.state == 2){ }}
    <span>待发货</span>
    {{# }else if(d.state == 3){ }}
    <span>待收货</span>
    {{# }else if(d.state == 4){ }}
    <span>待评价</span>
    {{# } }}
</script>
<script>
    $.ajax({
        url:"/CampusTrading/QueryAllOrders",
        type:"post",
        async:false,
        dataType:"json",
        success:function (res) {
            layui.use(['table', 'layer'], function () {
                var table = layui.table;
                var layer = layui.layer;
                table.render({
                    elem: '#ordersTable'
                    , cols: [[ //表头
                        {field: 'oId', title: '订单编号', width: 80}
                        , {field: 'gId', title: '商品编号', width: 100}
                        , {field: 'buyerNote', title: '买家备注'}
                        , {field: 'totalPrice', title: '订单总价'}
                        , {field: 'createTime', title: '创建时间', width: 180}
                        , {field: 'state', title: '状态',toolbar:'#stateDemo',width: 100}
                        , {fixed: 'right', title: '操作', width: 140, align: 'center', toolbar: '#barDemo'}
                    ]]
                    , data: res
                    , page: true //开启分页
                    , limit: 5
                    , limits: [5, 8, 10]
                });
                table.on('tool(orders)', function(obj){ //注：tool 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
                    var order = obj.data //获得当前行数据
                        ,layEvent = obj.event; //获得 lay-event 对应的值
                    //执行查看某个订单详情
                    if(layEvent === 'edit'){
                        //根据收货地址的ID来获取某个地址的详情
                        $.ajax({
                            url:"/CampusTrading/QueryAddressById",
                            data:{"id":order.receiveId},
                            type:"post",
                            async:false,
                            dataType:"json",
                            success:function (ref) {
                                $("#oId").html(order.oId);
                                $("#sName").html(order.sName);
                                $("#bName").html(order.uName);
                                $("#gId").html(order.gId);
                                $("#num").html(order.goodsNumber);
                                $("#price").html(order.unitPrice);
                                $("#tPrice").html(order.totalPrice);
                                if(order.buyerNote==""){
                                    $("#buyNote").html("NULL");
                                }else{
                                    $("#buyNote").html(order.buyerNote);
                                }
                                $("#rName").html(ref.receiveMan);
                                $("#address").html(ref.receiveAddress);
                                $("#phone").html(ref.receiveTel);
                                $("#createTime").html(order.createTime);
                                var orderState="";
                                if(order.state==1){
                                    orderState="待付款";
                                } else if(order.state==2){
                                    orderState="待发货";
                                } else if(order.state==3){
                                    orderState="待收货";
                                }else{
                                    orderState="待评价";
                                }
                                $("#state").html(orderState);

                            }

                        });
                        layer.open({
                            type:1,
                            title:['订单详细情况','background: #91ffdb;font-size:18px'],
                            anim:2,
                            area:["400px",'380px'],
                            shade: [0.4, '#cccccc'],
                            content:$('#orderDetail'),
                            cancel:function (index) {
                                $('#orderDetail').hide();
                            }
                        });
                    }
                });
            })
        }
    });


</script>
</body>
</html>
