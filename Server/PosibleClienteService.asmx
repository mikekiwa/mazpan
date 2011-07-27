<%@ WebService Language="C#" Class="PosibleClienteService" %>

using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;
using System.Text;
using System.Net;
using System.Net.Mime;
using System.Net.Mail;
using System.Web.Mail;

[WebService(Namespace = "http://tempuri.org/server/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class PosibleClienteService : System.Web.Services.WebService
{
    public static String coneccionString = Coneccion.coneccionStringSVRMASPAN;
    private string copia = "mespina1986@gmail.com";
    //private string catalogo = @"C:\Inetpub\wwwroot\catalogo.pdf";
    private string catalogo = @"C:\Documents and Settings\Isabel\Escritorio\catalogo.pdf";
    
    public PosibleClienteService ()
    {
    }

    [WebMethod]
    public int addPosibleCliente(string eMail,string nombre,string username,string password)
    {
		if(!exiteMail(eMail,username))
		{
			if(agregarPosibleCliente(eMail, nombre, username, password)==1)
			{
				System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();

                msg.From = new MailAddress("maspan.contacto@gmail.com", "Sistema", System.Text.Encoding.UTF8);

				msg.Subject = "Cuenta Documentos Maspan";
				msg.SubjectEncoding = System.Text.Encoding.UTF8;

				msg.IsBodyHtml = false;

				msg.To.Add(eMail);

                msg.Body = "Bienvenido a nuestro sistema de documentos, mediante esta cuenta de correos electronica podrá obtener nuestros catalogos.\n\n" +
                           "Sus datos de accesos son:\n" +
                           "       Nombre de usuario: " + username + "\n" +
                           "       Contraseña:	      " + password + "\n" +
                           "\n\nPara acceder a nuestro catalogo dirijase en:\n" +
                           "       http://maspan.cl/   y luego ingrese a la opción de catalogos\n" +
                           "O dirijase a la pagina:\n" +
                           "       http://maspan.cl/pages/catalogo.html\n\n" +
                           "A continuación ingrese sus datos de usuario.\n" +
                           "\n\nBuena Suerte.\n\n--\n" +
                           "Esta es una respuesta automatizada, no envia consultas a este correo, por favor visite: http://maspan.cl/pages/contactos.html\n";
                           
		        
				SmtpClient client = new SmtpClient();

				client.Credentials = new System.Net.NetworkCredential("maspan.contacto@gmail.com", "maspan2010");

				client.Port = 587;

				client.Host = "smtp.gmail.com";

				client.EnableSsl = true;

				try
				{
					client.Send(msg);
                    enviarCopia(eMail, nombre, 1);
					return 1;
				}
				catch (System.Net.Mail.SmtpException ex)
				{
					return 0;
				}
			}
			else
			{
				return 3;//imposible crear el usuario
			}
		}
		else
		{
			return 2;//email ya esta registrado
		}
    }
    private void enviarCopia(string eMail, string nombre, int origen)
    {
        System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();

        msg.From = new MailAddress("maspan.contacto@gmail.com", "Sistema", System.Text.Encoding.UTF8);

        msg.Subject = "Posible Cliente Maspan";
        msg.SubjectEncoding = System.Text.Encoding.UTF8;

        msg.IsBodyHtml = false;

        msg.To.Add(copia);

        if(origen==1)
        {
            msg.Body = "Aviso:\n\n" + 
                       "Se ha registrado '" + nombre + "' para descargar catalogos desde http://maspan.cl/pages/catalogo.html\n" +
                       "Su correo electronico es: " + eMail + "\n" +
                       "\n\n--\nEste es un mensaje automatizado, favor no responder.";
        }
        else
        {
            msg.Body = "Aviso:\n\n" +
                       "'" + nombre + "' descargo una copia del catalogo desde http://maspan.cl/pages/catalogo.html\n" +
                       "Su correo electronico es: " + eMail + "\n" +
                       "\n\n--\nEste es un mensaje automatizado, favor no responder.";
        }

        SmtpClient client = new SmtpClient();

        client.Credentials = new System.Net.NetworkCredential("maspan.contacto@gmail.com", "maspan2010");

        client.Port = 587;

        client.Host = "smtp.gmail.com";

        client.EnableSsl = true;

        try
        {
            client.Send(msg);
        }
        catch (System.Net.Mail.SmtpException ex)
        {
            
        }
    }
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
            return 1;
        }
        catch
        {
            conn.Close();
            return 0;
        }
    }
    public int agregarPosibleCliente(string eMail,string nombre,string username,string password)
    {
		string sql = " INSERT INTO [PracticaDb].[dbo].[PosibleCliente]([correo],[nombre],[username],[password]) "+
				     " VALUES ('"+eMail+"', '"+nombre+"','"+username+"','"+password+"') ";
		return Ejecutar(sql); 
    }
    public bool exiteMail(string eMail,string user)
    {
		String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[PosibleCliente] WHERE correo = '" + eMail + "' AND userName='"+user+"'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }
    [WebMethod]
    public Usuario existe(string username,string password)
    {
		SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        String query = "SELECT nombre,correo FROM [PracticaDb].[dbo].[PosibleCliente] WHERE userName='" + username + "' AND password='" + password + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            Usuario u = new Usuario();
            u.pass = password;
            u.user = username;
            u.nombre = reader.GetString(0);
            u.eMail = reader.GetString(1);
            return u;
        }
        return null;
    }

    [WebMethod]
    public int enviarCatalogo(string eMail, string nombre)
    {
        System.Net.Mail.MailMessage msg = new System.Net.Mail.MailMessage();

        msg.From = new MailAddress("maspan.contacto@gmail.com", "Sistema", System.Text.Encoding.UTF8);

        msg.Subject = "Cuenta Documentos Maspan";
        msg.SubjectEncoding = System.Text.Encoding.UTF8;

        msg.IsBodyHtml = false;

        msg.To.Add(eMail);
        msg.Attachments.Add(new Attachment(catalogo));

        msg.Body = "Bienvenido a nuestro sistema de documentos, se adjunto una copia del catalogo\n" +
                   "\n\nBuena Suerte.\n\n--\n" +
                   "Esta es una respuesta automatizada, no envia consultas a este correo, por favor visite: http://maspan.cl/pages/contactos.html\n";


        SmtpClient client = new SmtpClient();

        client.Credentials = new System.Net.NetworkCredential("maspan.contacto@gmail.com", "maspan2010");

        client.Port = 587;

        client.Host = "smtp.gmail.com";

        client.EnableSsl = true;

        client.Timeout = 0;

        try
        {
            client.Send(msg);
            enviarCopia(eMail, nombre, 2);
            return 1;
        }
        catch (System.Net.Mail.SmtpException ex)
        {
            return 0;
        }
    }
}