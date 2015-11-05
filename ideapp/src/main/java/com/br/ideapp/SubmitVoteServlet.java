package com.br.ideapp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Created by matiii79 on 10/29/15.
 */
public class SubmitVoteServlet  extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        int voteNumber;
        Long ideaId;
        if (user == null) {
            resp.sendError(1,"NO HAY USUARIO LOGUEADO");
        } else {
            voteNumber = Integer.parseInt(req.getParameter("vote"));
            ideaId = new Long(req.getParameter("ideaId"));
            Vote vote = new Vote(ideaId, user.getNickname(), voteNumber);
            ObjectifyService.ofy().save().entity(vote).now();
            String url = "/ideaDetail.jsp?ideaId=" + ideaId;
            resp.sendRedirect(url);
        }

    }
}