package servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.ViewedWork;
import service.ViewedLogic;
/**
 * Servlet implementation class ViewedDetailServlet
 */
@WebServlet("/ViewedDetailServlet")
public class ViewedDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	
	private ViewedLogic logic = new ViewedLogic();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
	        String idParam = request.getParameter("id");
	        if (idParam == null || idParam.isEmpty()) {
	            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "IDが指定されていません");
	            return;
	        }

	        int id = Integer.parseInt(idParam);
	        List<ViewedWork> works = logic.getAllViewedWorks();
	        ViewedWork target = null;
	        for (ViewedWork w : works) {
	            if (w.getId() == id) {
	                target = w;
	                break;
	            }
	        }

	        if (target != null) {
	            request.setAttribute("work", target);
	            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedDetail.jsp").forward(request, response);
	        } else {
	            response.sendError(HttpServletResponse.SC_NOT_FOUND, "指定された作品が見つかりません");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendError(HttpServletResponse.SC_BAD_REQUEST, "リクエストに問題があります");
	    }


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
