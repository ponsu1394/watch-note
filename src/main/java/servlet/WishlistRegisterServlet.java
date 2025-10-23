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

/**
 * Servlet implementation class WishlistRegisterServlet
 */
@WebServlet("/WishlistRegisterServlet")
public class WishlistRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET: 登録フォームを表示
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Genre> genres = new GenreDAO().findAll();
        request.setAttribute("genres", genres);

        // 入力フォーム JSP にフォワード
        request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegister.jsp").forward(request, response);
    }

    // POST: 入力値を受け取り確認画面へ
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String step = request.getParameter("step");
        String title = request.getParameter("title");
        String[] genreIds = request.getParameterValues("genre");
        String memo = request.getParameter("memo");

        List<Genre> genres = new GenreDAO().findAll();

        request.setAttribute("title", title);
        request.setAttribute("genreIds", genreIds);
        request.setAttribute("memo", memo);
        request.setAttribute("genres", genres);

        if ("修正".equals(step)) {
            // 修正ボタンから戻ってきた場合 → 登録フォームへ
            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegister.jsp").forward(request, response);
        } else {
            // 通常の確認ボタン → 確認画面へ
            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistRegisterCheck.jsp").forward(request, response);
        }
    }

}