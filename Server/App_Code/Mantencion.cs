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
    private string i;//identificador
    private string c;//codigo
    private string a;//actividad
    private string f;//frecuencia
    private string m;//tipomantencion
    private string p;//fecha planificada
    private string r;//fecha realizada

	public Mantencion()
	{
	}
    public string id
    {
        set { i = value; }
        get { return i; }
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
    public string planificada
    {
        set { p = value; }
        get { return p; }
    }
    public string realizada
    {
        set { r = value; }
        get { return r; }
    }
}
