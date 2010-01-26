using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// Descripción breve de Elemento
/// </summary>
public class Elemento
{
    private string s;//super clase: {MAQ,CMP,LIN,PLT}


    private string c;//codigo
    private string n;//nombre
    private string d;//descripcion
    private string e;//encargado

    private string t;//tipo
    private string sist;//sistema
    private string cost;//costo
    private string vu;//vida util
    private string pm;//puesta en marcha
    private Fabricante f;//fabricante
    private List<Especificacion> esp;//especificaciones
    private List<Mantencion> m;//mantenciones

    private string u;//ubicacion
    private string est;//estado
    private string cr;//condicion de recepcion
    private string hvu;//horas vida util
    private string ha;//horas actuales
    private string hdp;//horas diarias promedio
    private List<Elemento> elems;//elementos

	public Elemento()
	{
    }

    public string superClass
    {
        set { s = value; }
        get { return s; }
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
    public string tipo
    {
        set { t = value; }
        get { return t; }
    }
    public string sistema
    {
        set { sist = value; }
        get { return sist; }
    }
    public string costo
    {
        set { cost = value; }
        get { return cost; }
    }
    public string vidaUtil
    {
        set { vu = value; }
        get { return vu; }
    }
    public string puestaMarcha
    {
        set { pm = value; }
        get { return pm; }
    }
    public Fabricante fabricante
    {
        set { f = value; }
        get { return f; }
    }
    public List<Especificacion> especificaciones
    {
        set { esp = value; }
        get { return esp; }
    }
    public List<Mantencion> mantenciones
    {
        set { m = value; }
        get { return m; }
    }
    public string ubicacion
    {
        set { u = value; }
        get { return u; }
    }
    public string estado
    {
        set { est = value; }
        get { return est; }
    }
    public string condicionRecepcion
    {
        set { cr = value; }
        get { return cr; }
    }
    public string horasVidaUtil
    {
        set { hvu = value; }
        get { return hvu; }
    }
    public string horasActuales
    {
        set { ha = value; }
        get { return ha; }
    }
    public string horasDiariasPromedio
    {
        set { hdp = value; }
        get { return hdp; }
    }
    public List<Elemento> subordinados
    {
        set { elems = value; }
        get { return elems; }
    }
    
}
