package com.dao;

import com.entity.Notice;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 公告
 * @author  墨水之寒
 */
@Repository
public interface NoticeDao {
    /**
     * 公告列表
     */
    List<Notice> getNoticeList();

    Notice queryNoticeById(int id);

    int addNotice(Notice notice);

    int updateNotice(Notice notice);

    int deleteNotice(int id);
}
