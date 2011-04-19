package componentes.planMantencion
{
	import misClases.Constantes;
	
	import org.alivepdf.colors.RGBColor;
	import org.alivepdf.data.Grid;
	import org.alivepdf.data.GridColumn;
	import org.alivepdf.drawing.Joint;
	import org.alivepdf.layout.Align;
	import org.alivepdf.layout.Orientation;
	import org.alivepdf.layout.Size;
	import org.alivepdf.layout.Unit;
	import org.alivepdf.pdf.PDF;
	import org.alivepdf.saving.Method;
	
	public class LAYOUT_MANTENCIONES
	{
		private var pdf:PDF;
		
		public function LAYOUT_MANTENCIONES()
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);			
		}
		public function generar(fallas:Array, maquina:Object):void
		{
			var falla:GridColumn = new GridColumn("Falla", "falla", 50, Align.CENTER, Align.LEFT);
			var horas:GridColumn = new GridColumn("Horas", "horas", 40, Align.CENTER, Align.LEFT);
			var fecha:GridColumn = new GridColumn("Fecha", "fecha", 40, Align.CENTER, Align.LEFT);
			
			var columnas:Array=new Array(falla,horas,fecha);
										 
          	var grid:Grid = new Grid(fallas, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),1,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(22);
          	pdf.writeText(20,"Fallas Reportadas\n");
          	pdf.setFontSize(10);
          	pdf.writeText(10,"Maquina: "+ maquina.nombre+"\n");
			pdf.writeText(10,"Codigo: "+ maquina.codigo+"\n");
			pdf.writeText(10,"Descripcion: "+ maquina.descripcion+"\n\n");
			
          	pdf.addGrid(grid, 0, 0, true);
          	
          	pdf.save(Method.REMOTE, Constantes.createPhp, 'inline', "FallasReportadas.pdf");
		}
		public function generarReparaciones(reparaciones:Array, mes:String, año:String):void
		{
			/*pdf = new PDF(Orientation.LANDSCAPE,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);*/
			
			var actividad:GridColumn = new GridColumn("Actividad", "actividad", 55, Align.CENTER, Align.LEFT);
			var codigo:GridColumn = new GridColumn("Código", "codigo", 25, Align.CENTER, Align.LEFT);
			var condicionRecepcion:GridColumn = new GridColumn("Recepcionada", "condicionRecepcion", 15, Align.CENTER, Align.LEFT);
			var frecuencia:GridColumn = new GridColumn("Frecuencia", "frecuencia", 15, Align.CENTER, Align.LEFT);
			var nombre:GridColumn = new GridColumn("Nombre", "nombre", 55, Align.CENTER, Align.LEFT);
			var planificada:GridColumn = new GridColumn("Planificada", "planificada", 13, Align.CENTER, Align.LEFT);
			var realizada:GridColumn = new GridColumn("Realizada", "realizada", 13, Align.CENTER, Align.LEFT);
			
			var columnas:Array=new Array(actividad,codigo,condicionRecepcion,frecuencia,nombre,planificada,realizada);
										 
          	var grid:Grid = new Grid(reparaciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),1,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(25);
          	pdf.writeText(25,"Reporte de Reparaciones\n");
          	
          	pdf.setFontSize(5);
          	
          	pdf.addGrid(grid, 0, 0, true);
          	
          	pdf.save(Method.REMOTE, Constantes.createPhp, 'inline', "Reparaciones"+mes+año+".pdf");
		
		}
	}
}