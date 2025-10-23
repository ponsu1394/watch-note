package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import dao.ViewedWorkDAO;
import model.ViewedWork;

/**
 * Servlet implementation class ViewedDeleteServlet
 */
@WebServlet("/ViewedDeleteServlet")
public class ViewedDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewedDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));

        ViewedWorkDAO dao = new ViewedWorkDAO();
        ViewedWork work = dao.findById(id);

        // 中間テーブルのジャンル関連も先に削除（必要に応じて）
        dao.deleteGenreMapping(id);

        // 作品本体を削除
        dao.delete(id);

        //作品タイトルを取得
        request.setAttribute("title", work.getTitle());
        
        // 削除完了画面へフォワード
        request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedDeleted.jsp").forward(request, response);

    }


}
