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
/// Descripción breve de Planta
/// </summary>
public class Planta
{
    private string c;//codigo
    private string n;//nombre
    private string d;//descripcion
    private string e;//encargado

	public Planta()
	{
	}
    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }
    public string encargado
    {
        set { e = value; }
        get { return e; }
    }
}
