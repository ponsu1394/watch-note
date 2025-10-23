package service;

import java.util.List;

import dao.ViewedWorkDAO;
import model.ViewedWork;

public class ViewedLogic {

    private ViewedWorkDAO viewedWorkDAO = new ViewedWorkDAO();

    // 全作品取得
    public List<ViewedWork> getAllViewedWorks() {
        return viewedWorkDAO.findAll();
    }

    // 新規登録
    public boolean registerViewedWork(ViewedWork work) {
        try {
            viewedWorkDAO.insertAndGetId(work);
            return true;
        } catch (Exception e) {
            // ログ出力や通知処理などもここで可能
            return false;
        }
    }

    // 更新処理
    public boolean updateViewedWork(ViewedWork work) {
        try {
            viewedWorkDAO.update(work);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    // 削除処理
    public boolean deleteViewedWork(int id) {
        try {
            viewedWorkDAO.delete(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}