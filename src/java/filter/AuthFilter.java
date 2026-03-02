package filter;

import dto.Account;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * AuthFilter - intercepts all requests to /private/*
 * Redirects unauthenticated users to /login
 * Restricts /private/accounts/* to admin only (role == 1)
 * Registered via web.xml only — no @WebFilter annotation.
 */
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // ewww... nothing to do here :( 
        // I should find something dedicated to place here later on
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse res  = (HttpServletResponse) response;
        HttpSession         session = req.getSession(false);

        String contextPath = req.getContextPath();
        String requestURI  = req.getRequestURI();

        // not logged in
        Account loggedIn = (session != null) ? (Account) session.getAttribute("loggedInUser") : null;

        if (loggedIn == null) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        // admin
        String privatePath = requestURI.substring(contextPath.length());
        if (privatePath.startsWith("/private/accounts") && loggedIn.getRoleInSystem() != 1) {
            // What's up homies, you're in :P
            res.sendRedirect(contextPath + "/private/dashboard");
            return;
        }

        // after all
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // once again, nothing to do :<
    }
}
