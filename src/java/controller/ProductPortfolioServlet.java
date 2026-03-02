package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dto.Category;
import dto.Product;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * ProductPortfolioServlet
 *  GET /portfolio             → show all products
 *  GET /portfolio?typeId=xx  → show products filtered by category
 */
@WebServlet("/portfolio")
public class ProductPortfolioServlet extends HttpServlet {

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
            ProductDAO  productDAO  = new ProductDAO(em);
            CategoryDAO categoryDAO = new CategoryDAO(em);

            List<Category> categories = categoryDAO.listAll();
            request.setAttribute("categories", categories);

            String typeIdStr = request.getParameter("typeId");
            if (typeIdStr != null && !typeIdStr.isEmpty()) {
                // Filtered by category
                int typeId = Integer.parseInt(typeIdStr);
                request.setAttribute("products",       productDAO.listByCategory(typeId));
                request.setAttribute("selectedTypeId", typeId);
            } else {
                // All products
                request.setAttribute("products", productDAO.listAll());
            }

        } finally {
            em.close();
        }

        request.getRequestDispatcher("/WEB-INF/views/public/productPortfolio.jsp")
               .forward(request, response);
    }
}
