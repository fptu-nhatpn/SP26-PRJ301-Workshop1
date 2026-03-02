package controller;

import dao.ProductDAO;
import dto.Product;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * ProductServlet
 *  GET /private/products               → list all products
 *  GET /private/products/delete?id=xx → delete, redirect back
 */
@WebServlet({"/private/products", "/private/products/delete"})
public class ProductServlet extends HttpServlet {

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
            ProductDAO dao = new ProductDAO(em);

            if (path.endsWith("/delete")) {
                String id = request.getParameter("id");
                Product p = dao.getObjectById(id);
                if (p != null) dao.deleteRec(p);
                response.sendRedirect(request.getContextPath() + "/private/products");
                return;
            }

            request.setAttribute("products", dao.listAll());
            request.getRequestDispatcher("/WEB-INF/views/private/products.jsp")
                   .forward(request, response);

        } finally {
            em.close();
        }
    }
}
