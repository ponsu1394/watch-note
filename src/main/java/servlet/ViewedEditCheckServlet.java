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

@WebServlet("/ViewedEditCheckServlet")
public class ViewedEditCheckServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // 入力値を取得
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int starId = Integer.parseInt(request.getParameter("starId"));
        String review = request.getParameter("review");
        String[] genreIds = request.getParameterValues("genreIds");

        // 評価ラベルを取得
        Star star = new StarDAO().findById(starId);

        // 選択されたジャンル名を取得
        List<Genre> allGenres = new GenreDAO().findAll();
        List<Genre> selectedGenres = new ArrayList<>();
        if (genreIds != null) {
            for (String gid : genreIds) {
                int genreId = Integer.parseInt(gid);
                for (Genre genre : allGenres) {
                    if (genre.getId() == genreId) {
                        selectedGenres.add(genre);
                    }
                }
            }
        }

        // 表示用にセット
        request.setAttribute("id", id);
        request.setAttribute("title", title);
        request.setAttribute("review", review);
        request.setAttribute("star", star);
        request.setAttribute("genres", selectedGenres);
        request.setAttribute("genreIds", genreIds); // hidden用に再利用
        request.setAttribute("starId", starId);     // hidden用に再利用

        // 確認画面へフォワード
        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedEditCheck.jsp").forward(request, response);
    }
}

