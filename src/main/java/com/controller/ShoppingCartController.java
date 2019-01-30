package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Goods;
import com.entity.ShoppingCart;
import com.service.ShoppingCartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ShoppingCartController {
    @Autowired
    private ShoppingCartService shoppingCartService;

    @RequestMapping("AddGoodsToCart")
    @ResponseBody
    public String insertGoodsToCart(String uName,int gId){//向购物车中添加商品，添加前先判断是否有重复的
        ShoppingCart shoppingCart=new ShoppingCart();
        shoppingCart.setuName(uName);
        shoppingCart.setgId(gId);
        int s=shoppingCartService.selectCartGoods(shoppingCart);
        if(s>0){
            return "-1";
        }else{
            int i=shoppingCartService.insertGoodsToCart(shoppingCart);
            return i>0?"1":"0";
        }

    }

    @RequestMapping("CartGoodsTotal")
    @ResponseBody
    public String selectCartGoodsCount(String username){//获取某个用户购物车中的商品总数
       int s=shoppingCartService.selectCartGoodsCount(username);
       return String.valueOf(s);
    }

    @RequestMapping(value = "QueryCartGoodsByUName",produces="application/json;charset=utf-8")
    @ResponseBody
    public String selectCartGoodsByUName(String name){//查询某个用户购物车中的商品信息
        List<Goods> list=shoppingCartService.selectCartGoodsByUName(name);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping("DeleteGoodsOfCart")
    @ResponseBody
    public String deleteCart(String uName,int gId){//删除自己购物车中的商品
        int d=shoppingCartService.deleteCart(uName,gId);
        return d>0?"1":"0";
    }

    @RequestMapping("EnterMyCart")
    public String enterMyCart(){//进入我的购物车
        return "Goods/myCart";
    }



}
