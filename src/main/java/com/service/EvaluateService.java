package com.service;

import com.dao.EvaluateDao;
import com.entity.Evaluate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluateService {
    @Autowired
    private EvaluateDao evaluateDao;

    public int createEvaluate(Evaluate evaluate){//添加评价
        return evaluateDao.createEvaluate(evaluate);
    }

    public List<Evaluate> selectEvaluateByGid(int gid){//查询评价
        return evaluateDao.selectEvaluateByGid(gid);
    }

}
