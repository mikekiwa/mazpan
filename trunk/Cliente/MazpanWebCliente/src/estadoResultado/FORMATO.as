package estadoResultado
{
	import flash.display.DisplayObject;
	import flash.text.GridFitType;
	
	import mx.collections.ArrayCollection;
	
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
	
	/*
	 myPDF.setFont (FontFamily.ARIAL, Style.NORMAL, 12);
	 
myPdf.setDisplayMode (Display.FULL_WIDTH, Layout.SINGLE_PAGE, PageMode.USE_NONE, 1);
	 */
	
	
	
	public class FORMATO
	{
		private var pdf:PDF;
		
		public function FORMATO()
		{
			pdf = new PDF(Orientation.LANDSCAPE,Unit.MM,Size.LETTER);
			pdf.setMargins(7,10,7,10);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
		}
		
		public function generarGrafico(grafico:DisplayObject, img:DisplayObject, ano:String, item:String, sucursal:String):void
		{
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.addText(item+" año "+ano,90,20);
			pdf.addText(sucursal, 110,30);
			pdf.addImage(grafico,null,10,30,250,160);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "Grafico.pdf");
		}
		
		public function generarTabla(tabla:DisplayObject, img:DisplayObject, ano:String, titulo:String, sucursal:String, meses:int):void
		{
			pdf.addImage(img,null,0,0);
			pdf.setFontSize(25);
			pdf.addText(titulo+" año "+ano,90,20);
			pdf.addText(sucursal, 110,30);
			pdf.addImage(tabla,null,10+(11-meses)*20,30,(tabla.width*260)/1266,160);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "Tabla.pdf");
		}

		public function generar(array:ArrayCollection, fecha:String):void
		{/*
			actividad
			codigo
			frecuenci
			id
			mantencion=undfined
			nombre
			planificada
		 */
		 	var check:GridColumn = new GridColumn("",null,5);
		 	var codigo:GridColumn = new GridColumn("Codigo Elemento", "codigo", 30, Align.CENTER, Align.LEFT);
			var nombre:GridColumn = new GridColumn("Nombre", "nombre", 85, Align.CENTER, Align.LEFT);
			var actividad:GridColumn = new GridColumn("Actividad", "actividad", 85, Align.CENTER, Align.LEFT);
			var frecuencia:GridColumn = new GridColumn("Frecuencia", "frecuencia", 20, Align.CENTER, Align.LEFT);
			var planificada:GridColumn = new GridColumn("Planificada", "planificada", 40, Align.CENTER, Align.LEFT);
						
			var columnas:Array=new Array(check,
										 codigo,
										 nombre,
										 actividad,
										 frecuencia,
										 planificada);
										 
          	var arr:Array = new Array();
          	
          	for(var i:int=0; i<array.length; i++)
          	{
          		arr.push(array.getItemAt(i));
          	}
          	
          	var grid:Grid = new Grid(arr, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(22);
          	pdf.addText("Actividades de Mantecion "+fecha, 20, 20);
          	pdf.setFontSize(10);
          	pdf.addGrid(grid, 0, 18, false);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "estadoResultado.pdf");
		} 
	}
}