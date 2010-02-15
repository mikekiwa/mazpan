using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de PlantaService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class PlantaService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public PlantaService ()
    {
    }

    [WebMethod]
    public DataTable allPlantas()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Plantas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM [PracticaDb].[dbo].[Planta]";

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
    /// Recive una cadana de texto con formato dd/mm/aaaa y la lleva a un DateTime
    /// </summary>
    /// <param name="fecha">Cadana de texto con formato dd/mm/aaaa</param>
    /// <returns>Fecha como un tipo DateTime</returns>
    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
    }
    

    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos de la planta
    ///        -2 si no se puede insertar especificaciones de la planta
    ///        -3 si no se puede insertar mantenciones de la planta
    ///        -4 si no se puede insertar actividades de mantencion de la planta
    ///        -5 si no se puede insertar los componentes de la planta
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addPlanta(Planta p)
    {
        DateTime t = toDateTime(p.puestaMarcha);
        string puestaMarcha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        String query = " INSERT INTO [PracticaDb].[dbo].[Planta](codigo,nombre,puestaMarcha,encargado,descripcion) " +
                       " VALUES('" + p.codigo + "','" + p.nombre + "','" + puestaMarcha + "','" + p.encargado + "','" + p.descripcion + "') ";

        if (Ejecutar(query) == 1)return 1;
        else return -1;
    }


    /// <summary>
    /// Elimina una Planta
    /// return 1 sí la eliminación fue exitosa, 0 EOC
    /// </summary>
    /// <param name="codigo">Planta que se desea eliminar</param>
    /// <returns>1 sí la eliminación fue exitosa, 0 EOC</returns>
    [WebMethod(Description = "Elimina un Elemento por codigo")]
    public int delElemento(Planta p)
    {
        String query = "DELETE FROM [PracticaDB].[dbo].[Planta] WHERE codigo='" + p.codigo + "'";
        int result = Ejecutar(query);

        if (result == 1) return 1;
        else return 0;
    }

}

