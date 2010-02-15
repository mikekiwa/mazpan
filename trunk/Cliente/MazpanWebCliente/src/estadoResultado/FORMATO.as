package estadoResultado
{
	import componentes.Atributo;
	
	import flash.display.DisplayObject;
	
	import mx.collections.ArrayCollection;
	import mx.messaging.SubscriptionInfo;
	
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
		{
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
		public function solicitudes(array:Array, fecha:String):void
		{
		 	var check:GridColumn = new GridColumn("",null,5);
		 	var actividad:GridColumn = new GridColumn("Actividad", "actividad", 80, Align.CENTER, Align.LEFT);
			var solicitada:GridColumn = new GridColumn("Solicitada", "solicitadaString", 25, Align.CENTER, Align.CENTER);
			var plazo:GridColumn = new GridColumn("Plazo [dias]", "plazo", 25, Align.CENTER, Align.RIGHT);
			var limite:GridColumn = new GridColumn("Fecha Límite", "limiteString", 25, Align.CENTER, Align.CENTER);
			var prioridad:GridColumn = new GridColumn("Prioridad", "prioridad", 20, Align.CENTER, Align.CENTER);
			var descripcion:GridColumn = new GridColumn("Descripción", "descripcion", 85, Align.CENTER, Align.LEFT);
						
			var columnas:Array=new Array(check,
										 actividad,
										 solicitada,
										 plazo,
										 limite,
										 prioridad,
										 descripcion);
										 
          	var grid:Grid = new Grid(array, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	grid.columns=columnas;
          	
          	pdf.setFontSize(22);
          	pdf.addText("Solicitudes de Trabajo "+fecha, 20, 20);
          	pdf.setFontSize(10);
          	pdf.addGrid(grid, 0, 18, false);
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "estadoResultado.pdf");
		}
		public function vistaComponente(componente:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					componente.superClass));
          	atributos.push(new Atributo("Código",					componente.codigo));
          	atributos.push(new Atributo("Nombre",					componente.nombre));
          	atributos.push(new Atributo("Tipo",						componente.tipo));
          	atributos.push(new Atributo("Sistema",					componente.sistema));
          	atributos.push(new Atributo("Costo",					componente.costo));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	componente.puestaMarcha));
          	atributos.push(new Atributo("Hora de Vida Util",		componente.horasVidaUtil));
          	atributos.push(new Atributo("Descripción",				componente.descripcion));
          	var mantenciones:Array = componente.mantenciones.source as Array;
          	var especificaciones:Array = componente.especificaciones.source as Array;
          	var fabricante:Array = new Array();
          	fabricante.push(new Atributo("Nombre",			componente.fabricante.fabricante));
          	fabricante.push(new Atributo("Año",				componente.fabricante.ano));
          	fabricante.push(new Atributo("Modelo",			componente.fabricante.modelo));
          	fabricante.push(new Atributo("Marca",			componente.fabricante.marca));
          	fabricante.push(new Atributo("Pais",			componente.fabricante.pais));
          	fabricante.push(new Atributo("Serie",			componente.fabricante.serie));
          	
          	var colAtributo:GridColumn = new GridColumn("Atributo", "atributo", 80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = new GridColumn("Valor", "valor", 115, Align.CENTER, Align.LEFT);
			var colEspecificacion:GridColumn = new GridColumn("Especificación", "especificacion", 80, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = new GridColumn("Actividad", "actividad", 115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = new GridColumn("Frecuencia", "frecuencia", 40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = new GridColumn("Mantención", "mantencion", 40, Align.CENTER, Align.CENTER);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsEspecif:Array=new Array(colEspecificacion,colValor);
			var especif:Grid = new Grid(especificaciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	especif.columns=colsEspecif;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsFabric:Array=new Array(colAtributo,colValor);
			var fabric:Grid = new Grid(fabricante, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	fabric.columns=colsFabric;
          	
          	
          	pdf.setFontSize(22);
          	pdf.addText("Datos "+componente.nombre, 20, 20);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	pdf.writeText(8,'\nDatos del Fabricante\n');
          	pdf.addGrid(fabric);
          	
          	if(especificaciones.length>0)
          	{
          		pdf.writeText(8,'\nEspecificaciones\n');
          		pdf.addGrid(especif);
          	}
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "inline", "DatosComponente.pdf");
		}
		public function vistaMaquina(maquina:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					maquina.superClass));
          	atributos.push(new Atributo("Código",					maquina.codigo));
          	atributos.push(new Atributo("Condición de Recepcion",	maquina.condicionRecepcion));
          	atributos.push(new Atributo("Nombre",					maquina.nombre));
          	atributos.push(new Atributo("Estado",					maquina.estado));
          	atributos.push(new Atributo("Horas actuales",			maquina.horasActuales));
          	atributos.push(new Atributo("Horas diarias promedio",	maquina.horasDiariasPromedio));
          	atributos.push(new Atributo("Hora de Vida Util",		maquina.horasVidaUtil));
          	atributos.push(new Atributo("Costo",					maquina.costo));
          	atributos.push(new Atributo("Descripción",				maquina.descripcion));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	maquina.puestaMarcha));
          	atributos.push(new Atributo("Estado",					maquina.estado));
          	atributos.push(new Atributo("Ubicación",				maquina.ubicacion));
          	atributos.push(new Atributo("Tipo",						maquina.tipo));
          	var mantenciones:Array = maquina.mantenciones.source as Array;
          	var especificaciones:Array = maquina.especificaciones.source as Array;
          	var subordinados:Array = maquina.subordinados.source as Array;
          	var fabricante:Array = new Array();
          	fabricante.push(new Atributo("Nombre",			maquina.fabricante.fabricante));
          	fabricante.push(new Atributo("Año",				maquina.fabricante.ano));
          	fabricante.push(new Atributo("Modelo",			maquina.fabricante.modelo));
          	fabricante.push(new Atributo("Marca",			maquina.fabricante.marca));
          	fabricante.push(new Atributo("Serie",			maquina.fabricante.serie));
          	fabricante.push(new Atributo("Pais",			maquina.fabricante.pais));
          	
          	var colAtributo:GridColumn = 		new GridColumn("Atributo", 		"atributo", 		80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = 			new GridColumn("Valor", 		"valor", 			115, Align.CENTER, Align.LEFT);
			var colEspecificacion:GridColumn = 	new GridColumn("Especificación", "especificacion", 	80, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = 		new GridColumn("Actividad", 	"actividad", 		115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = 		new GridColumn("Frecuencia", 	"frecuencia", 		40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = 		new GridColumn("Mantención", 	"mantencion", 		40, Align.CENTER, Align.CENTER);
			var colCodigo:GridColumn =			new GridColumn("Código", 		"codigo", 			40, Align.CENTER, Align.LEFT);
			var colNombre:GridColumn = 			new GridColumn("Nombre", 		"nombre", 			70, Align.CENTER, Align.LEFT);
			var colDescripcion:GridColumn = 	new GridColumn("Desccioción", 	"descripcion", 		85, Align.CENTER, Align.LEFT);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsEspecif:Array=new Array(colEspecificacion,colValor);
			var especif:Grid = new Grid(especificaciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	especif.columns=colsEspecif;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsFabric:Array=new Array(colAtributo,colValor);
			var fabric:Grid = new Grid(fabricante, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	fabric.columns=colsFabric;
          	
          	var colsUnion:Array=new Array(colCodigo,colNombre,colDescripcion);
			var union:Grid = new Grid(subordinados, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	union.columns=colsUnion;
          	
          	
          	pdf.setFontSize(22);
          	pdf.addText("Datos "+maquina.nombre, 20, 20);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	pdf.writeText(8,'\nDatos del Fabricante\n');
          	pdf.addGrid(fabric);
          	
          	if(especificaciones.length>0)
          	{
          		pdf.writeText(8,'\nEspecificaciones\n');
          		pdf.addGrid(especif);
          	}
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	if(subordinados.length>0)
          	{
          		pdf.writeText(8,'\nElementos Subordinados\n');
          		pdf.addGrid(union);
          	}
          	
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "inline", "DatosComponente.pdf");
		}
		public function vistaLinea(linea:Object):void
		{
			pdf = new PDF(Orientation.PORTRAIT,Unit.MM,Size.LETTER);
			pdf.addPage();
			pdf.textStyle(new RGBColor(0),1);
			
			var atributos:Array = new Array();
          	atributos.push(new Atributo("SysCode",					linea.superClass));
          	atributos.push(new Atributo("Código",					linea.codigo));
          	atributos.push(new Atributo("Descripción",				linea.descripcion));
          	atributos.push(new Atributo("Nombre",					linea.nombre));
          	atributos.push(new Atributo("Encargado",				linea.encargado));
          	atributos.push(new Atributo("Fecha Puesta en Marcha",	linea.puestaMarcha));
          	var mantenciones:Array = linea.mantenciones.source as Array;
          	var subordinados:Array = linea.subordinados.source as Array;
          	
          	var colAtributo:GridColumn = 		new GridColumn("Atributo", 		"atributo", 		80, Align.CENTER, Align.LEFT);
			var colValor:GridColumn = 			new GridColumn("Valor", 		"valor", 			115, Align.CENTER, Align.LEFT);
			var colActividad:GridColumn = 		new GridColumn("Actividad", 	"actividad", 		115, Align.CENTER, Align.LEFT);
			var colFrecuencia:GridColumn = 		new GridColumn("Frecuencia", 	"frecuencia", 		40, Align.CENTER, Align.CENTER);
			var colMantencion:GridColumn = 		new GridColumn("Mantención", 	"mantencion", 		40, Align.CENTER, Align.CENTER);
			var colCodigo:GridColumn =			new GridColumn("Código", 		"codigo", 			40, Align.CENTER, Align.LEFT);
			var colNombre:GridColumn = 			new GridColumn("Nombre", 		"nombre", 			70, Align.CENTER, Align.LEFT);
			var colDescripcion:GridColumn = 	new GridColumn("Desccioción", 	"descripcion", 		85, Align.CENTER, Align.LEFT);
			
			
			var colsBasico:Array=new Array(colAtributo,colValor);
			var basico:Grid = new Grid(atributos, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	basico.columns=colsBasico;
          	
          	var colsManten:Array=new Array(colActividad,colFrecuencia,colMantencion);
			var manten:Grid = new Grid(mantenciones, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	manten.columns=colsManten;
          	
          	var colsUnion:Array=new Array(colCodigo,colNombre,colDescripcion);
			var union:Grid = new Grid(subordinados, 0, 0, new RGBColor (0x9BAFB9),new RGBColor (0xDDDDDD),new RGBColor (0), false, new RGBColor (0xCCCCCC),0,Joint.BEVEL);
          	union.columns=colsUnion;
          	
          	
          	pdf.setFontSize(22);
          	pdf.writeText(20,"Datos Línea "+linea.nombre);
          	pdf.setFontSize(10);
          	pdf.setY(20);
          	pdf.writeText(8,'\nDatos Básicos\n');
          	pdf.addGrid(basico);
          	
          	if(mantenciones.length>0)
          	{
          		pdf.writeText(8,'\nActividades de Mantención\n');
          		pdf.addGrid(manten);
          	}
          	if(subordinados.length>0)
          	{
          		pdf.writeText(8,'\nElementos Subordinados\n');
          		pdf.addGrid(union);
          	}
          	
          	pdf.save(Method.REMOTE, "http://propiedadesmartinez.cl/create.php", "inline", "DatosComponente.pdf");
		}
	}
}