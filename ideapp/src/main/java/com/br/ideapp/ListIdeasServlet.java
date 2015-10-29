package com.br.ideapp;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Created by jr on 10/15/15.
 */
public class ListIdeasServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //validar que el usuario este logueado.
        List<Idea> ideas = ObjectifyService.ofy().load().type(Idea.class).order("-date").list();

        req.setAttribute("ideas", ideas); // Will be available as ${products} in JSP
        req.getRequestDispatcher("ideaLibrary.jsp").forward(req, resp);

    }
}
