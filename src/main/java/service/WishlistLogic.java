package service;

import java.util.List;

import dao.WishlistWorkDAO;
import model.WishlistWork;

public class WishlistLogic {

    private WishlistWorkDAO dao = new WishlistWorkDAO();

    public List<WishlistWork> getAllWishlistWorks() {
        return dao.findAll();
    }

    public WishlistWork findById(int id) {
        return dao.findById(id);
    }

    public boolean registerWishlistWork(WishlistWork work, String[] genreIds) {
        try {
            int newId = dao.insertAndGetId(work);
            for (String gid : genreIds) {
                dao.insertGenreMapping(newId, Integer.parseInt(gid));
            }
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean updateWishlistWork(WishlistWork work, String[] genreIds) {
        try {
            dao.update(work);
            dao.updateGenreMapping(work.getId(), genreIds);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean deleteWishlistWork(int id) {
        try {
            dao.deleteGenreMapping(id);
            dao.delete(id);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
