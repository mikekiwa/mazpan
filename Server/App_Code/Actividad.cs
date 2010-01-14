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
/// Descripción breve de Actividad
/// </summary>
public class Actividad
{
    private string i;//id
    private string ia;//id actividad
    private string a;//actividad
    private string f;//frecuencia
    private string p;//planificada
    private string r;//realizada
    private string n;//nombre

    public Actividad()
    {
    }
    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    public string realizada
    {
        set { r = value; }
        get { return r; }
    }
    public string frecuencia
    {
        set { f = value; }
        get { return f; }
    }
    public string planificada
    {
        set { p = value; }
        get { return p; }
    }
    public string id
    {
        set { i=value; }
        get { return i; }
    }
    public string actividad
    {
        set { a = value; }
        get { return a; }
    }
    public string idActividad
    {
        set { ia = value; }
        get { return ia; }
    }
}
