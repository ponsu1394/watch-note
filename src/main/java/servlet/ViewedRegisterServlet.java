package servlet;

import java.io.IOException;
import java.time.LocalDateTime;
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
 * Servlet implementation class ViewedRegisterServlet
 */
@WebServlet("/ViewedRegisterServlet")
public class ViewedRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Star> stars = new StarDAO().findAll();
        List<Genre> genres = new GenreDAO().findAll();

        request.setAttribute("stars", stars);
        request.setAttribute("genres", genres);

        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegister.jsp").forward(request, response);


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String step = request.getParameter("step");

	    if ("修正".equals(step)) {
	        // 入力値を保持してフォームに戻す
	        String title = request.getParameter("title");
	        String review = request.getParameter("review");
	        int starId = Integer.parseInt(request.getParameter("starId"));
	        String[] genreIds = request.getParameterValues("genreIds");

	        List<Star> stars = new StarDAO().findAll();
	        List<Genre> genres = new GenreDAO().findAll();

	        request.setAttribute("title", title);
	        request.setAttribute("review", review);
	        request.setAttribute("starId", starId);
	        request.setAttribute("genreIds", genreIds);
	        request.setAttribute("stars", stars);
	        request.setAttribute("genres", genres);

	        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegisterDone.jsp").forward(request, response);
	        return;
	    }

		
		try {
	        // 1. 入力値を取得
	        String title = request.getParameter("title");
	        int starId = Integer.parseInt(request.getParameter("starId"));
	        String review = request.getParameter("review");

	        ViewedWork work = new ViewedWork();
	        work.setTitle(title);
	        work.setStarId(starId);
	        work.setReview(review);
	        work.setUpdatedAt(LocalDateTime.now());

	        // 2. 作品を登録して ID を取得
	        ViewedWorkDAO dao = new ViewedWorkDAO();
	        int workId = dao.insertAndGetId(work); // insert後にIDを返すメソッドを作る

	        // 3. ジャンルを受け取って中間テーブルに保存
	        String[] genreIds = request.getParameterValues("genreIds");
	        if (genreIds != null) {
	            for (String genreIdStr : genreIds) {
	                int genreId = Integer.parseInt(genreIdStr);
	                dao.insertGenreMapping(workId, genreId); // 中間テーブルに保存するメソッド
	            }
	        }

	        // 4. 完了後に一覧へリダイレクト
	        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedRegisterDone.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "登録に失敗しました");
	    }

	}

}
