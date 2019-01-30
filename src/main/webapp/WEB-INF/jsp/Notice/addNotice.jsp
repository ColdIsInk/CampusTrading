<%--
  Created by IntelliJ IDEA.
  User: 12829
  Date: 2019/1/5
  Time: 13:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加新公告</title>
    <link rel="stylesheet" type="text/css" href="css/layui.css"/>
    <style>
        .addNotice{
            width: 95%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 10px;
        }
        .addNotice h2{
            font-weight: 600;
            font-family: 华文行楷;
            font-size: 32px
        }
        .addNotice p{
            font-size: 18px;
            font-family: 微软雅黑;
            letter-spacing: 1px;
            margin-top: 12px;
            margin-bottom: 10px;
        }
        .addNotice input{
            width: 40%;
            height: 30px;
            border-radius: 4px;
            margin-left: 20px;
            border: 1px #333333 solid;
            padding-left: 6px;
        }
        .addNotice textarea{
            margin-left: auto;
            margin-right: auto;
            margin-top: 10px;
        }
        .addNotice button{
            margin-top: 20px;

        }
    </style>
</head>
<body>
<div class="addNotice">
    <h2>发布一条新公告</h2>
    <div>
        <p>公告标题</p>
        <input type="text" placeholder=" 请输入公告标题" id="title">
    </div>
    <div>
        <p>公告内容</p>
            <textarea class="layui-textarea" id="LAY_demo1">

             </textarea>
    </div>
    <div>
        <button class="layui-btn site-demo-layedit" id="release" title="发布公告">发布公告</button>
    </div>
</div>


<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/layui.all.js"></script>
<script>
    layui.use(['layedit','layer'], function() {
            var layedit = layui.layedit;
            var layer = layui.layer;
            //构建一个默认的编辑器
            var index = layedit.build('LAY_demo1');
            //编辑器外部操作
            $("#release").click(function () {
                var title = $("#title").val();
                var content = layedit.getContent(index);
                if (title == "") {
                    layer.msg('公告标题不能为空', {icon: 5, time: 2000});
                    $("#title").focus();
                }
                else if (content == "") {
                    layer.msg('公告内容不能为空', {icon: 5, time: 2000});
                    $("#LAY_demo1").focus();
                }
                else {
                    $.ajax({
                        url: "/CampusTrading/AddNoticeDo",
                        data: {"title": title, "content": content},
                        async: false,
                        type:"post",
                        success:function (res) {
                            if(res=="1"){
                                layer.open({
                                    title:'继续发布新公告'
                                    ,content: '添加成功!请点击确定继续添加，或点击取消查看公告列表'
                                    ,btn: ['继续', '取消']
                                    ,anim:2
                                    ,shade: [0.3,'#999']
                                    , yes: function (index) {
                                        layer.close(index);
                                        location.href=="/CampusTrading/EnterAddNotice";
                                    }
                                    , btn2: function () {
                                        $(window.parent.document).find("#queryNotice")[0].click()
                                    }
                                });
                            }
                            else {
                                layer.alert('抱歉，添加公告失败，请重新添加或稍后再试!',{icon:5,anim:1})
                            }
                        }
                    });

                }
            });
    });
</script>
</body>
</html>
