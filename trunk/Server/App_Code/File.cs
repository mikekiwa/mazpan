using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

using System.Collections.Generic;
using System.Text;
using System.Data.OleDb;

/// <summary>
/// Summary description for File
/// </summary>
public class File
{
	public File()
	{
	}
    public void GetExcel(string filename, string sheetName)
    {
        OleDbConnection dbConn = null;
        DataTable resultTable = new DataTable(sheetName);
        // Build connection string.
        string connString = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                            "Data Source=" + filename + ";" + 
                            "Extended Properties=Excel 8.0;";

        // Create connection and open it.
        dbConn = new OleDbConnection(connString);
        dbConn.Open();

        if (!sheetName.EndsWith("$"))
        {
            sheetName += '$';
        }
        string query = string.Format("SELECT * FROM [{0}]", sheetName);
        using (OleDbDataAdapter adapter = new OleDbDataAdapter(query, dbConn))
        {
            adapter.Fill(resultTable);
        }

        foreach (DataColumn a in resultTable.Columns)
        {
            Console.WriteLine(a.DataType.ToString() + " " + a.ToString());
        }
    }
    public DataSet getExcel2(string nombre)
    {
        string strConnnectionOle = @"Provider=Microsoft.Jet.OLEDB.4.0;" +
                                   @"Data Source=C:\Users\marcelo\Desktop\" + nombre + ";" +
                                   @"Extended Properties=" + '"' + "Excel 8.0;HDR=YES" + '"';
        OleDbConnection oleConn = new OleDbConnection(strConnnectionOle);
        oleConn.Open();
        OleDbDataAdapter orden;
        DataSet tabla = new DataSet();

        OleDbCommand cmd = new OleDbCommand();
        cmd.Connection = oleConn;
        orden = new OleDbDataAdapter("SELECT * FROM [Informe de auditoría de stocks$]", oleConn);
        
        orden.Fill(tabla, "[Hoja1$]");
        oleConn.Close();

        return tabla;
    }
}
