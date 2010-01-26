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
    private string a;//actividad
    private string f;//frecuencia
    private string m;//tipo mantencion
    private string p;//fecha planificada
    private string r;//fecha realizada
    private string c;//codigo, esto es usado unicamente

	public Mantencion()
	{
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
    public string frecuencia
    {
        set { f = value; }
        get { return f; }
    }


    //Estos datos son para rescar las mantenciones de la BD
    public string id
    {
        set { i = value; }
        get { return i; }
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
    public string codigo
    {
        set { c = value; }
        get { return c; }
    }
}
