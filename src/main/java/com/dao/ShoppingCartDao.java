package com.dao;

import com.entity.Goods;
import com.entity.ShoppingCart;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ShoppingCartDao {
    int insertGoodsToCart(ShoppingCart shoppingCart);

    int selectCartGoods(ShoppingCart shoppingCart);//加入购物车前判断，以免重复

    int selectCartGoodsCount(String uName);//查询某个用户购物车中商品的总数

    List<Goods> selectCartGoodsByUName(String uName);//根据用户名查询改用户购物车的商品

    int deleteCart(@Param("uName")String uName,@Param("gId")int gId);//删除
}
