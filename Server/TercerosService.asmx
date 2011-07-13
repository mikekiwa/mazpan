<%@ WebService Language="C#" CodeBehind="/App_Code/TercerosService.cs" Class="TercerosService" %>

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
[WebService(Namespace = "http://tempuri.org/Server/TercerosService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TercerosService : System.Web.Services.WebService
{
    private string coneccionString = ConeccionMaspan.coneccionStringSVRMASPAN;
    private string MAER = ConeccionMaspan.PracticaDb;


    public TercerosService ()
    {
        //Eliminar la marca de comentario de la línea siguiente si utiliza los componentes diseñados 
        //InitializeComponent(); 
    }

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">
    /// La consulta que se desea ejecutar
    /// </param>
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }

    /// <summary>
    /// Permite obtener los terceros en el sistema
    /// </summary>
    /// <returns>Lista de terceros en el sistema</returns>
    [WebMethod]
    public DataTable allTerceros()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Terceros";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM " + MAER + ".Terceros ";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }
   
    /// <summary>
    /// Permite insertar un nuevo tercero ó trabajador externo.
    /// retorna 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tercero que se desea agregar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addTercero(Tercero t)
    {
        string query = " INSERT INTO " + MAER + ".Terceros (nombre,direccion,fono,eMail) VALUES ('" + t.nombre + "','" + t.direccion + "','" + t.fono + "','" + t.eMail + "') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

    /// <summary>
    /// Permite eliminar un tercero ó trabajador externo.
    /// retorna 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tercero que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delTercero(Tercero t)
    {
        string query = " DELETE " + MAER + ".Terceros WHERE id='"+t.id+"' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite obtener los trabajos de terceros en el sistema
    /// </summary>
    /// <returns>Lista de trabajos de terceros en el sistema</returns>
    [WebMethod]
    public DataTable allTrabajosTerceros()
    {
        DataTable dt = new DataTable();
        dt.TableName = "TrabajosTerceros";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM " + MAER + ".TrabajoTerceros T1 JOIN " + MAER + ".Terceros T2 ON T1.agenteExterno=T2.id ";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }
    
    /// <summary>
    /// Permite insertar un nuevo trababo de tercero ó trababo de trabajador externo.
    /// retorna 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="tt">El trabajo de tercero que se desea agregar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addTrabajoTercero(TrabajoTercero tt)
    {
        string query = " INSERT INTO " + MAER + ".TrabajoTerceros (trabajo,costo,agenteExterno) VALUES ('"+tt.trabajo+"','"+tt.costo+"','"+tt.agenteExterno+"') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

    /// <summary>
    /// Permite eliminar un tercero ó trabajador externo.
    /// retorna 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tercero que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delTrabajoTercero(TrabajoTercero tt)
    {
        string query = " DELETE " + MAER + ".TrabajoTerceros WHERE id='" + tt.id + "' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

}

