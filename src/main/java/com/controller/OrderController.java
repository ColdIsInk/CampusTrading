package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Orders;
import com.entity.User;
import com.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @author 墨水之寒
 * 订单的处理，生成订单，改变订单的状态
 */
@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

    @RequestMapping(value="CreateOrderView/{goodsInfo}",method = RequestMethod.POST,produces="text/plain;charset=utf-8")
    public String createOrder(@PathVariable("goodsInfo")String goodsInfo,HttpServletRequest request){//进入创建订单的页面
        request.setAttribute("goodsInfo",goodsInfo);
        return "Order/createOrder";
    }

    @RequestMapping("NeedShippedNum")
    @ResponseBody
    public String needShippedNum(String name){
        int n= orderService.needShippedNum(name);
        return String.valueOf(n);
    }

    @RequestMapping(value = "QuerySellerByGid",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String querySellerByGid(int gId){//根据商品的ID来查询卖家的信息
        User user=orderService.selectNameByGID(gId);
        return JSONObject.toJSONString(user);
    }

    @RequestMapping("CreateOrder")
    @ResponseBody
    public String createOrder(String uName,String sName,int receiveId,int gId,int goodsNum,double unitPrice,String buyerNote,int state) {//创建订单
        double totalPrice = goodsNum * unitPrice;
        //根据商品的ID来查询卖家的姓名
        Orders order = new Orders();
        order.setsName(sName);
        order.setuName(uName);
        order.setgId(gId);
        order.setReceiveId(receiveId);
        order.setGoodsNumber(goodsNum);
        order.setUnitPrice(unitPrice);
        order.setTotalPrice(totalPrice);
        order.setBuyerNote(buyerNote);
        order.setState(state);
        int c = orderService.createOrder(order);
        return c > 0 ? "1" : "0";
    }

    @RequestMapping("AllKindsOrderNum")
    @ResponseBody
    public String allKindsOrderNum(String uName){//查询某个用户各种订单的数量
        return orderService.allKindsOrderNum(uName);
    }

    @RequestMapping("PaymentView")
    public String PaymentView(){//进入待付款的页面
        return "Order/pendingPayment";
    }

    @RequestMapping("ShippedView")
    public String shippedView(){//进入待发货的页面
        return "Order/pendingShipped";
    }

    @RequestMapping("ReceiptView")
    public String receiptView(){//进入待收货的页面
        return "Order/pendingReceipt";
    }

    @RequestMapping("EvaluateView")
    public String evaluationView(){//进入待评价的页面
        return "Order/pendingEvaluation";
    }

    @RequestMapping(value = "PendingPayment",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String pendingPayment(String uName){//查看待付款订单的详细信息
        List<Orders> list=orderService.pendingPayment(uName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "PendingShipped",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String pendingShipped(String uName){//查看待发货订单的详细信息
        List<Orders> list=orderService.pendingShipped(uName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "PendingReceipt",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String pendingReceipt(String uName){//查看待收货订单的详细信息
        List<Orders> list=orderService.pendingReceipt(uName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "PendingEvaluation",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String pendingEvaluation(String uName){//查看待评价订单的详细信息
        List<Orders> list=orderService.pendingEvaluation(uName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping("NeedShippedView")
    public String needShippedView(){//进入卖家需处理的订单的页面
        return "Order/needShipped";
    }

    @RequestMapping(value = "NeedShipped",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String needShipped(String sName){///查询卖家需处理的订单详细信息
        List<Orders> list=orderService.needShipped(sName);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping("DeleteOrder")
    @ResponseBody
    public String deleteOrder(int oId){//删除订单
        int d=orderService.deleteOrder(oId);
        return d>0?"1":"0";
    }

    @RequestMapping("PayForOrder")
    @ResponseBody
    public String payForOrder(int oId){
        int p=orderService.payForOrder(oId);
        return p>0?"1":"0";
    }

    @RequestMapping("ReceiveGoods")
    @ResponseBody
    public String receiveGoods(int oId){//买家确认收货
        int r=orderService.receiveGoods(oId);
        return r > 0?"1":"0";
    }

    @RequestMapping("EvaluateGoods")
    @ResponseBody
    public String evaluateGoods(int oId){
        int e=orderService.evaluateGoods(oId);
        return e>0?"1":"0";
    }

    @RequestMapping("SendGoods")
    @ResponseBody
    public String sendGoods(int oId){//卖家发货修改订单
        int s=orderService.sendGoods(oId);
        return s>0?"1":"0";
    }



}
