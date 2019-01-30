package com.controller;

import com.alibaba.fastjson.JSONObject;
import com.entity.Notice;
import com.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author 墨水之寒
 * 公告的控制层 公告的查看、发布、修改、删除
 */
@Controller
public class NoticeController {

    @Autowired
    private NoticeService noticeService;

    @RequestMapping("NoticesList")
    public String noticesList(){//前往公告列表页面
        return "Notice/noticeList";
    }


    @RequestMapping(value = "GetAllNotices",produces="application/json;charset=utf-8")
    @ResponseBody
    public String getNoticeList(){//得到所有有效地公告列表
        List<Notice> list=noticeService.getNoticeList();
        return JSONObject.toJSONString(list);
    }

    @RequestMapping(value = "QueryNoticeById" ,produces = "application/json;charset=utf-8")
    @ResponseBody
    public String queryNoticeById(int id){
        Notice notice=noticeService.queryNoticeById(id);
        return JSONObject.toJSONString(notice);
    }

    @RequestMapping("DeleteNotice/{id}")
    @ResponseBody
    public String deleteNotice(@PathVariable("id")int id){//删除成功返回"1",否则"0"
        int d=noticeService.deleteNotice(id);
        return d>0?"1":"0";
    }

    @RequestMapping("EnterAddNotice")
    public String enterAddNotice(){//去往添加公告的页面
        return "Notice/addNotice";
    }

    @RequestMapping("AddNoticeDo")
    @ResponseBody
    public String addNotice(String title,String content){//想数据库中添加一条公告
        Notice notice=new Notice();
        notice.setTitle(title);
        notice.setContent(content);
        int n=noticeService.addNotice(notice);
        return n>0?"1":"0";
    }

    @RequestMapping("EditNotice")
    @ResponseBody
    public String editNotice(Notice notice){
        int e=noticeService.updateNotice(notice);
        return e>0?"1":"0";
    }
}
