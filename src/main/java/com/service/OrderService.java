package com.service;

import com.dao.OrderDao;
import com.entity.Orders;
import com.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {
    @Autowired
    private OrderDao orderDao;

    public int needShippedNum(String sName){//查询卖家需处理订单的数量
        return orderDao.needShippedNum(sName);
    }

    public int createOrder(Orders order){//创建订单
        return orderDao.createOrder(order);
    }

    public User selectNameByGID(int gId){
        return orderDao.selectNameByGID(gId);
    }

    public String allKindsOrderNum(String uName){//查询各种订单的数量
        int p=orderDao.pendingPaymentCount(uName);
        int s=orderDao.pendingShippedCount(uName);
        int r=orderDao.pendingReceiptCount(uName);
        int e=orderDao.pendingEvaluationCount(uName);
        String orderCount=p+","+s+","+r+","+e;
        return orderCount;
    }

    public List<Orders> pendingPayment(String uName){//查询待付款订单的详情
        return orderDao.pendingPayment(uName);
    }

    public List<Orders> pendingShipped(String uName){//查询待发货订单的详情
        return orderDao.pendingShipped(uName);
    }

    public List<Orders> pendingReceipt(String uName){//查询待收货订单的详情
        return orderDao.pendingReceipt(uName);
    }

    public List<Orders> pendingEvaluation(String uName){//查询待评价订单的详情
        return orderDao.pendingEvaluation(uName);
    }

    public List<Orders> needShipped(String sName){//卖家需要处理的订单
        return orderDao.needShipped(sName);
    }

    public int deleteOrder(int oId){//买家删除自己的订单
        return orderDao.deleteOrder(oId);
    }

    public int payForOrder(int oId){//用户给未付款的订单付款
        return orderDao.payForOrder(oId);
    }

    public int receiveGoods(int oId){//买家确认收货，
        return orderDao.receiveGoods(oId);
    }

}
