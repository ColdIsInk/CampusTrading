package com.service;

import com.dao.NoticeDao;
import com.entity.Notice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author 墨水之寒
 * 公告的服务层
 */
@Service
public class NoticeService {
    @Autowired
    private NoticeDao noticeDao;


    public List<Notice> getNoticeList(){//公告列表
        return noticeDao.getNoticeList();
    }

    public Notice queryNoticeById(int id){
        return noticeDao.queryNoticeById(id);
    }

    public int addNotice(Notice notice){//发布、添加公告
        return noticeDao.addNotice(notice);
    }

    public int updateNotice(Notice notice){//修改公告
        return noticeDao.updateNotice(notice);
    }

    public int deleteNotice(int id){//根据ID删除公告
        return noticeDao.deleteNotice(id);
    }
}
