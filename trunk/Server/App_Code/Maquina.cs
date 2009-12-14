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
/// Descripción breve de Maquina
/// </summary>
public class Maquina
{
    private string c;//codigo
    private string t;//tipo
    private string pm;//puesta en marcha
    private string n;//nombre
    private string u;//ubicacion
    private string p;//planta
    private string e;//estado
    private string cr;//condicion de recepcion
    private string cost;//costo
    private string hvu;//horas vida util
    private string ha;//horas actuales
    private string hdp;//horas diarias promedio
    private string d;//descripcion
    private string m;//marca
    private string a;//ano (AÑO)
    private string Pais;//pais
    private string mod;//modelo
    private string s;//serie
    private string f;//fabricante

	public Maquina()
	{
	}

    public string codigo
    {
        set { c = value; }
        get { return c; }
    }

    public string fabricante
    {
        set { f = value; }
        get { return f; }
    }

    public string serie
    {
        set { s = value; }
        get { return s; }
    }

    public string modelo
    {
        set { mod = value; }
        get { return mod; }
    }

    public string pais
    {
        set { Pais = value; }
        get { return Pais; }
    }

    public string ano
    {
        set {a = value; }
        get { return a; }
    }
    
    public string marca
    {
        set { m = value; }
        get { return m; }
    }
    
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }
    
    public string horasDiariasPromedio
    {
        set { hdp = value; }
        get { return hdp; }
    }
    
    public string horasActuales
    {
        set { ha = value; }
        get { return ha; }
    }

    public string horasVidaUtil
    {
        set { hvu = value; }
        get { return hvu; }
    }
    
    public string costo
    {
        set { cost = value; }
        get { return cost; }
    }
    
    public string condicionRecepcion
    {
        set { cr = value; }
        get { return cr; }
    }

    public string estado
    {
        set { e = value; }
        get { return e; }
    }
    
    public string planta
    {
        set { p = value; }
        get { return p; }
    }

    public string ubicacion
    {
        set { u = value; }
        get { return u; }
    }

    public string nombre
    {
        set { n = value; }
        get { return n; }
    }
    
    public string puestaMarcha
    {
        set { pm = value; }
        get { return pm; }
    }
    
    public string tipo
    {
        set { t = value; }
        get { return t; }
    }
}
