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
/// Descripción breve de Mantencion
/// </summary>
public class Mantencion
{
    private string c;//codigo
    private string a;//actividad
    private string f;//frecuencia
    private string m;//mantencion

	public Mantencion()
	{
	}

    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
    public string frecuencia
    {
        set { f = value; }
        get { return f; }
    }
    public string actividad
    {
        set { a = value; }
        get { return a; }
    }
    public string mantencion
    {
        set { m = value; }
        get { return m; }
    }
}
