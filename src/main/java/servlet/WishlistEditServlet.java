package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.GenreDAO;
import dao.WishlistWorkDAO;
import model.Genre;
import model.WishlistWork;

/**
 * Servlet implementation class ViewedEditServlet
 */
@WebServlet("/WishlistEditServlet")
public class WishlistEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        WishlistWorkDAO dao = new WishlistWorkDAO();
        WishlistWork work = dao.findById(id);
        List<Integer> genreIds = dao.findGenreIdsByWorkId(id);
        List<Genre> genres = new GenreDAO().findAll();

        request.setAttribute("work", work);
        request.setAttribute("genreIds", genreIds);
        request.setAttribute("genres", genres);

        request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistEdit.jsp").forward(request, response);
    }



	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String step = request.getParameter("step");
        
        if ("back".equals(step)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String memo = request.getParameter("memo");
            String[] genreIds = request.getParameterValues("genreIds");

            List<Genre> genres = new GenreDAO().findAll();

            WishlistWork work = new WishlistWork();
            work.setId(id);
            work.setTitle(title);
            work.setMemo(memo);

            request.setAttribute("work", work);
            request.setAttribute("genreIds", genreIds);
            request.setAttribute("genres", genres);

            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistEdit.jsp").forward(request, response);
            return;
        }

        if ("update".equals(step)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String memo = request.getParameter("memo");
            String[] genreIds = request.getParameterValues("genreIds");

            // 更新処理
            WishlistWork work = new WishlistWork();
            work.setId(id);
            work.setTitle(title);
            work.setMemo(memo);

            WishlistWorkDAO dao = new WishlistWorkDAO();
            dao.update(work);
            dao.updateGenreMapping(id, genreIds);

            // 完了画面へ遷移
            request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistEditDone.jsp").forward(request, response);
            return;
        }
    }


	}


