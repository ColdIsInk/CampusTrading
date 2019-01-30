
function Obj(){}  //创建一个对象

/*为这个对象添加一个具有一个参数的原型方法*/
Obj.prototype.draw=function(o){
    var speed=0;   //雪花每次下落的数值（10px）
    var startPosLeft=Math.ceil(Math.random()*document.documentElement.clientWidth);//设置雪花随机的开始x值的大小
    o.style.opacity=(Math.ceil(Math.random()*3)+9)/10;  //设置透明度
    o.style.left=startPosLeft+'px';
    o.style.color="#fff";
    o.style.fontSize=14+Math.ceil(Math.random()*14)+'px';
    setInterval(function(){
        //雪花下落的top值小鱼屏幕的可视区域高时执行下列
        if(speed<document.documentElement.clientHeight){
            o.style.top=speed+'px';
            o.style.left=startPosLeft+Math.ceil(Math.random()*9)+'px';
            speed+=10;
        }
        else{
            o.style.display='none';
        }
    },150);
}

var snow=document.getElementById('snow');

/*使用setInterval定时器每600毫秒创建一个雪花*/
setInterval(function(){
    var odiv=document.createElement('div');  //创建div
    odiv.innerHTML="✽";   //div的内容
    odiv.style.position='absolute';  //div的绝对定位
    snow.appendChild(odiv);   //把创建好的div放进flame中
    var obj=new Obj();   //创建函数
    obj.draw(odiv);  //执行obj的draw方法
},500);

// (function () {
//     $("#register_box").hide();//先隐藏注册页面
//     $("#register").click(function () {//点击立即注册按钮跳转到注册页面
//         $("head title").html("注册");
//         $("#login_box").slideUp(600);
//         $("#register_box").slideDown(1600);
//     })
//     $("#login").click(function () {//点击立即注册按钮跳转到注册页面
//         $("head title").html("登录");
//         $("#register_box").fadeOut(400);
//         $("#login_box").fadeIn(1500);
//     })
// })();
