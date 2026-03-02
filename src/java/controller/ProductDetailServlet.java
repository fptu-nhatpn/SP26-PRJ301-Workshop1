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
 * ProductDetailServlet
 *  GET /product?id=xx → show single product detail page
 */
@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

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
        if (id == null || id.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/portfolio");
            return;
        }

        EntityManager em = emf.createEntityManager();
        try {
            Product p = new ProductDAO(em).getObjectById(id);
            if (p == null) {
                response.sendRedirect(request.getContextPath() + "/portfolio");
                return;
            }
            request.setAttribute("product", p);
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/WEB-INF/views/public/productDetail.jsp")
               .forward(request, response);
    }
}
