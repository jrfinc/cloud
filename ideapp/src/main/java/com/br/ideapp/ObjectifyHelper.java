package com.br.ideapp;

import com.googlecode.objectify.ObjectifyService;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Created by jr on 10/15/15.
 */
public class ObjectifyHelper implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ObjectifyService.register(Idea.class);
        ObjectifyService.register(Comment.class);
        ObjectifyService.register(Vote.class);
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {
    }
}
