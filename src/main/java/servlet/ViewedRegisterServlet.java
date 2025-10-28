package servlet;

import java.io.IOException;
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

@WebServlet("/ViewedRegisterServlet")
public class ViewedRegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Star> stars = new StarDAO().findAll();
        List<Genre> genres = new GenreDAO().findAll();

        request.setAttribute("stars", stars);
        request.setAttribute("genres", genres);

        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegister.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String step = request.getParameter("step");

        System.out.println("[ViewedRegisterServlet] POST received: step=" + step);

        if ("修正".equals(step)) {
            handleCorrection(request, response);
        } else {
            handleRegistration(request, response);
        }
    }

    private void handleCorrection(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String review = request.getParameter("review");
            String starIdStr = request.getParameter("starId");
            String[] genreIds = request.getParameterValues("genreIds");

            if (starIdStr == null || starIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "starId が空です");
                return;
            }

            int starId = Integer.parseInt(starIdStr);

            List<Star> stars = new StarDAO().findAll();
            List<Genre> genres = new GenreDAO().findAll();

            request.setAttribute("title", title);
            request.setAttribute("review", review);
            request.setAttribute("starId", starId);
            request.setAttribute("genreIds", genreIds);
            request.setAttribute("stars", stars);
            request.setAttribute("genres", genres);

            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegister.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "修正画面の表示に失敗しました");
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String title = request.getParameter("title");
            String review = request.getParameter("review");
            String starIdStr = request.getParameter("starId");
            String[] genreIds = request.getParameterValues("genreIds");

            if (starIdStr == null || starIdStr.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "starId が空です");
                return;
            }

            int starId = Integer.parseInt(starIdStr);

            ViewedWork work = new ViewedWork();
            work.setTitle(title);
            work.setStarId(starId);
            work.setReview(review);
            work.setUpdatedAt(java.time.LocalDateTime.now());

            ViewedWorkDAO dao = new ViewedWorkDAO();
            int workId = dao.insertAndGetId(work);

            if (genreIds != null) {
                for (String genreIdStr : genreIds) {
                    int genreId = Integer.parseInt(genreIdStr);
                    dao.insertGenreMapping(workId, genreId);
                }
            }

            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegisterDone.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "登録に失敗しました");
        }
    }
}

