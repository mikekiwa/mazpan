using System;
using System.Collections.Generic;
using System.Web;
using System.Data;

/// <summary>
/// Descripción breve de Evaluacion
/// </summary>
public class Evaluacion
{
    private string i;//id
    private string c;//cumplidos
    private string loc;//local
    private DataTable e;//evaluacion
    private DataTable cat;//categorias
    private string t;//trabajdor
    private string f;//fecha
    private string nt;//nombre trabajador 

	public Evaluacion()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    public string id
    {
        set { i = value; }
        get { return i; }
    }
    public string cumple
    {
        set { c = value; }
        get { return c; }
    }
    public string local
    {
        set { loc = value; }
        get { return loc; }
    }
    public DataTable evaluacion
    {
        set { e = value; }
        get { return e; }
    }
    public DataTable categorias
    {
        set { cat = value; }
        get { return cat; }
    }
    public string nombreTrabajador
    {
        set { nt = value; }
        get { return nt; }
    }
    public string trabajador
    {
        set { t = value; }
        get { return t; }
    }
    public string fecha
    {
        set { f = value; }
        get { return f; }
    }
}
