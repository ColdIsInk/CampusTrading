package com.service;

import com.dao.ShoppingCartDao;
import com.entity.Goods;
import com.entity.ShoppingCart;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartService {
    @Autowired
    private ShoppingCartDao shoppingCartDao;

    public int insertGoodsToCart(ShoppingCart shoppingCart){
        return shoppingCartDao.insertGoodsToCart(shoppingCart);
    }

    public int selectCartGoods(ShoppingCart shoppingCart){//加入购物车前判断，以免重复
        return shoppingCartDao.selectCartGoods(shoppingCart);
    }

    public int selectCartGoodsCount(String uName){//查询某个用户购物车中商品的总数
        return shoppingCartDao.selectCartGoodsCount(uName);
    }

    public List<Goods> selectCartGoodsByUName(String uName){//根据用户名查询该用户购物车的商品
        return shoppingCartDao.selectCartGoodsByUName(uName);
    }

    public int deleteCart(String uName,int gId){//删除
        return shoppingCartDao.deleteCart(uName,gId);
    }
}
