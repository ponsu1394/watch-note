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

@WebServlet("/WishlistEditCheckServlet")
public class WishlistEditCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String memo = request.getParameter("memo");
        String[] genreIds = request.getParameterValues("genreIds");

        List<Genre> genres = new GenreDAO().findAll();

        request.setAttribute("id", id);
        request.setAttribute("title", title);
        request.setAttribute("memo", memo);
        request.setAttribute("genreIds", genreIds);
        request.setAttribute("genres", genres);

        request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistEditCheck.jsp").forward(request, response);
    }

}

