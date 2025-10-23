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
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 入力値を取得
        String title = request.getParameter("title");
        String review = request.getParameter("review");
        int starId = Integer.parseInt(request.getParameter("starId"));
        String[] genreIds = request.getParameterValues("genreIds");

        // 評価ラベルを取得
        Star star = new StarDAO().findById(starId);

        // 選択されたジャンル名を取得
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

        // 表示用にセット
        request.setAttribute("title", title);
        request.setAttribute("review", review);
        request.setAttribute("star", star);
        request.setAttribute("genres", selectedGenres);

        // 確認画面へ
        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegisterCheck.jsp").forward(request, response);
    }
}