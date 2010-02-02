using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Solicitud
/// </summary>
public class Solicitud
{
    private string rs1;//rut Solicitante
    private string rs2;//rut Solicitado
    private string a;//actividad
    private string pl;//plazo
    private string pr;//prioridad
    private string d;//

    private string i;//id
    private string s;//solicitada
    private string l;//limite

	public Solicitud()
	{
	}

    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string solicitada
    {
        set { s = value; }
        get { return s; }
    }
    public string limite
    {
        set { l = value; }
        get { return l; }
    }
    public string actividad
    {
        set { a = value; }
        get { return a; }
    }    
    public string prioridad
    {
        set { pr = value; }
        get { return pr; }
    }
    public string plazo
    {
        set { pl = value; }
        get { return pl; }
    }
    public string detalle
    {
        set { d = value; }
        get { return d; }
    }
    public string rutSolicitado
    {
        set { rs2 = value; }
        get { return rs2; }
    }
    public string rutSolicitante
    {
        set { rs1 = value; }
        get { return rs1; }
    }
}
