using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de PersonalService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/PersonalService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class PersonalService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public PersonalService ()
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
    /// Permite obtener todo el personal en el sistema
    /// </summary>
    /// <returns>Lista de personal en el sistema</returns>
    [WebMethod]
    public DataTable allPersonal()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Personal";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM [PracticaDb].[dbo].Personal ";

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
    /// Permite eliminar personal.
    /// retorna 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El personal que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int delPersonal(Personal p)
    {
        string query = " DELETE [PracticaDb].[dbo].Personal WHERE rut='" + p.rut + "' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

    /// <summary>
    /// Permite insertar un nuevo personal
    /// retorna 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="t">El personal que se desea agregar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addPersonal(Personal p)
    {
        string query = " INSERT INTO [PracticaDb].[dbo].Personal (rut,nombres,apellidoPaterno,apellidoMaterno) VALUES ('" + p.rut + "','" + p.nombres + "','" + p.apellidoPaterno + "','" + p.apellidoMaterno + "') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

}

