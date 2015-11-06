package com.br.ideapp;

import com.google.appengine.api.utils.SystemProperty;
import com.googlecode.objectify.ObjectifyService;
import com.sun.jndi.cosnaming.IiopUrl;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

public class NewsletterServlet extends HttpServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        InternetAddress from = new InternetAddress("noreply@ideapp-2015.appspotmail.com", "Ideapp") ;

        Properties props = new Properties();
        String host = "smtp.google.com";
        props.put("mail.host", host);
        props.put("mail.transport.protocol", "smtp");

        // Get the Session object.
        Session session = Session.getDefaultInstance(props);

        String msgBody = getEmailBody();

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(from);
            addRecipients(msg);
            msg.setSubject("Mejores ideas de la semana");
            msg.setText(msgBody);
            Transport.send(msg);
        } catch (AddressException e) {
            resp.sendRedirect("address");
        } catch (MessagingException e) {
            resp.sendRedirect(e.getMessage());
        }

    }

    private String getEmailBody() {
        String body = "Las mejores ideas de esta semana son: \n\n";
        List<Idea> bestIdeas = ObjectifyService.ofy().load().type(Idea.class).order("-score").limit(3).list();
        for (Idea idea : bestIdeas) {
            body+="- " + idea.getContent() + " - " + idea.getAuthor_id() + "\n";
        }

        return body;
    }

    private void addRecipients(Message msg) throws UnsupportedEncodingException, MessagingException {
        List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();
        for (Subscriber s : subscribers) {
            msg.addRecipient(Message.RecipientType.BCC, new InternetAddress(s.getMailAddress(), s.getNickname()));
        }

    }
}