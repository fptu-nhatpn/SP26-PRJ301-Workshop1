package controller;

import dao.AccountDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * DashboardServlet
 *  GET /private/dashboard → show dashboard.jsp with summary counts
 */
@WebServlet("/private/dashboard")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("Workshop1.1PU");
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        try {
            request.setAttribute("totalAccounts",   new AccountDAO(em).listAll().size());
            request.setAttribute("totalCategories", new CategoryDAO(em).listAll().size());
            request.setAttribute("totalProducts",   new ProductDAO(em).listAll().size());
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/WEB-INF/views/private/dashboard.jsp")
               .forward(request, response);
    }
}
