using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Descripción breve de Coneccion
/// </summary>
public class Coneccion
{
    public static String coneccionString = ConfigurationManager.ConnectionStrings["SQLSERVER"].ConnectionString;

    public static String SapDbQuinta = "[Quinta].[dbo]";
    public static String PracticaDbQuinta = "[ConfigERQuinta].[dbo]";

    public static String SapDbMaspan = "[Maspan].[dbo]";
    public static String PracticaDbMaspan = "[PracticaDb].[dbo]";
	
    /*Podria crear el objeto Coneccion y en el contructos ver como instanciar las bases de datos*/

	public Coneccion()
	{
	}
}
