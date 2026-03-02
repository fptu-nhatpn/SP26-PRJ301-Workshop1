package controller;

import dao.AccountDAO;
import dto.Account;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * LoginServlet
 *  GET  /login  → show login.jsp
 *  POST /login  → authenticate; on success redirect to /private/dashboard
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

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

    // ── GET: show the login form ──────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // If already logged in, go straight to dashboard
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("loggedInUser") != null) {
            response.sendRedirect(request.getContextPath() + "/private/dashboard");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
               .forward(request, response);
    }

    // ── POST: process credentials ─────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("account");
        String password = request.getParameter("pass");

        EntityManager em = emf.createEntityManager();
        try {
            AccountDAO dao     = new AccountDAO(em);
            Account    account = dao.loginSuccess(username, password);

            if (account == null) {
                // Wrong credentials
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                       .forward(request, response);
                return;
            }

            if (!account.isIsUse()) {
                // Account deactivated
                request.setAttribute("errorMessage", "Your account has been deactivated.");
                request.getRequestDispatcher("/WEB-INF/views/public/login.jsp")
                       .forward(request, response);
                return;
            }

            // ── Success: store account in session ─────────────────────────
            HttpSession session = request.getSession(true);
            session.setAttribute("loggedInUser", account);

            response.sendRedirect(request.getContextPath() + "/private/dashboard");

        } finally {
            em.close();
        }
    }
}
