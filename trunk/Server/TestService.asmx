<%@ WebService Language="C#" Class="TestService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TestService  : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;
    
    public TestService ()
    {
    }
    
    [WebMethod]
    public string getConfiguration()
    {
        string config = "Configuracion\n";
        config += "\n\tconeccionString: " + coneccionString;
        config += "\n\tBase de Datos SAP: " + SAP;
        config += "\n\tBase de Datos configuracion ER: " + MAER;
        
        return config;
    }
}

