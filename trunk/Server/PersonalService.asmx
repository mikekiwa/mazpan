<%@ WebService Language="C#" CodeBehind="/App_Code/PersonalService.cs" Class="PersonalService" %>

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
    private string coneccionString = Coneccion.coneccionString;
    private string SAP = Coneccion.SapDbMaspan;
    private string MAER = Coneccion.PracticaDbMaspan;

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
    public DataTable allPersonal(Usuario u)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Personal";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM " + MAER + ".Personal WHERE planta='" + u.planta + "' AND rut!='00000000-0'";

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
        string query = " DELETE " + MAER + ".Personal WHERE rut='" + p.rut + "' ";
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
    public int addPersonal(Usuario u,Personal p)
    {
        string query = " INSERT INTO " + MAER + ".Personal (rut,nombres,apellidoPaterno,apellidoMaterno,planta,mayorista) VALUES ('" + p.rut + "','" + p.nombres + "','" + p.apellidoPaterno + "','" + p.apellidoMaterno + "','"+u.planta+"','"+p.mayorista+"') ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }


    /// <summary>
    /// Permite editar los datos del Personal
    /// retona 1 si la edicion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="nuevo">Datos del personal editado</param>
    /// <param name="actual">Copia datos viejos (ó actuales) del personal</param>
    /// <returns>1 si la edicion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int editPersonal(Personal nuevo, Personal actual)
    {
        string query = " UPDATE " + MAER + ".Personal SET rut='"+nuevo.rut+"', nombres='"+nuevo.nombres+"',apellidoPaterno='"+nuevo.apellidoPaterno+"',apellidoMaterno='"+nuevo.apellidoMaterno+"' WHERE rut='"+actual.rut+"' ";
        if (Ejecutar(query) == 1) return 1;
        else return 0;
    }

    public DataTable allPersonalMayorista(string local)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Personal";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM " + MAER + ".Personal WHERE mayorista='"+local+"'";

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


    //Este webMetodo es de uso exclusivo de este webService
    [WebMethod]
    public DataTable getLocales()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Locales";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT WhsCode,WhsName FROM " + SAP + ".[OWHS] WHERE location='4' ";
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

