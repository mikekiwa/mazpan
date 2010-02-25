using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Descripción breve de LocalesService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/LocalesService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class LocalesService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public LocalesService ()
    {
    }

    [WebMethod]
    public DataTable getLocales()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Locales";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName FROM [Maspan].[dbo].[OWHS] WHERE location='4' ";

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
    
    [WebMethod]
    public DataTable getSociosDe(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Socios";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName,CardName FROM [Pruebas Maspan].[dbo].[OWHS] T1 JOIN [Pruebas Maspan].[dbo].[OCRD] T2 ON T1.WhsCode=T2.U_LTrabj WHERE WhsCode='" + local + "' ";

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
}

