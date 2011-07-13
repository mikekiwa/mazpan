<%@ WebService Language="C#" CodeBehind="/App_Code/FileService.cs" Class="FileService" %>

using System;
using System.Collections;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;
using System.Data.SqlClient;

using System.Collections.Generic;
using System.Text;
using System.Data.OleDb;

/// <summary>
/// Summary description for FileService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class FileService : System.Web.Services.WebService
{
    private string coneccionString = ConeccionMaspan.coneccionStringSVRMASPAN;
    private string MAER = ConeccionMaspan.PracticaDb;

    public FileService ()
    {
    }

    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
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
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }

    [WebMethod]
    public int readExcel(string nombre, string local, string ddmmaa, int largo)
    {
        /*string strConnnectionOle = @"Provider=Microsoft.Jet.OLEDB.4.0;" +
                                   @"Data Source=C:\Users\marcelo\Desktop\" + nombre + ";" +
                                   @"Extended Properties=" + '"' + "Excel 8.0;HDR=YES" + '"';*/

        string strConnnectionOle = @"Provider=Microsoft.Jet.OLEDB.4.0;" +
                                  @"Data Source=C:\Inetpub\wwwroot\EXCEL\" + nombre + ";" +
                                  @"Extended Properties=" + '"' + "Excel 8.0;HDR=YES" + '"';




        OleDbConnection oleConn = new OleDbConnection(strConnnectionOle);
        oleConn.Open();
        OleDbDataAdapter orden;
        DataSet dataset = new DataSet();

        OleDbCommand cmd = new OleDbCommand();
        cmd.Connection = oleConn;
        orden = new OleDbDataAdapter("SELECT [Número de artículo], [Descripción],[Cantidad acumulada],[Valor acumulado] FROM [Informe de auditoría de stocks$]", oleConn);

        orden.Fill(dataset, "[Hoja1$]");
        oleConn.Close();

        
        DateTime t = toDateTime(ddmmaa);
        string fecha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        Ejecutar("DELETE " + MAER + ".[StockSistema] WHERE fecha='"+fecha+"' and local='"+local+"'");

        foreach (DataRow row in dataset.Tables[0].Rows)
        {
            string cod = aString(row[0].ToString(), largo);
            string sql = " INSERT INTO " + MAER + ".[StockSistema] ([fecha],[local],[ItemCode],[total],[valorAcumulado]) "+
                         " VALUES ('"+fecha+"','"+local+"','"+cod+"','"+row[2]+"','"+row[3]+"')";
            if (existe(cod)) Ejecutar(sql);
        }
        //return dataset;
        return 1;
    }
    private string aString(string a, int largo)
    {
        for (int i = a.Length; i < largo; i++)
        {
            a = "0"+a;
        }
        return a;
    }
    private bool existe(string producto)
    {
        String query = "SELECT COUNT(*) FROM " + MAER + ".[Productos] WHERE producto = '" + producto + "'";
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
}

