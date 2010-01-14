using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Descripción breve de WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class WebService : System.Web.Services.WebService
{

    private string coneccionString = Coneccion.coneccionString;
    public WebService () {

        //Eliminar la marca de comentario de la línea siguiente si utiliza los componentes diseñados 
        //InitializeComponent(); 
    }

    [WebMethod]
    public string HelloWorld(int dia, int mes, int año) {
        //DateTime t = new DateTime(año,mes,dia);

        //DateTime t2 = t.AddDays(7);
        
        
        //return t2 + "";
        DateTime now = DateTime.Now;

        return now.Day + "-"+now.Month+"-"+now.Year;
    }

    private string feriado()
    { 
    //URL
    //http://www.mininterior.gov.ar/servicios/wsferiados.asp
       /* 
        DateTime dt1 = DateTime.Today.AddMonths(-2);
        DateTime dt2 = DateTime.Today.AddMonths(2);
        WS.MyService svc = new WS.MyService();
        string feriadosXML = svc.FeriadosEntreFechasAsXml(dt1, true, dt2, true);
        return feriadosXML;*/
        return null;
    }

    [WebMethod]
    public String selectActividades()
    {
        String query = "SELECT iteracion,puestaMarcha FROM Componentes JOIN ActividadMantencionComponentes ON ActividadMantencionComponentes.codigo=componentes.codigo";

        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand selectUsuarios = new SqlCommand(query, conn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

        if (reader.Read())
        {
            String fechaString = reader.GetString(1);
            String[] fecha = fechaString.Split('/');
            int d = Convert.ToInt32(fecha[0]);
             
            int m = Convert.ToInt32(fecha[1]);

            int a = Convert.ToInt32(fecha[2]);

            DateTime t1 = new DateTime(a,m,d);
            DateTime t2 = DateTime.Today;
            //TimeSpan tf = t1 - t2;
            //float g= tf.Days;

            String f =  t1.Year+"-"+t1.Month+"-"+t1.Day;
            /*
            if(b.CompareTo(a1)>0)
            {
                b = "2009-12-18";
            }
            if (b.CompareTo(c) > 0)
            {
                b = "2009-12-18";
            }*/
        }
        return "";
    }
}

