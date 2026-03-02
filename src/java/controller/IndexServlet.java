package controller;

import dao.ProductDAO;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import dto.Product;

/**
 * IndexServlet
 *  GET /index  → show landing page with up to 6 featured products
 *  Also mapped to /  so it's the default page
 */
@WebServlet({"/index"})
public class IndexServlet extends HttpServlet {

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
            List<Product> all = new ProductDAO(em).listAll();
            // Show up to 6 featured products on the landing page
            List<Product> featured = all.size() > 6 ? all.subList(0, 6) : all;
            request.setAttribute("featuredProducts", featured);
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/WEB-INF/views/public/index.jsp")
               .forward(request, response);
    }
}
