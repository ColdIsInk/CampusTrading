<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/17
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>我的收货地址</title>
    <link rel="stylesheet" type="text/css" href="../css/receiptAddress.css"/>
    <link rel="stylesheet" type="text/css" href="../css/layui.css"/>

</head>
<body>
<input type="hidden" id="username" value="${username}">
<div class="address-box">
    <div class="address-tit">
        <span>我的收货地址</span>
        <button class="layui-btn layui-btn-normal" id="newAddress" title="添加新地址">添加新地址</button>
    </div>
    <div class="address-con">
        <div class="notAddress" id="notAddress">您还没有收货地址哟，快添加一个吧。</div>
        <ul id="allAddress">
        </ul>
    </div>

</div>

<!--添加一个新的收货地址的弹窗-->
<div class="addNewAddress" id="addNewAddress">
    <div>
        <span>收&ensp;货&ensp;人:</span><input type="text" id="uName" placeholder=" 请输入收货人姓名" required>
        <span>电话号码:</span><input type="tel" id="rTel" placeholder=" 请输入收货人电话号码" required>
    </div>
    <p>选择地址:</p>
    <div data-toggle="distpicker" class="selectAddress">
        <select data-province="--- 选择省 ---" id="province"></select>
        <select data-city="--- 选择市 ---" id="city"></select>
        <select data-district="---选择区(县)---" id="county"></select>
    </div>
    <div>
        <span style="float: left;">详细地址:</span>
        <textarea id="detailAddress" placeholder=" 请输入您的详细地址,如:街道号,小区号,门牌号"></textarea>
    </div>
    <form class="layui-form" style="margin-top: 8px">
        <span>是否默认:</span>
        <input type="checkbox" id="isDefault" lay-skin="switch" lay-text="是|否">
    </form>
</div>

<!--编辑收货信息的弹窗-->
<form class="layui-form editForm" id="editForm">
    <input type="hidden" name="id" id="id">
    <input type="hidden" name="username" value="${username}">
    <div>
        <span>收&ensp;货&ensp;人:</span><input type="text" id="rMan" name="receiveMan"  required>
        <span>电话号码:</span><input type="tel" id="rPhone" name="receiveTel" required>
    </div>
    <div>
        <span style="float: left;">详细地址:</span>
        <textarea id="rAddress" name="receiveAddress"></textarea>
    </div>
    <div class="layui-form" style="margin-top: 8px">
        <span>是否默认:</span>
        <input type="radio" name="isDefault" value="1" title="是">
        <input type="radio" name="isDefault" value="0" title="否">
    </div>

</form>


<script src="../js/jquery-3.2.1.min.js"></script>
<script src="../js/layui.all.js"></script>
<script src="../js/distpicker.js"></script>

<script>
    var username=$("#username").val();
    //获取该用户的所有收货地址
    $.ajax({
        url:"/CampusTrading/QueryAllAddress",
        data:{"username":username},
        type:"post",
        async:false,
        dataType:"json",
        success:function (data) {
            //先判断是否为空
            if(data.length<=0){
                $("#notAddress").show();
            }
            else {
                var liHtml="";
                for(var i=0;i<data.length;i++){
                    if(data[i].isDefault==1){
                        liHtml+="<li><input type='hidden' value='"+data[i].id+"'><div class='address-logo'><span>" +
                            data[i].receiveMan.substring(0,1)+"</span></div><div class='addressInfo'> <span class='name'>" +
                            data[i].receiveMan+"</span><span class='tel'>"+data[i].receiveTel+"</span>" +
                            "<p><i>默认</i>&ensp;"+data[i].receiveAddress+"</p></div> <div class='address-operation'>" +
                            "<a class='editAddress' title='编辑'>编辑</a><br><a class='deleteAddress' title='删除'>删除</a></div></li>";
                    }
                    else {
                        liHtml+="<li><input type='hidden' value='"+data[i].id+"'><div class='address-logo'><span>" +
                            data[i].receiveMan.substring(0,1)+"</span></div><div class='addressInfo'> <span class='name'>" +
                            data[i].receiveMan+"</span><span class='tel'>"+data[i].receiveTel+"</span>" +
                            "<p>"+data[i].receiveAddress+"</p></div> <div class='address-operation'>" +
                            "<a class='editAddress' title='编辑'>编辑</a><br><a class='deleteAddress' title='删除'>删除</a></div></li>";
                    }

                }
                $("#allAddress").append(liHtml);
            }
        }
    });

    //点击添加新地址，弹窗添加新地址弹窗进行添加
    $("#newAddress").click(function () {
        layui.use('layer',function () {
            var layer=layui.layer;
            layer.open({
                type: 1,
                title:['添加收货地址', 'font-size:18px;background: rgba(141,238,236,0.98)'],
                area: ['420px','400px'],
                btn:['确认','取消'],
                anim: 4,
                shade: [0.1, '#999999'],
                content:$('#addNewAddress'),
                //点击弹窗上面的X，关闭并隐藏
                cancel:function (index) {
                  layer.close(index);
                  $('#addNewAddress').hide();
                },
                //点击确认按钮，添加一个新地址，ajax请求
                yes:function (index) {
                    var name=$("#uName").val();
                    var tel=$("#rTel").val();
                    var province=$("#province  option:selected").val();//获取省
                    var city=$("#city  option:selected").val();//获取市
                    var county=$("#county  option:selected").val();//获取区、县
                    var detailAddress=$("#detailAddress").val();
                    var address=province+city+county+"  "+detailAddress;
                    var isDefault=0;
                    if($('#isDefault').is(':checked')){
                        isDefault=1;
                    }
                    else {isDefault=0;}
                    $.ajax({
                        url:"/CampusTrading/AddNewAddress",
                        data:{"username":username,"receiveMan":name,"receiveAddress":address,"receiveTel":tel,"isDefault":isDefault},
                        type:"post",
                        success:function (data) {
                            if(data=="1"){
                                layer.msg('添加成功',{icon:1,time:1500},function () {
                                    layer.close(index);
                                    $('#addNewAddress').hide();
                                    window.location.reload();
                                })
                            }else{
                                layer.msg('添加失败',{icon:2,time:1500})
                            }
                        }
                    });
                },
                btn2:function (index) {
                    layer.close(index);
                    $('#addNewAddress').hide();
                }
            })
        });

    });

    //点击编辑按钮，对该条收货地址进行编辑，弹出编辑的弹窗
    $(".editAddress").click(function () {
        var id=$(this).parent().parent().find("input").val();
        $.ajax({
            url:"/CampusTrading/QueryAddressById",
            data:{"id":id},
            type:"post",
            dataType:"json",
            async:false,
            success:function (data) {
                //给编辑框里面的表单赋值
               $("#id").val(data.id);
               $("#rMan").val(data.receiveMan);
               $("#rPhone").val(data.receiveTel);
               $("#rAddress").val(data.receiveAddress);
                if((data.isDefault)==0){
                    $("input[name=isDefault]:eq(1)").attr("checked",'checked');
                    layui.form.render('radio');
                }
                else{
                    $("input[name=isDefault]:eq(0)").attr("checked",'checked');
                    layui.form.render('radio');

                }
                layui.use('layer',function () {
                    var layer=layui.layer;
                    layer.open({
                        type: 1,
                        title:['编辑收货地址', 'font-size:18px;background: rgba(141,238,236,0.98)'],
                        area: ['420px','340px'],
                        btn:['确认','取消'],
                        anim: 4,
                        shade: [0.1, '#999999'],
                        content:$('#editForm'),
                        //点击弹窗上面的X，关闭并隐藏
                        cancel:function (index) {
                            layer.close(index);
                            $('#editForm').hide();
                        },
                        //点击确认按钮，添加一个新地址，ajax请求
                        yes:function (index) {
                            console.log($("#editForm").serialize());
                            $.ajax({
                                url:"/CampusTrading/ModifyAddress",
                                data:$("#editForm").serialize(),
                                type:"post",
                                success:function (data) {
                                    if(data=="1"){
                                        layer.msg('修改成功',{icon:1,time:1500},function () {
                                            layer.close(index);
                                            $('#editForm').hide();
                                            window.location.reload();
                                        })
                                    }
                                    else{
                                        layer.msg('修改失败',{icon:2,time:1500});
                                    }
                                }
                            });


                        },
                        btn2:function (index) {
                            layer.close(index);
                            $('#editForm').hide();
                        }
                    })
                })
            }
        })
    });

    //点击删除按钮，删除某条记录
    $(".deleteAddress").click(function () {
        var li=$(this).parent().parent();
        var id=li.find("input").val();
        layer.confirm('确定要删除该条收货地址吗？', {icon: 3, title:'删除收货地址',anim:1,shade: [0.5, '#cccccc']}, function(index){
            $.ajax({
                url:"/CampusTrading/DeleteAddress",
                data:{"id":id},
                type:"post",
                success:function (data) {
                    if(data=="1"){
                        layer.msg('删除成功',{icon:1,time:1500});
                        li.hide();
                    }else { layer.msg('删除成功',{icon:2,time:1500});}
                }
            });
            layer.close(index);
        });

    });

</script>
</body>
</html>
