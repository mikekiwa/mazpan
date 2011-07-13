<%@ WebService Language="C#" CodeBehind="/App_Code/TecnicoService.cs" Class="TecnicoService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de TecnicoService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/TecnicoService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TecnicoService : System.Web.Services.WebService
{
    private string coneccionString = ConeccionMaspan.coneccionStringSVRMASPAN;
    private string MAER = ConeccionMaspan.PracticaDb;


    public TecnicoService ()
    { 
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
    /// Permite obtener todos los tecnicos en el sistema
    /// </summary>
    /// <returns>Lista de tecnicos en el sistema</returns>
    [WebMethod]
    public DataTable allTecnicos(Usuario u)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Tecnicos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT T1.*, T2.id,T2.especialidad,T2.otro FROM " + MAER + ".Personal T1 JOIN " + MAER + ".Tecnico T2 ON T1.rut=T2.rutTecnico WHERE T1.planta='"+u.planta+"'";

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
    /// Permite eliminar tecnico.
    /// retorna 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tecnico que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delTecnico(Tecnico t)
    {
        string query = " DELETE " + MAER + ".Tecnico WHERE id='" + t.id + "' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite insertar un nuevo tecnico
    /// retorna 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El tecnico que se desea agregar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addTecnico(Tecnico t)
    {
        string query = " INSERT INTO " + MAER + ".Tecnico (especialidad,rutTecnico,otro) VALUES ('"+t.especialidad+"','"+t.rutTecnico+"','"+t.otro+"') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite editar los datos de un Técnico
    /// retona 1 si la edicion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="nuevo">Datos del técnico editado</param>
    /// <param name="actual">Copia datos viejos (ó actuales) del técnico</param>
    /// <returns>1 si la edicion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int editTecnico(Tecnico nuevo, Tecnico actual)
    {
        string query = " UPDATE " + MAER + ".Tecnico SET especialidad='"+nuevo.especialidad+"',otro='"+nuevo.otro+"' WHERE rutTecnico='"+actual.rutTecnico+"' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }
}

