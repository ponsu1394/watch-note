package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.GenreDAO;
import dao.StarDAO;
import model.Genre;
import model.Star;

@WebServlet("/ViewedRegisterCheckServlet")
public class ViewedRegisterCheckServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	System.out.println("=== ViewedRegisterCheckServlet POST START ===");
    	System.out.println("step=" + request.getParameter("step"));
    	
    	request.setCharacterEncoding("UTF-8");
        String step = request.getParameter("step");


        if ("修正".equals(step)) {
            // 入力フォームに戻す処理
            List<Star> stars = new StarDAO().findAll();
            List<Genre> genres = new GenreDAO().findAll();

            String title = request.getParameter("title");
            String review = request.getParameter("review");
            int starId = Integer.parseInt(request.getParameter("starId"));
            String[] genreIds = request.getParameterValues("genreIds");

            request.setAttribute("title", title);
            request.setAttribute("review", review);
            request.setAttribute("starId", starId);
            request.setAttribute("genreIds", genreIds);
            request.setAttribute("stars", stars);
            request.setAttribute("genres", genres);

            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegister.jsp").forward(request, response);
            return;
        }

        String title = request.getParameter("title");
        String review = request.getParameter("review");
        int starId = Integer.parseInt(request.getParameter("starId"));
        String[] genreIds = request.getParameterValues("genreIds");

        Star star = new StarDAO().findById(starId);
        List<Genre> allGenres = new GenreDAO().findAll();
        List<Genre> selectedGenres = new ArrayList<>();
        if (genreIds != null) {
            for (String id : genreIds) {
                int gid = Integer.parseInt(id);
                for (Genre g : allGenres) {
                    if (g.getId() == gid) {
                        selectedGenres.add(g);
                    }
                }
            }
        }

        request.setAttribute("title", title);
        request.setAttribute("review", review);
        request.setAttribute("star", star);
        request.setAttribute("genres", selectedGenres);

        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegisterCheck.jsp").forward(request, response);
    }
}