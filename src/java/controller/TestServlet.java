package controller;

import dao.ProductDAO;
import dto.Product;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/test")
public class TestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        EntityManagerFactory emf = null;
        EntityManager em = null;

        try {
            emf = Persistence.createEntityManagerFactory("Workshop1.1PU");
            em = emf.createEntityManager();

            ProductDAO dao = new ProductDAO(em);
            List<Product> list = dao.listAll();

            out.println("JPA Connection Successful!");
            out.println("Total products: " + list.size());
            out.println("--------------------------------");

            for (Product p : list) {
                out.println(p.getProductId() + " - " + p.getProductName());
            }

        } catch (Exception e) {
            e.printStackTrace(out); // print error to browser
        } finally {
            if (em != null) em.close();
            if (emf != null) emf.close();
        }
    }
}