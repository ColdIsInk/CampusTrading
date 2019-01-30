<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/24
  Time: 11:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>待评价订单详情页面</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        /*没有相关订单时*/
        .notOrder{width: 400px;height: 160px;margin-left: auto;margin-right: auto;margin-top: 30px;display: none;}
        .notNode{margin-left: 24px;color: #666666;letter-spacing: 2px;}
        /*需要付款的订单的样式*/
        .pendingPay{width: 740px;margin-right: auto;margin-left: auto;}
        .pendingPay h3{width: 100%;text-align: center;font-size: 26px;letter-spacing: 2px;font-family: 华文隶书;margin-top: 20px;}
        .pendingPay ul{margin-top: 16px;}
        .pendingPay ul li{width:100%;height: 160px;margin-top: 16px;background: rgba(181,211,233,0.63)}
        .pendingPay ul li>div{float: left;margin-left: 20px;}
        .pendingPay ul li>div p{margin-top: 8px;}
        .pendingPay ul li a{color: #555555;}
        .pendingPay ul li a:hover{cursor: pointer;color: #ff780e}
        .pendingPay ul li .pic{margin-left: 6px;}
        .pendingPay ul li img{width: 170px;height: 150px;margin-top: 5px;}
        .pendingPay ul li img:hover{cursor: pointer;}
        .pendingPay ul li .goods{width: 240px;margin-top: 22px;}
        .pendingPay ul li .price{width: 130px;margin-top: 22px;}
        .pendingPay ul li .operate button{margin-top: 10px;margin-top: 50px;font-size: 16px;border-radius: 20px;}
        /*评价框*/
        .evaluate{width: 324px;margin-top: 20px;
            margin-right: auto;margin-left: auto;display: none;}
        .evaluate .layui-inline{color: #888888;}
        .evaluate .pingFen{width: 100%;height: 50px;margin-left: 25px;}
        .evaluate textarea{width: 320px;height: 120px;resize: none;border: #b7fffa 1px solid;}

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

<!--评价商品-->
<div class="evaluate" id="evaluate">
    <div class="pingFen">
        <img src="" width="50" height="50">
        商品描述:&emsp;<span id="grade"></span>
    </div>
    <div style="margin-top: 10px;">
        <textarea id="eContent" placeholder="  宝贝满足你的期待吗？说说你的使用心得，分享给想买的他们吧"></textarea>
    </div>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    //var uName=parent.$("#username").val();//获取买家，用户的用户名
    var uName='绫清竹';
    //请求待评价的订单
    $.ajax({
        url:"/CampusTrading/PendingEvaluation",
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
                        "</div><div class='operate'><button class='layui-btn layui-btn-radius layui-btn-warm' " +
                        "onclick='Evaluation("+data[i].oId+","+data[i].gId+",&#39"+goodsDetail.picture+"&#39;)' title='评价'>评&emsp;价</button></div> </li>";;

                }
                $("#pendingPayUl").append(payLi);
            }

        }
    });

    //加载layui的评分插件
    layui.use('rate', function(){
        var rate = layui.rate;
        rate.render({
            elem: '#grade'
            ,value: 4
            ,text: true
            ,theme: '#ff362f'
            ,setText: function(value){ //自定义文本的回调
                var arrs = {
                    '1': '极差'
                    ,'2': '差'
                    ,'3': '一般'
                    ,'4': '好'
                    ,'5': '极好'
                };
                this.span.text(arrs[value] || ( value + "星"));
            }
        })
    });


    function Evaluation(oId,gId,picture) {
        $("#evaluate img").attr("src",picture);
        layui.use('layer',function () {
            layer.open({
                type:1,
                title:['评价商品','background: #f9a0d5;font-size:18px'],
                anim:5,
                btn:['发布评价','取消评价'],
                area:["420px",'310px'],
                shade: [0.4, '#cccccc'],
                content:$('#evaluate'),
                cancel:function (index) {
                    $('#evaluate').hide();
                },
                //点击发布评价，添加一条评价
                yes:function (index) {
                    //获取评分中星星的个数,也就是评分
                    var score=$("#grade .layui-icon-rate-solid").length;
                    //评价内容
                    var content=$("#eContent").val();
                    //添加评价
                    $.ajax({
                        url:"/CampusTrading/CreateEvaluate",
                        data:{"gid":gId,"uname":uName,"content":content,"score":score},
                        type:"post",
                        success:function (res) {
                           if(res=="1"){
                               //添加评价成功后，改变订单状态
                               $.ajax({
                                   url:"/CampusTrading/EvaluateGoods",
                                   data:{"oId":oId},
                                   type:"post",
                                   success:function (ref) {
                                       console.log("123");
                                       if(ref=="1"){
                                           layer.msg('添加评价成功',{icon:1,time:1500},function () {
                                               window.location.reload();
                                           });
                                       }
                                   }
                               });
                           }
                           else{
                               layer.msg('评价失败',{icon:5,time:1500})
                           }
                        }
                    });
                },
                //点击取消评价按钮，关闭弹窗
                btn2:function (index) {
                    layer.close(index);
                    $('#evaluate').hide();
                }
            });
        });

    }
</script>
</body>
</html>
