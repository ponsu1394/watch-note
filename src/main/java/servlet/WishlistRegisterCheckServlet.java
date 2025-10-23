package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.WishlistWorkDAO;
import model.WishlistWork;

@WebServlet("/WishlistRegisterCheckServlet")
public class WishlistRegisterCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            String title = request.getParameter("title");
            String memo = request.getParameter("memo");
            String[] genreIds = request.getParameterValues("genre");

            WishlistWork work = new WishlistWork(); // WishlistWorkは観たい作品モデル
            work.setTitle(title);
            work.setMemo(memo);
 

            WishlistWorkDAO dao = new WishlistWorkDAO();
            int workId = dao.insertAndGetId(work); // insert後にIDを返すメソッド

            if (genreIds != null) {
                for (String genreIdStr : genreIds) {
                    int genreId = Integer.parseInt(genreIdStr);
                    dao.insertGenreMapping(workId, genreId); // 中間テーブル登録
                }
            }

            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegisterDone.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "登録に失敗しました");
        }
    }
}
