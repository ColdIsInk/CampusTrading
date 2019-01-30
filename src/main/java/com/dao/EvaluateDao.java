package com.dao;

import com.entity.Evaluate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EvaluateDao {

    int createEvaluate(Evaluate evaluate);//添加评价

    List<Evaluate> selectEvaluateByGid(int gid);//查询评价
}
