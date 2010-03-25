using System;
using System.Collections.Generic;
using System.Web;

/// <summary>
/// Descripción breve de Seccion
/// </summary>
public class Seccion
{
    private string i;//id
    private string n;//nombre
    private string d;//descripcion

	public Seccion()
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
    public string nombre
    {
        set { n = value; }
        get { return  n; }
    }
    public string descripcion
    {
        set { d = value; }
        get { return d; }
    }

}
