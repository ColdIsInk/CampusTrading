package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Evaluate;
import com.service.EvaluateService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 墨水之寒
 * 买家对商品的评价
 */
@Controller
public class EvaluateController {
    @Autowired
    private EvaluateService evaluateService;

    @RequestMapping(value = "QueryAllEvaluate",produces = "application/json;charset=utf-8")
    @ResponseBody
    public String queryAllEvaluate(int gid){//查询某个商品的评价
        List<Evaluate> list=evaluateService.selectEvaluateByGid(gid);
        return JSONObject.toJSONString(list);
    }

    @RequestMapping("CreateEvaluate")
    @ResponseBody
    public String createEvaluate(int gid,String uname,String content,int score){//创建一条评价
        Evaluate evaluate=new Evaluate();
        evaluate.setGid(gid);
        evaluate.setUname(uname);
        evaluate.setContent(content);
        evaluate.setScore(score);
        int c=evaluateService.createEvaluate(evaluate);
        return c>0?"1":"0";
    }
}
