<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/6
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我购物车中商品</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .cartGoods{width: 900px;
            margin-left: auto;margin-top: 20px;
            margin-right: auto;}
        .cartGoods h3{font-size: 32px;width: 100%;text-align: center;font-family: 方正舒体;color: rgba(238,105,125,0.98)}
        .cartGoods>p{margin-top: 8px;margin-left: 100px;font-size: 18px;font-family: 微软雅黑}
        .cartGoods .kong{margin-top: 20px;display: none;}
        .cartGoods ul li{height:160px;width:100%;background: #e2e2e2;border: #666666 1px solid;margin-top: 10px }
        .cartGoods ul li img{width:160px;height: 150px;margin-top: 5px;margin-left: 20px;}
        .cartGoods ul li img:hover{cursor: pointer;}
        .cartGoods ul li div{float: left;}
        .cartGoods ul li .name{width: 30%;height:130px;margin-top:22px;text-align: center;margin-left: 30px;vertical-align:middle;}
        .cartGoods ul li .name a{display:inline-block;margin-top: 8px;}
        .cartGoods ul li .name a:hover{text-decoration: underline;color: rgba(238,43,46,0.98);cursor: pointer;}
        .cartGoods ul li .price,.cartGoods ul li .totalPrice{width:100px;height:160px;color: rgba(238,168,80,0.98);
            font-size: 20px;line-height: 160px;margin-left: 30px;}
        .cartGoods ul li .num{margin-left: 20px;height:80px;margin-top: 70px}
        .cartGoods ul li .num input[type=number]{width: 25px;height: 24px;margin-left: 4px;margin-right: 4px}
        .cartGoods ul li .caoZuo{line-height: 150px;line-height: 160px;margin-left:20px;}
        .cartGoods ul li .delete:hover{cursor: pointer}
        input::-webkit-outer-spin-button,
        input::-webkit-inner-spin-button{
            -webkit-appearance: none !important;
            margin: 0;
        }
    </style>
</head>
<body>
<div class="cartGoods" id="cartGoods">
    <h3>我的购物车中商品</h3>
    <p id="kong" class="kong">您的购物车空空如也，快去浏览并添加宝贝吧。</p>
    <p id="totalP">共<span id="total" style="color: #FF00FF"></span>件宝贝</p>
    <ul id="cartGoodsUl"></ul>
</div>

<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    var username=parent.$("#username").val();
    //获取当前用户购物车中的所有商品
    $.ajax({
        url:"/CampusTrading/QueryCartGoodsByUName",
        data:{"name":username},
        type:"post",
        async:false,
        dataType:"json",
        success:function (data) {
            var goodsInfo="";
            $("#total").html(data.length);
            //先判断购物车中是否有商品
            if(data.length<=0){
                $("#kong").show();
            }
            else {
                for(var i=0;i<data.length;i++){
                    goodsInfo+="<li><input type='hidden' class='gId' value='"+data[i].g_id+"'> " +
                        "<div> <img src='"+data[i].picture+"'></div><div class='name'>" +
                        "<a title='"+data[i].name+"'>"+data[i].name+"</a><br><a title='"+data[i].content+"'>"+data[i].content+"</a></div><div class='price'>" +
                        "￥<span class='priceNum'>"+data[i].price.toFixed(2)+"</span></div><div class='num'>" +
                        "<input type='button' value='-' class='layui-btn layui-btn-xs reduce' title='减'>" +
                        "<input type='number' value='1' min='1' class='sum'>" +
                        "<input type='button'  value='+' class='layui-btn layui-btn-xs add' title='加'>" +
                        "<input type='hidden' class='inventory' value='"+data[i].number+"'></div>" +
                        "<div class='totalPrice'>￥<span class='totalNum'>"+data[i].price.toFixed(2)+"</span>" +
                        "</div><div class='caoZuo'><a title='删除' class='delete'>删除</a></div></li>"
                }
                $("#cartGoodsUl").append(goodsInfo);
            }


        }
    });
    //加、减按钮的变化
    layui.use('layer',function () {
        var layer=layui.layer;
        //购物车中的加减
        $(".add").click(function () {
            var inventory=$(this).parent().find(".inventory").val();
            var sum=$(this).parent().find(".sum").val();
            var priceNum=$(this).parent().parent().find(".priceNum").text();
            $(this).parent().find(".reduce").removeClass("layui-btn-disabled");
            if(sum>=inventory){
                $(this).addClass("layui-btn-disabled");
                layer.msg('商品数量已经达到库存上限，不能再增加了',{icon:2,time:1500});
            }
            else {
                sum++;
                $(this).parent().parent().find(".totalNum").html((priceNum*sum).toFixed(2));
                $(this).parent().find(".sum").val(sum);
            }
        });
        $(".reduce").click(function () {
            var sum=$(this).parent().find(".sum").val();
            var priceNum=$(this).parent().parent().find(".priceNum").html();
            $(this).parent().find(".add").removeClass("layui-btn-disabled");
            if(sum<=1){
                $(this).parent().find(".reduce").addClass("layui-btn-disabled");
                layer.msg('商品数量不能为负数，不能再减少了',{icon:2,time:1500});
            }
            else {
                sum=sum-1;
                $(this).parent().parent().find(".totalNum").html((priceNum*sum).toFixed(2));
                $(this).parent().find(".sum").val(sum);
            }
        });
        $(".sum").unbind("input propertychange").bind("input propertychange",function () {
            var inventory=$(this).parent().find(".inventory").val();
            var priceNum=$(this).parent().parent().find(".priceNum").html();
            var sum=$(this).val();
            if(sum>inventory){
                $(".sum").val(inventory);
                layer.msg('您输入的商品数量以及超过库存了',{icon:2,time:1500});
            }
            else if(sum<=1) {
                $(".sum").val(1);
                layer.msg('您输入的商品数量不正确，请重新输入',{icon:2,time:1500});
            }else {
                $(this).parent().parent().find(".totalNum").html((priceNum*sum).toFixed(2));
            }
            jQuery.removeData(this);//删除之前的数据
        });
    });
    //点击删除按钮
    $(".delete").click(function () {
        var gId=$(this).parent().parent().find(".gId").val();
        layui.use('layer',function () {
            var layer=layui.layer;
            layer.confirm('您确定要删除您购物车中这件宝贝吗？',{
                anim:1,
                title:'删除商品',
                shade: [0.5, '#cccccc'],
                icon:3},
                function (index) {
                    layer.close(index);
                    $.ajax({
                        url:"/CampusTrading/DeleteGoodsOfCart",
                        data:{"uName":username,"gId":gId},
                        type:"post",
                        success:function (data) {
                            var gTotal=parent.$("#goodsTotal").html();
                            if(data=="1"){
                                //改变购物车旁边的数字，为0是不显示
                                gTotal--;
                                if(gTotal==0){
                                    parent.$("#goodsTotal").html("");
                                }
                                else {parent.$("#goodsTotal").html(gTotal);}

                                layer.msg('成功删除,但宝贝舍不得您。',{icon:5,time:1500},function () {
                                    window.location.reload();
                                });

                            }
                            else{
                                layer.msg('删除失败',{icon:2,time:2000});
                            }
                        }

                    });
                }
            )
        })
    });
    //点击里面商品信息，跳转到商品详情页面
    $("#cartGoodsUl li .name").click(function () {
        var gid=$(this).parent().find(".gId").val()
        location.href="/CampusTrading/QueryGoodsDetail/"+gid;
    });

</script>
</body>
</html>
