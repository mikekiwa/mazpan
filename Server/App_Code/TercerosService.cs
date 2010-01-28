using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;


/// <summary>
/// Descripción breve de TercerosService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TercerosService : System.Web.Services.WebService
{

    public TercerosService ()
    {
        //Eliminar la marca de comentario de la línea siguiente si utiliza los componentes diseñados 
        //InitializeComponent(); 
    }

    [WebMethod]
    public DataTable allTerceros()
    {
        //SELECT * FROM Terceros T1 JOIN TrabajoTerceros T2 ON T1.id=T2.agenteExterno
        //INSERT INTO Terceros (nombre,direccion,fono,eMail) VALUES ('','','','')
        //INSERT INTO TrabajoTerceros (trabajo,costo,agenteExterno) VALUES ('','','1')
        return null;
    }
    [WebMethod]
    public DataTable addTercero(Tercero t)
    {
        //SELECT * FROM Terceros T1 JOIN TrabajoTerceros T2 ON T1.id=T2.agenteExterno
        //INSERT INTO Terceros (nombre,direccion,fono,eMail) VALUES ('','','','')
        //INSERT INTO TrabajoTerceros (trabajo,costo,agenteExterno) VALUES ('','','1')
        return null;
    }
    [WebMethod]
    public DataTable addTrabajoTercero()
    {
        //SELECT * FROM Terceros T1 JOIN TrabajoTerceros T2 ON T1.id=T2.agenteExterno
        //INSERT INTO Terceros (nombre,direccion,fono,eMail) VALUES ('','','','')
        //INSERT INTO TrabajoTerceros (trabajo,costo,agenteExterno) VALUES ('','','1')
        return null;
    }

    
}

