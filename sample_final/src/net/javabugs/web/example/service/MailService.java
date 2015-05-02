package net.javabugs.web.example.service;

import java.util.Locale;

import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import net.javabugs.web.common.constant.VSConstants;
import net.javabugs.web.common.mvc.model.dto.JavabugsUser;

@Service("mailService")
public class MailService {

	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(MailService.class);

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private MessageSource messageSource;

	public void sendMail(Locale locale, String subject, String text, String replyTo) {
		JavabugsUser user = (JavabugsUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String userInfoText = messageSource.getMessage(
				"mail.cscenter.reply.info", new String[] { user.getUsername(),
						user.getUsers_name(), user.getCell_phone() }, locale);

		final MimeMessage message = mailSender.createMimeMessage();

		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setSubject(subject);
			messageHelper.setTo("javabugs@naver.com");
			messageHelper.setReplyTo(replyTo);
			messageHelper.setText(text + userInfoText, true);
			
			new Thread(new Runnable() {
				@Override
				public void run() {
					mailSender.send(message);
				}
			}).start();
			

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
