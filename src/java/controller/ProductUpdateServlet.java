package controller;

import dao.AccountDAO;
import dao.CategoryDAO;
import dao.ProductDAO;
import dto.Account;
import dto.Category;
import dto.Product;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * ProductUpdateServlet
 *  GET  /private/products/update         → empty add form
 *  GET  /private/products/update?id=xx  → pre-filled edit form
 *  POST /private/products/update         → insert or update (with optional image upload)
 */
@WebServlet("/private/products/update")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,      // 1MB before writing to disk
    maxFileSize       = 5 * 1024 * 1024,  // 5MB max per file
    maxRequestSize    = 10 * 1024 * 1024  // 10MB max request
)
public class ProductUpdateServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf;

    // Folder inside the web app root where images are saved
    private static final String IMAGE_DIR = "uploads/products";

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("Workshop1.1PU");
    }

    @Override
    public void destroy() {
        if (emf != null) emf.close();
    }

    // ── GET ──────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        try {
            // Always load dropdowns
            request.setAttribute("categories", new CategoryDAO(em).listAll());
            request.setAttribute("accounts",   new AccountDAO(em).listAll());

            String id = request.getParameter("id");
            if (id != null) {
                request.setAttribute("product", new ProductDAO(em).getObjectById(id));
            }
        } finally {
            em.close();
        }

        request.getRequestDispatcher("/WEB-INF/views/private/productUpdate.jsp")
               .forward(request, response);
    }

    // ── POST ─────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String originalId  = request.getParameter("originalProductId"); // null on add
        String productId   = request.getParameter("productId");
        String productName = request.getParameter("productName");
        String brief       = request.getParameter("brief");
        String dateStr     = request.getParameter("postedDate");
        String typeIdStr   = request.getParameter("typeId");
        String accountId   = request.getParameter("accountId");
        String unit        = request.getParameter("unit");
        int    price       = Integer.parseInt(request.getParameter("price"));
        int    discount    = Integer.parseInt(request.getParameter("discount"));

        Date postedDate = null;
        try {
            postedDate = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
        } catch (Exception e) { /* leave null */ }

        EntityManager em = emf.createEntityManager();
        try {
            ProductDAO  productDAO  = new ProductDAO(em);
            CategoryDAO categoryDAO = new CategoryDAO(em);
            AccountDAO  accountDAO  = new AccountDAO(em);

            Category category = categoryDAO.getObjectById(typeIdStr);
            Account  account  = accountDAO.getObjectById(accountId);

            // ── Handle image upload ──────────────────────────────────────
            String imagePath = null;
            Part filePart = request.getPart("productImageFile");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName    = getFileName(filePart);
                String uploadDir   = getServletContext().getRealPath("") + File.separator + IMAGE_DIR;
                new File(uploadDir).mkdirs();
                filePart.write(uploadDir + File.separator + fileName);
                imagePath = IMAGE_DIR + "/" + fileName;
            }

            if (originalId == null) {
                // ── INSERT ──────────────────────────────────────────────
                Product p = new Product(productId, productName,
                        imagePath != null ? imagePath : "",
                        brief, postedDate, account, category, unit, price, discount);
                int result = productDAO.insertRec(p);
                if (result == 0) {
                    forwardWithError(request, response, em,
                            "Failed to add product. ID may already exist.");
                    return;
                }
            } else {
                // ── UPDATE ──────────────────────────────────────────────
                Product p = productDAO.getObjectById(originalId);
                if (p == null) {
                    response.sendRedirect(request.getContextPath() + "/private/products");
                    return;
                }
                p.setProductName(productName);
                p.setBrief(brief);
                p.setPostedDate(postedDate);
                p.setType(category);
                p.setAccount(account);
                p.setUnit(unit);
                p.setPrice(price);
                p.setDiscount(discount);
                if (imagePath != null) p.setProductImage(imagePath); // keep old if no new upload
                productDAO.updateRec(p);
            }

            response.sendRedirect(request.getContextPath() + "/private/products");

        } finally {
            em.close();
        }
    }

    // ── Helpers ──────────────────────────────────────────────────────────

    private String getFileName(Part part) {
        for (String cd : part.getHeader("content-disposition").split(";")) {
            if (cd.trim().startsWith("filename")) {
                return cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "upload_" + System.currentTimeMillis();
    }

    private void forwardWithError(HttpServletRequest request,
                                  HttpServletResponse response,
                                  EntityManager em,
                                  String message) throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.setAttribute("categories", new CategoryDAO(em).listAll());
        request.setAttribute("accounts",   new AccountDAO(em).listAll());
        request.getRequestDispatcher("/WEB-INF/views/private/productUpdate.jsp")
               .forward(request, response);
    }
}
