package controller;

import dao.CategoryDAO;
import dto.Category;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * CategoryServlet
 *  GET /private/categories                → list all categories
 *  GET /private/categories/delete?id=xx  → delete, redirect back
 */
@WebServlet({"/private/categories", "/private/categories/delete"})
public class CategoryServlet extends HttpServlet {

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

        String path = request.getServletPath();
        EntityManager em = emf.createEntityManager();
        try {
            CategoryDAO dao = new CategoryDAO(em);

            if (path.endsWith("/delete")) {
                String id = request.getParameter("id");
                Category c = dao.getObjectById(id);
                if (c != null) dao.deleteRec(c);
                response.sendRedirect(request.getContextPath() + "/private/categories");
                return;
            }

            request.setAttribute("categories", dao.listAll());
            request.getRequestDispatcher("/WEB-INF/views/private/categories.jsp")
                   .forward(request, response);

        } finally {
            em.close();
        }
    }
}
