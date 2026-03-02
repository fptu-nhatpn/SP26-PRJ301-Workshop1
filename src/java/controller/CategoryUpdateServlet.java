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
 * CategoryUpdateServlet
 *  GET  /private/categories/update         → empty add form
 *  GET  /private/categories/update?id=xx  → pre-filled edit form
 *  POST /private/categories/update         → insert or update
 */
@WebServlet("/private/categories/update")
public class CategoryUpdateServlet extends HttpServlet {

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

        String id = request.getParameter("id");
        if (id != null) {
            EntityManager em = emf.createEntityManager();
            try {
                request.setAttribute("category", new CategoryDAO(em).getObjectById(id));
            } finally {
                em.close();
            }
        }
        request.getRequestDispatcher("/WEB-INF/views/private/categoryUpdate.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String typeIdStr     = request.getParameter("typeId"); // null on add
        String categoryName  = request.getParameter("categoryName");
        String memo          = request.getParameter("memo");

        EntityManager em = emf.createEntityManager();
        try {
            CategoryDAO dao = new CategoryDAO(em);

            if (typeIdStr == null || typeIdStr.isEmpty()) {
                // ── INSERT ──────────────────────────────────────────────
                Category c = new Category();
                c.setCategoryName(categoryName);
                c.setMemo(memo);
                dao.insertRec(c);
            } else {
                // ── UPDATE ──────────────────────────────────────────────
                Category c = dao.getObjectById(typeIdStr);
                if (c != null) {
                    c.setCategoryName(categoryName);
                    c.setMemo(memo);
                    dao.updateRec(c);
                }
            }

            response.sendRedirect(request.getContextPath() + "/private/categories");

        } finally {
            em.close();
        }
    }
}
