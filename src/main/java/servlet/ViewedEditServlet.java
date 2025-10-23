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
import dao.ViewedWorkDAO;
import model.Genre;
import model.Star;
import model.ViewedWork;

/**
 * Servlet implementation class ViewedEditServlet
 */
@WebServlet("/ViewedEditServlet")
public class ViewedEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        ViewedWorkDAO dao = new ViewedWorkDAO();
        ViewedWork work = dao.findById(id); // 作品情報を取得
        List<Genre> allGenres = new GenreDAO().findAll();
        List<Star> stars = new StarDAO().findAll();
        List<Integer> genreIds = dao.findGenreIdsByWorkId(id); // 中間テーブルからジャンルID取得

        request.setAttribute("work", work);
        request.setAttribute("stars", stars);
        request.setAttribute("genres", allGenres);
        request.setAttribute("genreIds", genreIds);

        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedEdit.jsp").forward(request, response);
    }


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String step = request.getParameter("step");

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        int starId = Integer.parseInt(request.getParameter("starId"));
        String review = request.getParameter("review");
        String[] genreIds = request.getParameterValues("genreIds");

        if ("back".equals(step)) {
            // 編集画面に戻す処理
            ViewedWork work = new ViewedWork();
            work.setId(id);
            work.setTitle(title);
            work.setStarId(starId);
            work.setReview(review);

            List<Genre> allGenres = new GenreDAO().findAll();
            List<Star> stars = new StarDAO().findAll();

            List<Integer> selectedGenreIds = new ArrayList<>();
            if (genreIds != null) {
                for (String gid : genreIds) {
                    selectedGenreIds.add(Integer.parseInt(gid));
                }
            }

            request.setAttribute("work", work);
            request.setAttribute("stars", stars);
            request.setAttribute("genres", allGenres);
            request.setAttribute("genreIds", selectedGenreIds);

            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedEdit.jsp").forward(request, response);
            return;
        }

        if ("update".equals(step)) {
            // 更新処理
            ViewedWork work = new ViewedWork();
            work.setId(id);
            work.setTitle(title);
            work.setStarId(starId);
            work.setReview(review);
            work.setUpdatedAt(java.time.LocalDateTime.now());

            ViewedWorkDAO dao = new ViewedWorkDAO();
            dao.update(work);
            dao.updateGenreMapping(id, genreIds);

            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedEditDone.jsp").forward(request, response);

            return;
        }

        // stepが指定されていない場合はエラー
        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "不正な操作です");
    }

	}


