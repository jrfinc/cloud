package com.br.ideapp;

import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SubmitSubscriberServlet extends HttpServlet {

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        UserService userService = UserServiceFactory.getUserService();
        User user = userService.getCurrentUser();

        if (user == null) {
            resp.sendError(500,"Debe estar logeado para suscribirse al newsletter");
        } else {
            Subscriber suscriber = new Subscriber();
            suscriber.setMailAddress(user.getEmail());
            suscriber.setNickname(user.getNickname());
            ObjectifyService.ofy().save().entity(suscriber).now();
            String url = "/ideaLibrary.jsp";
            resp.sendRedirect(url);
        }

    }
}
