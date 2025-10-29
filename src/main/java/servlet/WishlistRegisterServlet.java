package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.GenreDAO;
import model.Genre;

@WebServlet("/WishlistRegisterServlet")
public class WishlistRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Genre> genres = new GenreDAO().findAll();
        request.setAttribute("genres", genres);
        request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegister.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String step = request.getParameter("step");

        // 共通で取得する入力値
        String title = request.getParameter("title");
        String[] genreIds = request.getParameterValues("genre");
        String memo = request.getParameter("memo");
        String id = request.getParameter("id");

        List<Genre> genres = new GenreDAO().findAll();

        // 共通でセットする属性
        request.setAttribute("title", title);
        request.setAttribute("genreIds", genreIds);
        request.setAttribute("memo", memo);
        request.setAttribute("genres", genres);

        if ("戻る".equals(step)) {
            response.sendRedirect(request.getContextPath() + "/WishListServlet");

        } else if ("確認".equals(step)) {
            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegisterCheck.jsp").forward(request, response);

        } else if ("修正".equals(step)) {
            // 「修正」ステップでは再取得が必要（上で取得済みなので再利用）
            request.setAttribute("id", id);
            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegister.jsp").forward(request, response);

        } else {
            // 想定外の step 値が来た場合は一覧に戻す
            response.sendRedirect(request.getContextPath() + "/WishListServlet");
        }
    }
}

