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
    public static String coneccionString = @"Data Source=MARCELO-NETBOOK\SQLEXPRESS;Initial Catalog='Mantencion';Integrated Security=false;User='mazpan';Password='heman'";

	public Coneccion()
	{
	}
}
