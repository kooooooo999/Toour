package toour.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.util.Properties;

public class EmailUtil {

    public static void sendAuthEmail(String recipient, String authCode) throws MessagingException {
        String host = "smtp.gmail.com";
        String port = "587";
        String senderEmail = "toour250822@gmail.com";//회사 이메일 주소
        String senderPassword = "fehlmwnbqklirjzm";  // 앱 비밀번호 (절대 계정 비번 아님)
        System.out.println("host:"+host);
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", port);

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, senderPassword);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipient));
        message.setSubject("회원가입 이메일 인증");
        message.setText("인증번호는 다음과 같습니다: " + authCode);

        Transport.send(message);
    }
}
