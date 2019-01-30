package com.dao;

import com.entity.Orders;
import com.entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderDao {

    int needShippedNum(String sName);//卖家需处理订单的数量

    User selectNameByGID(int gId);//商品的ID来查询卖家的姓名

    List<Orders> pendingPayment(String uName);//待付款

    List<Orders> pendingShipped(String uName);//待发货

    List<Orders> pendingReceipt(String uName);//待收货

    List<Orders> pendingEvaluation(String uName);//待评价

    int pendingPaymentCount(String uName);//待付款数量

    int pendingShippedCount(String uName);//待发货数量

    int pendingReceiptCount(String uName);//待收货数量

    int pendingEvaluationCount(String uName);//待评价数量

    List<Orders> needShipped(String sName);//卖家需要处理的订单

    int createOrder(Orders order);//创建一个订单，

    int payForOrder(int oId);//给某个订单付款

    int sendGoods(int oId);//发货后修改订单状态,卖家发货

    int receiveGoods(int oId);//买家接收商品，修改订单状态

    int evaluateGoods(int oId);//买家对订单中的商品进行评价

    int deleteOrder(int oId);//买家删除自己的订单


}
