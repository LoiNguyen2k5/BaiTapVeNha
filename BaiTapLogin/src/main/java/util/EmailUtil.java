package util;

import java.util.Properties;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {
    public static void sendPasswordResetLink(String recipientEmail, String token, String contextPath) {
        // --- THAY THÔNG TIN CỦA BẠN VÀO ĐÂY ---
        final String fromEmail = "tiemnet.coaching.y3@gmail.com"; // Email của bạn
        final String password = "vbou spej epty ijlf"; // Mật khẩu ứng dụng của Gmail

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com"); // SMTP Host
        props.put("mail.smtp.port", "587"); // TLS Port
        props.put("mail.smtp.auth", "true"); // enable authentication
        props.put("mail.smtp.starttls.enable", "true"); // enable STARTTLS

        Authenticator auth = new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        Session session = Session.getInstance(props, auth);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(fromEmail));
            msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipientEmail));
            msg.setSubject("Yêu cầu khôi phục mật khẩu");

            String resetLink = "http://localhost:8080" + contextPath + "/reset-password?token=" + token;
            String emailContent = "Chào bạn,<br><br>"
                    + "Bạn đã yêu cầu khôi phục mật khẩu. Vui lòng bấm vào đường link dưới đây để đặt lại mật khẩu của bạn:<br>"
                    + "<a href=\"" + resetLink + "\">Đặt lại mật khẩu</a><br><br>"
                    + "Nếu bạn không yêu cầu điều này, vui lòng bỏ qua email này.<br><br>"
                    + "Trân trọng.";
            
            msg.setContent(emailContent, "text/html; charset=UTF-8");
            Transport.send(msg);
            System.out.println("Email sent successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}