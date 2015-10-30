package com.br.ideapp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by matiii79 on 10/29/15.
 */
public class SubmitCommentServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();

        String content;
        Long ideaId;
        if (user == null) {
            resp.sendError(1,"NO HAY USUARIO LOGUEADO");
        } else {
            content = req.getParameter("content");
            ideaId = new Long(req.getParameter("ideaId"));
            Key<Idea> ideaKey = Key.create(Idea.class, ideaId);
            Comment comment = new Comment();
            comment.setAuthor_id(user.getUserId());
            comment.setContent(content);
            comment.setParentKey(ideaKey);
            ObjectifyService.ofy().save().entity(comment).now();
            String url = "/ideaDetail.jsp?ideaId=" + ideaId;
            resp.sendRedirect(url);
        }

    }
}
