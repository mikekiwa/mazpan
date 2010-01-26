using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;

/// <summary>
/// Descripción breve de MaquinaService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class MaquinaService : System.Web.Services.WebService
{
    private string coneccionString = Coneccion.coneccionString;

    public MaquinaService ()
    {
    }

    private bool existe(string codigo)
    {
        String select = "SELECT COUNT(*) FROM Maquinas WHERE codigo = '" + codigo + "'";
        SqlConnection selectConn = new SqlConnection(coneccionString);
        selectConn.Open();
        SqlCommand selectUsuarios = new SqlCommand(select, selectConn);
        SqlDataReader reader = selectUsuarios.ExecuteReader();

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
    /// retorna 1 si se completa la insercion
    ///         0 si la maquina ya existe
    ///        -1 si no se pueden insertar los datos basicos de la maquina
    ///        -2 si no se puede insertar especificaciones de la maquina
    ///        -3 si no se puede insertar mantenciones de la maquina
    ///        -4 si no se puede insertar actividades de mantencion de la maquina
    ///        -5 si no se puede insertar los componentes de la maquina
    /// </summary>
    /// <param name="c">El componente a insertar</param>
    /// <returns></returns>
    [WebMethod]
    public int addMaquina(Elemento m)
    {
        String query = " INSERT INTO Maquinas(tipo,codigo,puestaMarcha,nombre,ubicacion,estado,condicionRecepcion,costo,horasVidaUtil,horasActuales,horasDiariasPromedio,descripcion,marca,ano,pais,modelo,serie,fabricante)" +
                       " VALUES('"+m.tipo+"','"+m.codigo+"','"+m.puestaMarcha+"','"+m.nombre+"','"+m.ubicacion+"',''"+m.estado+"','"+m.condicionRecepcion+"','"+m.costo+"','"+m.horasVidaUtil+"','"+m.horasActuales+"','"+m.horasDiariasPromedio+"','"+m.descripcion+"','"+m.fabricante.marca+"','"+m.fabricante.ano+"','"+m.fabricante.pais+"','"+m.fabricante.modelo+"','"+m.fabricante.serie+"','"+m.fabricante.fabricante+"')";
        
        if (!existe(m.codigo))//Si dato no duplicado, no exite en la BD
            if (insert(query)==1)//si insercion exitosa
                if (addEspecificacion(m.especificaciones, m.codigo) == 1)//si insercion exitosa
                    if (addMantenciones(m.mantenciones, m.codigo) == 1)
                        if (addActividad(m.mantenciones, m.codigo, m.puestaMarcha) == 1)
                            if (addComponentes(m.componentes, m.codigo) == 1) return 1;
                            else return -5;
                        else return -4;
                    else return -3;
                else return -2;
            else return -1;
        else return 0;
    }
 
    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="especificaciones">Lista de especificaciones</param>
    /// <param name="codigo">codigo de la maquina</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addEspecificacion(List<Especificacion> especificaciones, string codigo)
    {
        int result = 0;

        foreach (Especificacion e in especificaciones)
        {
            result += insert(" INSERT INTO DatosRelevantesMaquinas(especificacion, valor, codigo)"      +
                             " VALUES('" + e.especificacion + "','" + e.valor + "','" + codigo + "')"   );
        }

        if (especificaciones.Count == result) return 1;
        else return 0;
    }

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo de la maquina</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addMantenciones(List<Mantencion> mantenciones, string codigo)
    {
        int orden = 0;
        int result = 0;
        foreach (Mantencion m in mantenciones)
        {
            orden++;
            result += insert(" INSERT INTO ActividadMantencionMaquinas(actividad, orden, tipo, frecuencia, codigo)" +
                             " VALUES('" + m.actividad + "','" + orden + "','" + m.mantencion + "','" + m.frecuencia + "','" + codigo + "')");
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="mantenciones">Lista de mantenciones</param>
    /// <param name="codigo">codigo de la maquina</param>
    /// <param name="puestaMarcha">string con la fecha de la puesta en marcha de la maquina</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    public int addActividad(List<Mantencion> mantenciones, string codigo, string puestaMarcha)
    {
        int orden = 0;
        int result = 0;
        foreach (Mantencion m in mantenciones)
        {
            orden++;
            string[] fecha = puestaMarcha.Split('/');
            int dia = Convert.ToInt32(fecha[0]);
            int mes = Convert.ToInt32(fecha[1]);
            int año = Convert.ToInt32(fecha[2]);

            DateTime t = new DateTime(año, mes, dia);
            DateTime fechas_planificada = new DateTime();
            if (m.frecuencia == "Diario") fechas_planificada = t.AddDays(1);
            if (m.frecuencia == "Semanal") fechas_planificada = t.AddDays(7);
            if (m.frecuencia == "Mensual") fechas_planificada = t.AddMonths(1);
            if (m.frecuencia == "Anual") fechas_planificada = t.AddYears(1);

            string planificada = fechas_planificada.Year + "-" + fechas_planificada.Month + "-" + fechas_planificada.Day + " 00:00.000";

            result += insert(" INSERT INTO PlanActividadMaquinas(planificada,realizada,estado,frecuencia,idActividad)" +
                             " VALUES('" + planificada + "','','false','" + m.frecuencia + "','" + codigo + "-" + orden + "')");
        }

        if (mantenciones.Count == result) return 1;
        else return 0;
    }
    
    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="componentes">Lista de componentes</param>
    /// <param name="codigo">codigo de la maquina</param>
    /// <returns>1 sí la insercion fue exitosa, 0 EOC</returns>
    [WebMethod]
    public int addComponentes(List<Elemento> componentes, string codigo)
    {   
        int result = 0;
     
        foreach (Elemento c in componentes)
        {
            result += insert(" INSERT INTO ComponenteMaquina(codigoComponente, codigoMaquina)"  +
                             " VALUES('" + c.codigo + "','" + codigo + "')"                     );
        }
        
        if (componentes.Count == result) return 1;
        return 0;
    }

    /// <summary>
    /// return 1 sí la insercion fue exitosa, 0 EOC
    /// </summary>
    /// <param name="query">La consulta de inserción que se desea ejecutar</param>
    private int insert(string query)
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






    [WebMethod]
    public DataTable allMaquinas()
    {
        DataTable dt = new DataTable();
        dt.TableName = "Maquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM Maquinas";

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

    [WebMethod(Description = "Elimina una maquina por codigo")]
    public int delMaquina(string codigo)
    {
        String query = "DELETE FROM Maquinas WHERE codigo='" + codigo + "'";
        SqlConnection cn = new SqlConnection(coneccionString);
        cn.Open();
        SqlCommand delete = new SqlCommand(query, cn);

        try
        {
            int result = delete.ExecuteNonQuery();
            cn.Close();
            return result;
        }
        catch
        {
            cn.Close();
            return -2;
        }
    }


    [WebMethod]
    public DataTable getEspecificacion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "DatosRelevantesMaquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM DatosRelevantesMaquinas WHERE codigo='" + codigo + "'";

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

    
    [WebMethod]
    public DataTable getMantencion(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "ActividadMantencionMaquinas";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ActividadMantencionMaquinas WHERE codigo='" + codigo + "'";

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

    
    [WebMethod(Description="Entrega una lista de componentes asociados a una maquina en particular")]
    public DataTable getComponentes(string codigo)
    {
        DataTable dt = new DataTable();
        dt.TableName = "ComponenteMaquina";

        SqlConnection cn = new SqlConnection(coneccionString);
        SqlDataAdapter da = new SqlDataAdapter();
        String query = "SELECT * FROM ComponenteMaquina WHERE codigoMaquina='" + codigo + "'";

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

}

