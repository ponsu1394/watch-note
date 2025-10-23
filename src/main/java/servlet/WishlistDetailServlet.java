package servlet;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.WishlistWork;
import service.WishlistLogic;

/**
 * Servlet implementation class WishlistDetailServlet
 */
@WebServlet("/WishlistDetailServlet")
public class WishlistDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private WishlistLogic logic = new WishlistLogic();

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
            WishlistWork work = logic.findById(id);

            if (work != null) {
                request.setAttribute("work", work);
                request.getRequestDispatcher("/WEB-INF/jsp/wishlist/wishlistDetail.jsp").forward(request, response);
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
        doGet(request, response);
    }
}
