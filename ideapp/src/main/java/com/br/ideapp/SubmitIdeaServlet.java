package com.br.ideapp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

/**
 * Created by jr on 10/15/15.
 */
public class SubmitIdeaServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        String content;
        if (user == null) {
            resp.sendError(1, "NO HAY USUARIO LOGUEADO");
        } else {
            content = req.getParameter("content");
            if (content.isEmpty()) {
                resp.sendError(2, "Una idea no puede ser vacía");
            } else {
                Idea idea = new Idea();
                idea.setContent(content);
                idea.setAuthor_id(user.getNickname());
                idea.setDate(new Date());
                ObjectifyService.ofy().save().entity(idea).now();
                String url = "/ideaLibrary.jsp";
                resp.sendRedirect(url);
            }
        }

    }
}
