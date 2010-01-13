package
{
	import flash.filters.BevelFilter;
	
	public class ITEMS
	{
		private var datos:Array;
		//son 23 constantes, y podrian reducirse a 22 si es que el impuesto se calcula y no se obtiene
		public static const VENTASZONAS:int = 1;
		public static const VENTASPANADERIA:int = 2;
		public static const DEVOLUCIONESDESCUENTOSBONIFICACIONES:int = 3;
		public static const RAPELCLIENTE:int = 4;
		public static const COSTOSINSUMOSZONAS:int = 7;
		public static const COSTOSINSUMOSPANADERIA:int = 8;
		public static const MOOPERATIVA:int = 9;
		public static const GASTOSENERGIA:int = 10;
		public static const MANTENCION:int = 11;
		public static const ASEO:int = 12;
		public static const REMUNERACIONES:int = 16;
		public static const INDEMNIZACIONES:int = 17;
		public static const MANTENCIONYARRIENDO:int = 18;
		public static const ADMINISTRACION:int = 19;
		public static const TRANSPORTESFLETES:int = 20;
		public static const GESTIONVENTAS:int = 21;
		public static const ASESORIAS:int = 22;
		public static const ADMINISTRACIONCAS:int = 23;
		public static const DEPRECIACIONES:int = 24;
		public static const GASTOSFINANCIEROS:int = 27;
		public static const CORRECCIONMONETARIA:int = 28;
		public static const OTROSINGRESOSYGASTOS:int = 29;
		public static const IMPUESTOALARENTA:int = 31;
		public static const MAXVALUE:int = 999999;
		
		//Constantes de resultado
		public static const VENTASNETAS:int = 5;
		public static const COSTOSTOTALES:int = 13;
		public static const MARGENCOMERCIAL:int = 14;
		public static const TOTALGASTOSADMINISTRATIVOS:int = 25;
		public static const MARGENOPERACIONAL:int = 26;
		public static const RESULTADOANTESDEIMPUESTO:int = 30;
		public static const RESULTADO:int = 32;
		
		//Contantes de titulo
		public static const VENTAS:int = 0;
		public static const COSTOS:int = 6;
		public static const GASTOSADMISTRATIVOS:int = 15;
		
		
		/**
		 * Retorna 999999999 si el elemento es el ultimo de la lista
		 */ 
		public function ITEMS(_datos:Array)
		{
			this.datos = _datos;
		}
		 
		public static function next(itemIndex:int):int
		{
			if(itemIndex==VENTASZONAS) return VENTASPANADERIA;
			if(itemIndex==VENTASPANADERIA) return DEVOLUCIONESDESCUENTOSBONIFICACIONES;
			if(itemIndex==DEVOLUCIONESDESCUENTOSBONIFICACIONES) return RAPELCLIENTE;
			if(itemIndex==RAPELCLIENTE) return COSTOSINSUMOSZONAS;
			if(itemIndex==COSTOSINSUMOSZONAS) return COSTOSINSUMOSPANADERIA;
			if(itemIndex==COSTOSINSUMOSPANADERIA) return MOOPERATIVA;
			if(itemIndex==MOOPERATIVA) return GASTOSENERGIA;
			if(itemIndex==GASTOSENERGIA) return MANTENCION;
			if(itemIndex==MANTENCION) return ASEO;
			if(itemIndex==ASEO) return REMUNERACIONES;
			if(itemIndex==REMUNERACIONES) return INDEMNIZACIONES;
			if(itemIndex==INDEMNIZACIONES) return MANTENCIONYARRIENDO;
			if(itemIndex==MANTENCIONYARRIENDO) return ADMINISTRACION;
			if(itemIndex==ADMINISTRACION) return TRANSPORTESFLETES;
			if(itemIndex==TRANSPORTESFLETES) return GESTIONVENTAS;
			if(itemIndex==GESTIONVENTAS) return ASESORIAS;
			if(itemIndex==ASESORIAS) return ADMINISTRACIONCAS;
			if(itemIndex==ADMINISTRACIONCAS) return DEPRECIACIONES;
			if(itemIndex==DEPRECIACIONES) return GASTOSFINANCIEROS;
			if(itemIndex==GASTOSFINANCIEROS) return CORRECCIONMONETARIA;
			if(itemIndex==CORRECCIONMONETARIA) return OTROSINGRESOSYGASTOS;
			if(itemIndex==OTROSINGRESOSYGASTOS) return IMPUESTOALARENTA;
			if(itemIndex==IMPUESTOALARENTA) return MAXVALUE;
			return MAXVALUE;
		}
		
		private function SET(item:int):void
		{
			datos[item].ENE = 0;
			datos[item].FEB = 0;
			datos[item].MAR = 0;
			datos[item].ABR = 0;
			datos[item].MAY = 0;
			datos[item].JUN = 0;
			datos[item].JUL = 0;
			datos[item].AGO = 0;
			datos[item].SEP = 0;
			datos[item].OCT = 0;
			datos[item].NOV = 0;
			datos[item].DIC = 0;
			datos[item].PPTO = 0;
		}
		private function sig(item:int, raiz:int):int
		{
			if(raiz==VENTASNETAS)
			{
				if(item==VENTASNETAS)return VENTASZONAS;
				if(item==VENTASZONAS)return VENTASPANADERIA;
				if(item==VENTASPANADERIA)return DEVOLUCIONESDESCUENTOSBONIFICACIONES;
				if(item==DEVOLUCIONESDESCUENTOSBONIFICACIONES)return RAPELCLIENTE;
				if(item==RAPELCLIENTE)return MAXVALUE;//esto se podria omitir y al final se retorna para todos lo mismo, es decir para todos los que son finales o ultimos
			}
			if(raiz==COSTOSTOTALES)
			{
				if(item==COSTOSTOTALES)return COSTOSINSUMOSZONAS;
				if(item==COSTOSINSUMOSZONAS)return COSTOSINSUMOSPANADERIA;
				if(item==COSTOSINSUMOSPANADERIA)return MOOPERATIVA;
				if(item==MOOPERATIVA)return GASTOSENERGIA;
				if(item==GASTOSENERGIA)return MANTENCION;
				if(item==MANTENCION)return ASEO;
				if(item==ASEO)return MAXVALUE;
			}
			if(raiz==TOTALGASTOSADMINISTRATIVOS)
			{
				if(item==TOTALGASTOSADMINISTRATIVOS)return REMUNERACIONES;
				if(item==REMUNERACIONES)return INDEMNIZACIONES;
				if(item==INDEMNIZACIONES)return MANTENCIONYARRIENDO;
				if(item==MANTENCIONYARRIENDO)return ADMINISTRACION;
				if(item==ADMINISTRACION)return TRANSPORTESFLETES;
				if(item==TRANSPORTESFLETES)return GESTIONVENTAS;
				if(item==GESTIONVENTAS)return ASESORIAS;
				if(item==ASESORIAS)return ADMINISTRACIONCAS;
				if(item==ADMINISTRACIONCAS)return DEPRECIACIONES;
				if(item==DEPRECIACIONES)return MAXVALUE;
			}
			if(raiz==MARGENCOMERCIAL)
			{
				if(item==MARGENCOMERCIAL)return VENTASNETAS;
				if(item==VENTASNETAS)return COSTOSTOTALES;
				if(item==COSTOSTOTALES)return MAXVALUE;	
			}
			if(raiz==MARGENOPERACIONAL)
			{
				if(item==MARGENOPERACIONAL)return MARGENCOMERCIAL;
				if(item==MARGENCOMERCIAL)return TOTALGASTOSADMINISTRATIVOS;
				if(item==TOTALGASTOSADMINISTRATIVOS)return MAXVALUE;	
			}
			if(raiz==RESULTADOANTESDEIMPUESTO)
			{
				if(item==RESULTADOANTESDEIMPUESTO)return MARGENOPERACIONAL;
				if(item==MARGENOPERACIONAL)return GASTOSFINANCIEROS;
				if(item==GASTOSFINANCIEROS)return CORRECCIONMONETARIA;
				if(item==CORRECCIONMONETARIA)return OTROSINGRESOSYGASTOS;
				if(item==OTROSINGRESOSYGASTOS)return MAXVALUE;
			}
			if(raiz==RESULTADO)
			{
				if(item==RESULTADO)return RESULTADOANTESDEIMPUESTO;
				if(item==RESULTADOANTESDEIMPUESTO)return IMPUESTOALARENTA;
				if(item==IMPUESTOALARENTA)return MAXVALUE;
			}
			return MAXVALUE;
		}
		public function CALCULAR(item:int):void
		{
			var i:int;var j:int;
			SET(item);
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].ENE += datos[i].ENE;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].FEB += datos[i].FEB;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].MAR += datos[i].MAR;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].ABR += datos[i].ABR;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].MAY += datos[i].MAY;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].JUN += datos[i].JUN;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].JUL += datos[i].JUL;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].AGO += datos[i].AGO;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].SEP += datos[i].SEP;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].OCT += datos[i].OCT;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].NOV += datos[i].NOV;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].DIC += datos[i].DIC;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	datos[item].PPTO += datos[i].PPTO;
		}
		public function CALCULAR_IMPUESTO():void
		{
			SET(IMPUESTOALARENTA);
			var ene:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].ENE;
			datos[IMPUESTOALARENTA].ENE = ene;
			var feb:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].FEB;
			datos[IMPUESTOALARENTA].FEB = feb;
			var mar:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].MAR;
			datos[IMPUESTOALARENTA].MAR = mar;
			var abr:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].ABR;
			datos[IMPUESTOALARENTA].ABR = abr;
			var may:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].MAY;
			datos[IMPUESTOALARENTA].MAY = may;
			var jun:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].JUN;
			datos[IMPUESTOALARENTA].JUN = jun;
			var jul:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].JUL;
			datos[IMPUESTOALARENTA].JUL = jul;
			var ago:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].AGO;
			datos[IMPUESTOALARENTA].AGO = ago;
			var sep:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].SEP;
			datos[IMPUESTOALARENTA].SEP = sep;
			var oct:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].OCT;
			datos[IMPUESTOALARENTA].OCT = oct;
			var nov:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].NOV;
			datos[IMPUESTOALARENTA].NOV = nov;
			var dic:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].DIC;
			datos[IMPUESTOALARENTA].DIC = dic;
			var ppto:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].PPTO;
			datos[IMPUESTOALARENTA].PPTO = ppto;
		}
		public function CALCULAR_OTROS(numColumns:int):void
		{
			for(var orden:int=VENTASZONAS; orden!=MAXVALUE; orden=next(orden))
			{
				datos[orden].REAL = datos[orden].ENE;
				if(numColumns>=1)datos[orden].REAL += datos[orden].FEB;
		        if(numColumns>=2)datos[orden].REAL += datos[orden].MAR;
		        if(numColumns>=3)datos[orden].REAL += datos[orden].ABR;
		        if(numColumns>=4)datos[orden].REAL += datos[orden].MAY;
		        if(numColumns>=5)datos[orden].REAL += datos[orden].JUN;
		        if(numColumns>=6)datos[orden].REAL += datos[orden].JUL;
		        if(numColumns>=7)datos[orden].REAL += datos[orden].AGO;
		        if(numColumns>=8)datos[orden].REAL += datos[orden].SEP;
		        if(numColumns>=9)datos[orden].REAL += datos[orden].OCT;
		        if(numColumns>=10)datos[orden].REAL += datos[orden].NOV;
		        if(numColumns>=11)datos[orden].REAL += datos[orden].DIC;
   			}
   			
   			calcularREAL(VENTASNETAS);
   			calcularREAL(COSTOSTOTALES);
   			calcularREAL(MARGENCOMERCIAL);
   			calcularREAL(TOTALGASTOSADMINISTRATIVOS);
   			calcularREAL(MARGENOPERACIONAL);
   			calcularREAL(RESULTADOANTESDEIMPUESTO);
   			var real:int = -0.17 * datos[RESULTADOANTESDEIMPUESTO].REAL;
   			datos[IMPUESTOALARENTA].REAL = real;
   			calcularREAL(RESULTADO);
   			calcularDESV();
  		}
  		private function calcularREAL(item:int):void
		{
			datos[item].REAL = 0;
			for(var i:int=sig(item,item); i!=MAXVALUE; i=sig(i,item)) datos[item].REAL += datos[i].REAL;
		}
		private function calcularDESV():void
		{
			for(var indice:int=1; indice!=MAXVALUE; indice++)
			{
				if(indice!=COSTOS && indice!=VENTAS && indice!=GASTOSADMISTRATIVOS)
				{
					var ppto:Number = datos[indice].PPTO;
					var aux:Number;
					if(ppto==0) aux = 0;
					else
					{ 
						if(indice==VENTASNETAS)
							aux = 0;
						aux = datos[indice].REAL;
						aux = aux/ppto;
						aux = aux - 1;
						aux = aux*1000;
					}
					datos[indice].DESV = Math.round(aux)/10;
				}
				if(indice==RESULTADO) indice = MAXVALUE-1;
			}
		}
		
		public function getItemsContables():Array
		{
			var salida:Array = new Array();
			salida.push(datos[VENTASZONAS].itemName);
			salida.push(datos[VENTASPANADERIA].itemName);
			salida.push(datos[DEVOLUCIONESDESCUENTOSBONIFICACIONES].itemName);
			salida.push(datos[RAPELCLIENTE].itemName);
			salida.push(datos[COSTOSINSUMOSZONAS].itemName);
			salida.push(datos[COSTOSINSUMOSPANADERIA].itemName);
			salida.push(datos[MOOPERATIVA].itemName);
			salida.push(datos[GASTOSENERGIA].itemName);
			salida.push(datos[MANTENCION].itemName);
			salida.push(datos[ASEO].itemName);
			salida.push(datos[REMUNERACIONES].itemName);
			salida.push(datos[INDEMNIZACIONES].itemName);
			salida.push(datos[MANTENCIONYARRIENDO].itemName);
			salida.push(datos[ADMINISTRACION].itemName);
			salida.push(datos[TRANSPORTESFLETES].itemName);
			salida.push(datos[GESTIONVENTAS].itemName);
			salida.push(datos[ASESORIAS].itemName);
			salida.push(datos[ADMINISTRACIONCAS].itemName);
			salida.push(datos[DEPRECIACIONES].itemName);
			salida.push(datos[GASTOSFINANCIEROS].itemName);
			salida.push(datos[CORRECCIONMONETARIA].itemName);
			salida.push(datos[OTROSINGRESOSYGASTOS].itemName);
			
			return salida;
		}
		public function getItems():Array
		{
			var salida:Array = new Array();
			for(var i:int=0; i<=RESULTADO; i++)
				salida.push(datos[i].itemName);
			return salida;
		}
		public function default_values():void
		{
			for(var indice:int=1; indice!=MAXVALUE; indice++)
			{
				datos[indice].ENE = "";
				datos[indice].FEB = "";
				datos[indice].MAR = "";
				datos[indice].ABR = "";
				datos[indice].MAY = "";
				datos[indice].JUN = "";
				datos[indice].ENE = "";
				datos[indice].JUL = "";
				datos[indice].AGO = "";
				datos[indice].SEP = "";
				datos[indice].OCT = "";
				datos[indice].NOV = "";
				datos[indice].DIC = "";
				datos[indice].REAL = "";
				datos[indice].PPTO = "";
				datos[indice].DESV = "";
				
				if(indice==RESULTADO) indice = MAXVALUE-1;
			}
		}
	}
}