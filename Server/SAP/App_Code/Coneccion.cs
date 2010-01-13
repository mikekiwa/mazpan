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
    //public static String coneccionStringSVRMASPAN = @"Data Source=SVR-MASPAN;Integrated Security=false;User='sa';Password='1234'";
    //public static String coneccionStringSVRMASPAN2 = @"Data Source=SVR-MASPAN2;Initial Catalog='PracticaDB';Integrated Security=false;User='sa';Password='1234'";

    public static String coneccionStringSVRMASPAN = ConfigurationManager.ConnectionStrings["SQLSERVER2005"].ConnectionString;

	public Coneccion()
	{
	}
}
