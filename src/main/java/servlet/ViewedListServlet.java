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
 * Servlet implementation class ViewedListServlet
 */


@WebServlet("/ViewedListServlet")
public class ViewedListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private ViewedLogic service = new ViewedLogic();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ViewedListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
            List<ViewedWork> works = service.getAllViewedWorks();
            
            System.out.println("取得件数: " + works.size());
            for (ViewedWork w : works) {
                System.out.println("タイトル: " + w.getTitle());
            }
            request.setAttribute("works", works);
            request.getRequestDispatcher("/WEB-INF/jsp/viewed/viewedList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
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
