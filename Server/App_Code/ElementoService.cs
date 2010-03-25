using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;


/// <summary>
/// Descripción breve de ElementoService
/// </summary>
[WebService(Namespace = "http://tempuri.org/Server/ElementoService/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ElementoService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionStringSVRMASPAN;

    public ElementoService ()
    {
    }

    /// <summary>
    /// Permite ver si un elemento ya existe
    /// </summary>
    /// <param name="codigo">el codigo del elemento por el que se desea consultar</param>
    /// <returns>true si el componente exite, false EOC</returns>
    [WebMethod]
    public bool existe(string codigo)
    {
        String query = "SELECT COUNT(*) FROM [PracticaDb].[dbo].[Elemento] WHERE codigo = '" + codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand select = new SqlCommand(query, selectConn);
        SqlDataReader reader = select.ExecuteReader();

        if (reader.Read())
        {
            if (reader.GetInt32(0) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }
        else
        {
            return false;
        }
    }


    /// <summary>
    /// retorna 2 si el super de elemento no es valido
    ///         1 si se completa la insercion
    ///         0 si el Elemento ya existe
    ///        -1 si no se pueden insertar los datos basicos del Elemento
    ///        -2 si no se puede insertar especificaciones del Elemento
    ///        -3 si no se puede insertar mantenciones del Elemento
    ///        -4 si no se puede insertar actividades de mantencion del Elemento
    ///        -5 si no se puede insertar los elementos subordinasod del elemento en cuestion
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod(Description="Permite agregar un elemento")]
    public int addElemento(Usuario u, Elemento e)
    {
        if(!existe(e.codigo))
        {
            if (e.superClass.CompareTo("CMP") == 0) return addComponente(u,e);
            if (e.superClass.CompareTo("MAQ") == 0) return addMaquina(u,e);
            if (e.superClass.CompareTo("LIN") == 0) return addLinea(u,e);
            return 2;
        }

        return 0;//EOC
    }

    [WebMethod(Description = "Permite editar un elemento")]
    public int editElemento(Usuario u, Elemento e)
    {
        if (existe(e.codigo))
        {
            if (e.superClass.CompareTo("CMP") == 0) return editComponente(u, e);
            if (e.superClass.CompareTo("MAQ") == 0) return editMaquina(u, e);
            return 2;
        }

        return 0;//EOC
    }
    

    /// <summary>
    /// retorna una tabla con los elementos requeridos
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod(Description = "Permite obtener todos los elementos de la super clase especificada")]
    public DataTable allElementos(Usuario u, string superClass)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Elementos";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = " SELECT * FROM [PracticaDb].[dbo].[Elemento] WHERE super='"+superClass+"' AND planta='"+u.planta+"' ";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }
    

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">
    /// La consulta que se desea ejecutar
    /// </param>
    private int Ejecutar(string query)
    {
        SqlConnection conn = new SqlConnection(coneccionString);
        conn.Open();
        SqlCommand insert = new SqlCommand(query, conn);

        try
        {
            insert.ExecuteNonQuery();
            conn.Close();
        }
        catch
        {
            conn.Close();
            return 0;
        }
        return 1;
    }


    /// <summary>
    /// Elimina un Elemento por codigo
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="codigo">codigo del elemento que se desea eliminar</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod(Description = "Elimina un Elemento por codigo")]
    public int delElemento(string codigo)
    {
        String query = "DELETE FROM [PracticaDB].[dbo].[Elemento] WHERE codigo='" + codigo + "'";
        int result = Ejecutar(query);

        if(result==1) return 1;
        else return 0;
    }


    /// <summary>
    /// Recive una cadana de texto con formato dd/mm/aaaa y la lleva a un DateTime
    /// </summary>
    /// <param name="fecha">Cadana de texto con formato dd/mm/aaaa</param>
    /// <returns>Fecha como un tipo DateTime</returns>
    private DateTime toDateTime(string fecha)
    {
        string[] date = fecha.Split('/');
        int dia = Convert.ToInt32(date[0]);
        int mes = Convert.ToInt32(date[1]);
        int año = Convert.ToInt32(date[2]);

        return new DateTime(año, mes, dia);
    }


     /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos de la linea
    ///        -2 si no se puede insertar especificaciones de la linea
    ///        -3 si no se puede insertar mantenciones de la linea
    ///        -4 si no se puede insertar actividades de mantencion de la linea
    ///        -5 si no se puede insertar los componentes de la linea
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addLinea(Usuario u, Elemento m)
    {
        DateTime t = toDateTime(m.puestaMarcha);
        string puestaMarcha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        String query = " INSERT INTO [PracticaDb].[dbo].[Elemento](super,nombre,codigo,encargado,puestaMarcha,descripcion,planta) " +
                       " VALUES('LIN','" + m.nombre + "','" + m.codigo + "','" + m.encargado + "','" + puestaMarcha + "','" + m.descripcion + "','"+u.planta+"') ";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addActividades(m.mantenciones, m.codigo) == 1)
                if (addPlan(m.mantenciones, m.codigo, m.puestaMarcha) == 1)
                    if (addUnion(m.subordinados, m.codigo) == 1) return 1;
                    else return -5;
                else return -4;
            else return -3;
        else return -1;
    }


    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos de la maquina
    ///        -2 si no se puede insertar especificaciones de la maquina
    ///        -3 si no se puede insertar mantenciones de la maquina
    ///        -4 si no se puede insertar actividades de mantencion de la maquina
    ///        -5 si no se puede insertar los elemento subordinados de la maquina
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addMaquina(Usuario u,Elemento m)
    {
        DateTime t = toDateTime(m.puestaMarcha);
        string puestaMarcha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        String query = " INSERT INTO [PracticaDb].[dbo].[Elemento](super,tipo,codigo,puestaMarcha,nombre,ubicacion,estado,condicionRecepcion,costo,horasVidaUtil,horasActuales,horasDiariasPromedio,descripcion,marca,ano,pais,modelo,serie,fabricante,planta)" +
                       " VALUES('MAQ','" + m.tipo + "','" + m.codigo + "','" + puestaMarcha + "','" + m.nombre + "','" + m.ubicacion + "','" + m.estado + "','" + m.condicionRecepcion + "','" + m.costo + "','" + m.horasVidaUtil + "','" + m.horasActuales + "','" + m.horasDiariasPromedio + "','" + m.descripcion + "','" + m.fabricante.marca + "','" + m.fabricante.ano + "','" + m.fabricante.pais + "','" + m.fabricante.modelo + "','" + m.fabricante.serie + "','" + m.fabricante.fabricante + "','"+u.planta+"')";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(m.especificaciones, m.codigo) == 1)//si insercion exitosa
                if (addActividades(m.mantenciones, m.codigo) == 1)
                    if (addPlan(m.mantenciones, m.codigo, m.puestaMarcha) == 1)
                        if (addUnion(m.subordinados,m.codigo) == 1) return 1;
                        else return -5;
                    else return -4;
                else return -3;
            else return -2;
        else return -1;
    }
    

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="especificaciones">Lista de Elementos que se desean unir como suborinados</param>
    /// <param name="codigo">codigo del elemento al que se desea unir los elementos subordinados</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addUnion(List<Elemento> elementos, string codigo)
    {
        int result = 0;

        Ejecutar(" DELETE [PracticaDb].[dbo].[Union] WHERE codigo='"+codigo+"' ");

        foreach (Elemento e in elementos)
        {
            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Union](padre, hijo) " +
                               " VALUES('" + codigo + "', '" + e.codigo + "') ");
        }

        if (elementos.Count == result) return 1;
        else return 0;
    }


    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos del componente
    ///        -2 si no se puede insertar especificaciones del componente
    ///        -3 si no se puede insertar mantenciones del componente
    ///        -4 si no se puede insertar actividades de mantencion del componente
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addComponente(Usuario u,Elemento c)
    {
        DateTime t = toDateTime(c.puestaMarcha);
        string puestaMarcha = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";

        string query = " INSERT INTO [PracticaDb].[dbo].[Elemento]([super],[tipo],[codigo],[sistema],[nombre],[costo],[horasVidaUtil],[descripcion],[marca],[ano],[pais],[modelo],[serie],[fabricante],[puestaMarcha],[planta])" +
                       " VALUES('CMP','" + c.tipo + "','" + c.codigo + "','" + c.sistema + "','" + c.nombre + "','" + c.costo + "','" + c.horasVidaUtil + "','" + c.descripcion + "','" + c.fabricante.marca + "','" + c.fabricante.ano + "','" + c.fabricante.pais + "','" + c.fabricante.modelo + "','"+c.fabricante.serie+"','" + c.fabricante.fabricante + "','" + puestaMarcha + "','"+u.planta+"')";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(c.especificaciones, c.codigo) == 1)//si insercion exitosa
                if (addActividades(c.mantenciones, c.codigo) == 1)
                    if (addPlan(c.mantenciones, c.codigo, c.puestaMarcha) == 1) return 1;
                    else return -4;
                else return -3;
            else return -2;
        else return -1;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="especificaciones">Lista de especificaciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addEspecificaciones(List<Especificacion> especificaciones, string codigo)
    {
        int result = 0;

        Ejecutar(" DELETE [PracticaDb].[dbo].[Especificaciones] WHERE codigo='"+codigo+"' ");

        foreach (Especificacion e in especificaciones)
        {
            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Especificaciones](especificacion, valor, codigo) " +
                               " VALUES('" + e.especificacion + "','" + e.valor + "','" + codigo + "') ");
        }

        if (especificaciones.Count == result) return 1;
        else return 0;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addActividades(List<Mantencion> mantenciones, string codigo)
    {
        int orden = 0;
        int result = 0;

        foreach (Mantencion m in mantenciones)
        {
            orden++;
            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Actividades](actividad, orden, mantencion, frecuencia, codigo)" +
                               " VALUES('" + m.actividad + "','" + orden + "','" + m.mantencion + "','" + m.frecuencia + "','" + codigo + "')");
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }


    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo del elemento</param>
    /// <param name="puestaMarcha">string con la fecha de la puesta en marcha del componente</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addPlan(List<Mantencion> mantenciones, string codigo, string puestaMarcha)
    {
        int result = 0;
        foreach (Mantencion m in mantenciones)
        {
            DateTime t = toDateTime(puestaMarcha);
            DateTime fechas_planificada = new DateTime();
            if (m.frecuencia == "Diario") fechas_planificada = t.AddDays(1);
            if (m.frecuencia == "Semanal") fechas_planificada = t.AddDays(7);
            if (m.frecuencia == "Quincenal") fechas_planificada = t.AddDays(15);
            if (m.frecuencia == "Mensual") fechas_planificada = t.AddMonths(1);
            if (m.frecuencia == "Bimestral") fechas_planificada = t.AddMonths(2);
            if (m.frecuencia == "Trimestral") fechas_planificada = t.AddMonths(3);
            if (m.frecuencia == "Cuatrimestral") fechas_planificada = t.AddMonths(4);
            if (m.frecuencia == "Semestral") fechas_planificada = t.AddMonths(6);
            if (m.frecuencia == "Anual") fechas_planificada = t.AddYears(1);

            //Con esto evitamos que nos aparezca un sabado o domingo en el plan
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Saturday") == 0) fechas_planificada = fechas_planificada.AddDays(2);
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Sunday") == 0) fechas_planificada = fechas_planificada.AddDays(1);

            string planificada = fechas_planificada.Year + "-" + fechas_planificada.Month + "-" + fechas_planificada.Day + " 00:00.000";

            result += Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Plan]([planificada],[realizada],[frecuencia],[actividad],[codigo]) VALUES('" + planificada + "','','" + m.frecuencia + "','"+m.actividad+"','" + codigo + "')" );
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }

    [WebMethod]
    public int addMantenciones(Elemento c)
    {
        if (addActividades(c.mantenciones, c.codigo) == 1)
            if (addPlan(c.mantenciones, c.codigo, c.puestaMarcha) == 1) return 1;
            else return -4;
        else return -3;
    }

    [WebMethod]
    public DataTable getActividades(Usuario u)
    {
        DataTable dt = new DataTable();
        dt.TableName = "Plan";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();

        DateTime hoy = DateTime.Now;
        string fecha = hoy.Year + "-" + hoy.Month + "-" + hoy.Day + " 00:00.000";

        string query = " SELECT	T1.nombre, T2.actividad, T2.id, T2.planificada, T2.frecuencia, T2.codigo "+
                       " FROM	PracticaDb.dbo.Elemento		    T1 "+
                       " JOIN	PracticaDb.dbo.[Plan]			T2	on T1.codigo=T2.codigo  "+
                       " WHERE	T2.realizada<T2.planificada		AND T2.planificada<='" + fecha + "'     AND T1.planta='"+u.planta+"'";

        da.SelectCommand = new SqlCommand(query, cn);

        try
        {
            da.Fill(dt);
        }
        finally
        {
            cn.Close();
        }

        return dt;
    }


    /// <summary>
    /// retorna 1 sí la insercion de todos las activiades fue exitosa
    ///        -1 sí la insercion de algunos datos fue exitosa
    ///         0 EOC
    /// </summary>
    /// <param name="actividades">Lista de las actividades de mantencion que se quieren marcar como realizadas</param>
    /// <returns>1 sí la insercion de todos las activiades fue exitosa, -1 sí la insercion de algunos datos fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int realizarActividades(List<Mantencion> actividades)
    {   
        int result = 0;
        foreach (Mantencion m in actividades)
        {
            DateTime t = DateTime.Now;
            DateTime fechas_planificada = new DateTime();
            if (m.frecuencia == "Diario") fechas_planificada = t.AddDays(1);
            if (m.frecuencia == "Semanal") fechas_planificada = t.AddDays(7); 
            if (m.frecuencia == "Quincenal") fechas_planificada = t.AddDays(15);
            if (m.frecuencia == "Mensual") fechas_planificada = t.AddMonths(1);
            if (m.frecuencia == "Bimestral") fechas_planificada = t.AddMonths(2);
            if (m.frecuencia == "Trimestral") fechas_planificada = t.AddMonths(3);
            if (m.frecuencia == "Cuatrimestral") fechas_planificada = t.AddMonths(4);
            if (m.frecuencia == "Semestral") fechas_planificada = t.AddMonths(6);
            if (m.frecuencia == "Anual") fechas_planificada = t.AddYears(1);

            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Saturday")==0) fechas_planificada = fechas_planificada.AddDays(2);
            if (fechas_planificada.DayOfWeek.ToString().CompareTo("Sunday") == 0) fechas_planificada = fechas_planificada.AddDays(1);

            string planificada = fechas_planificada.Year + "-" + fechas_planificada.Month + "-" + fechas_planificada.Day + " 00:00.000";

            int resultAux = Ejecutar(" INSERT INTO [PracticaDb].[dbo].[Plan]([planificada],[realizada],[frecuencia],[actividad],[codigo])" +
                                     " VALUES('" + planificada + "','','" + m.frecuencia + "','" + m.actividad + "','" + m.codigo + "')");

            if (resultAux == 1)
            {
                string realizada = t.Year + "-" + t.Month + "-" + t.Day + " 00:00.000";
                result += Ejecutar(" UPDATE [PracticaDb].[dbo].[Plan] SET realizada='" + realizada + "' WHERE id='" + m.id + "'");
            }
            else
            {
                return 0;
            }
        }

        if(actividades.Count == result) return 1;
        else return -1;
    }


    [WebMethod]
    public Elemento getElemento(Elemento e)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = " SELECT codigo,super,convert(varchar(50),puestaMarcha,105),nombre,encargado,ubicacion,estado,condicionRecepcion,costo,horasVidaUtil,horasActuales,horasDiariasPromedio,descripcion,marca,ano,pais,modelo,serie,fabricante,tipo,sistema " +
                       " FROM [PracticaDb].[dbo].Elemento Where codigo='" + e.codigo + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        Elemento salida = null; ;
        Fabricante f = null;

        if (reader.Read())
        {
            salida = new Elemento();
            f = new Fabricante();

            if (!reader.IsDBNull(0)) salida.codigo = reader.GetString(0); else salida.codigo = null;
            if (!reader.IsDBNull(1)) salida.superClass = reader.GetString(1); else salida.superClass = null;
            if (!reader.IsDBNull(2)) salida.puestaMarcha = reader.GetString(2); else salida.puestaMarcha = null;
            if (!reader.IsDBNull(3)) salida.nombre = reader.GetString(3); else salida.nombre = null;
            if (!reader.IsDBNull(4)) salida.encargado = reader.GetString(4); else salida.encargado = null;
            if (!reader.IsDBNull(5)) salida.ubicacion = reader.GetString(5); else salida.ubicacion = null;
            if (!reader.IsDBNull(6)) salida.estado = reader.GetString(6); else salida.estado = null;
            if (!reader.IsDBNull(7)) salida.condicionRecepcion = reader.GetString(7); else salida.condicionRecepcion = null;
            if (!reader.IsDBNull(8)) salida.costo = reader.GetInt32(8).ToString(); else salida.costo = null;
            if (!reader.IsDBNull(9)) salida.horasVidaUtil = reader.GetInt32(9).ToString(); else salida.horasVidaUtil = null;
            if (!reader.IsDBNull(10)) salida.horasActuales = reader.GetInt32(10).ToString(); else salida.horasActuales = null;
            if (!reader.IsDBNull(11)) salida.horasDiariasPromedio = reader.GetInt32(11).ToString(); else salida.horasDiariasPromedio = null;
            if (!reader.IsDBNull(12)) salida.descripcion = reader.GetString(12); else salida.descripcion = null;
            if (!reader.IsDBNull(13)) f.marca = reader.GetString(13); else f.marca = null;
            if (!reader.IsDBNull(14)) f.ano = reader.GetInt32(14).ToString(); else f.ano = null;
            if (!reader.IsDBNull(15)) f.pais = reader.GetString(15); else f.pais = null;
            if (!reader.IsDBNull(16)) f.modelo = reader.GetString(16); else f.modelo = null;
            if (!reader.IsDBNull(17)) f.serie = reader.GetString(17); else f.serie = null;
            if (!reader.IsDBNull(18)) f.fabricante = reader.GetString(18); else f.fabricante = null;
            if (!reader.IsDBNull(19)) salida.tipo = reader.GetString(19); else salida.tipo = null;
            if (!reader.IsDBNull(20)) salida.sistema = reader.GetString(20); else salida.sistema = null;
            salida.fabricante = f;
            salida.mantenciones = getMantenciones(e);
            salida.especificaciones = getEspecificaciones(e);
            salida.subordinados = getSubordinados(e);
        }

        return salida;
    }

    private List<Elemento> getSubordinados(Elemento e)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = " SELECT T3.codigo, T3.nombre,T3.descripcion,T3.super FROM [PracticaDb].[dbo].Elemento T1 JOIN [PracticaDb].[dbo].[Union] T2 ON T1.codigo=T2.padre JOIN [PracticaDb].[dbo].Elemento T3 ON T2.hijo=T3.codigo WHERE T2.padre='" + e.codigo + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        List<Elemento> salida = new List<Elemento>();

        while (reader.Read())
        {
            Elemento elemento = new Elemento();

            if (!reader.IsDBNull(0)) elemento.codigo = reader.GetString(0); else elemento.codigo = null;
            if (!reader.IsDBNull(1)) elemento.nombre = reader.GetString(1); else elemento.nombre = null;
            if (!reader.IsDBNull(2)) elemento.descripcion = reader.GetString(2); else elemento.descripcion = null;
            if (!reader.IsDBNull(3)) elemento.superClass = reader.GetString(3); else elemento.superClass = null;
            salida.Add(elemento);
        }
        cn.Close();
        return salida;
    }
 
    private List<Especificacion> getEspecificaciones(Elemento e)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = "SELECT * FROM [PracticaDb].[dbo].Especificaciones WHERE codigo='" + e.codigo + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        List<Especificacion> salida = new List<Especificacion>();
        
        while (reader.Read())
        {
            Especificacion espeficacion = new Especificacion();
            if (!reader.IsDBNull(1)) espeficacion.especificacion = reader.GetString(1); else espeficacion.especificacion = null;
            if (!reader.IsDBNull(2)) espeficacion.valor = reader.GetString(2); else espeficacion.valor = null;

            salida.Add(espeficacion);
        }
        cn.Close();
        return salida;
    }

    private List<Mantencion> getMantenciones(Elemento e)
    {
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        string query = "SELECT * FROM [PracticaDb].[dbo].Actividades WHERE codigo='" + e.codigo + "'";
        SqlCommand selectUsuarios = new SqlCommand(query, cn);

        SqlDataReader reader = selectUsuarios.ExecuteReader();

        List<Mantencion> salida = new List<Mantencion>();

        while (reader.Read())
        {
            Mantencion actividad = new Mantencion();
            if (!reader.IsDBNull(0)) actividad.id = reader.GetInt32(0) + ""; else actividad.id = null;
            if (!reader.IsDBNull(1)) actividad.actividad = reader.GetString(1); else actividad.actividad = null;
            if (!reader.IsDBNull(3)) actividad.mantencion = reader.GetString(3); else actividad.mantencion = null;
            if (!reader.IsDBNull(4)) actividad.frecuencia = reader.GetString(4); else actividad.frecuencia = null;

            salida.Add(actividad);
        }
        cn.Close();
        return salida;
    }

    [WebMethod]
    public void delMantencion(string id, string codigo)
    {
        Ejecutar(" DELETE [PracticaDb].[dbo].[Actividades] WHERE id='"+id+"' ");
        Ejecutar(" DELETE [PracticaDb].[dbo].[Plan] WHERE planificada>realizada AND codigo='" + codigo + "' ");
    }



    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos de la maquina
    ///        -2 si no se puede insertar especificaciones de la maquina
    ///        -3 si no se puede insertar mantenciones de la maquina
    ///        -4 si no se puede insertar actividades de mantencion de la maquina
    ///        -5 si no se puede insertar los elemento subordinados de la maquina
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int editMaquina(Usuario u, Elemento m)
    {
        String query = " UPDATE [PracticaDb].[dbo].[Elemento] SET tipo='"+m.tipo+"',nombre='"+m.nombre+"',ubicacion='"+m.ubicacion+"',estado='"+m.estado+"',condicionRecepcion='"+m.condicionRecepcion+"',costo='"+m.costo+"',horasVidaUtil='"+m.horasVidaUtil+"',horasActuales='"+m.horasActuales+"',horasDiariasPromedio='"+m.horasDiariasPromedio+"',descripcion='"+m.descripcion+"',marca='"+m.fabricante.marca+"',ano='"+m.fabricante.ano+"',pais='"+m.fabricante.pais+"',modelo='"+m.fabricante.modelo+"',serie='"+m.fabricante.serie+"',fabricante='"+m.fabricante.fabricante+"' WHERE codigo='"+m.codigo+"' ";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(m.especificaciones, m.codigo) == 1)//si insercion exitosa
                if (addUnion(m.subordinados, m.codigo) == 1) return 1;
                else return -5;
            else return -2;
        else return -1;
    }


    /// <summary>
    /// retorna 1 si se completa la insercion
    ///        -1 si no se pueden insertar los datos basicos del componente
    ///        -2 si no se puede insertar especificaciones del componente
    ///        -3 si no se puede insertar mantenciones del componente
    ///        -4 si no se puede insertar actividades de mantencion del componente
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int editComponente(Usuario u, Elemento c)
    {
        string query = " UPDATE [PracticaDb].[dbo].[Elemento] SET [tipo]='" + c.tipo + "',[sistema]='" + c.sistema + "',[nombre]='" + c.nombre + "',[costo]='" + c.costo + "',[horasVidaUtil]='" + c.horasVidaUtil + "',[descripcion]='" + c.descripcion + "',[marca]='" + c.fabricante.marca + "',[ano]='" + c.fabricante.ano + "',[pais]='" + c.fabricante.pais + "',[modelo]='" + c.fabricante.modelo + "',[serie]='" + c.fabricante.serie + "',[fabricante]='" + c.fabricante.fabricante + "' WHERE codigo='"+c.codigo+"'";

        if (Ejecutar(query) == 1)//si insercion exitosa
            if (addEspecificaciones(c.especificaciones, c.codigo) == 1) return 1;
            else return -2;
        else return -1;
    }
}

