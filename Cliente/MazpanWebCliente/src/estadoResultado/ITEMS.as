package estadoResultado
{
	import mx.formatters.NumberFormatter;
	
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
		public static const MERMASYAJUSTEDEINVENTARIO:int = 10;
		public static const GASTOSENERGIA:int = 11;
		public static const MANTENCION:int = 12;
		public static const ASEO:int = 13;
		public static const REMUNERACIONES:int = 17;
		public static const INDEMNIZACIONES:int = 18;
		public static const MANTENCIONYARRIENDO:int = 19;
		public static const ADMINISTRACION:int = 20;
		public static const TRANSPORTESFLETES:int = 21;
		public static const GESTIONVENTAS:int = 22;
		public static const ASESORIAS:int = 23;
		public static const ADMINISTRACIONCAS:int = 24;
		public static const DEPRECIACIONES:int = 25;
		public static const GASTOSFINANCIEROS:int = 28;
		public static const CORRECCIONMONETARIA:int = 29;
		public static const OTROSINGRESOSYGASTOS:int = 30;
		public static const IMPUESTOALARENTA:int = 32;
		public static const MAXVALUE:int = 999999;
		
		//Constantes de resultado
		public static const VENTASNETAS:int = 5;
		public static const COSTOSTOTALES:int = 14;
		public static const MARGENCOMERCIAL:int = 15;
		public static const TOTALGASTOSADMINISTRATIVOS:int = 26;
		public static const MARGENOPERACIONAL:int = 27;
		public static const RESULTADOANTESDEIMPUESTO:int = 31;
		public static const RESULTADO:int = 33;
		
		//Contantes de titulo
		public static const VENTAS:int = 0;
		public static const COSTOS:int = 6;
		public static const GASTOSADMISTRATIVOS:int = 16;
		
		
		private var formato:NumberFormatter = new NumberFormatter();
			
		/**
		 * Retorna 999999999 si el elemento es el ultimo de la lista
		 */ 
		public function ITEMS(_datos:Array)
		{
			datos = _datos;
			formato.precision=0;
			formato.useThousandsSeparator=true;
			formato.thousandsSeparatorFrom=".";
			formato.thousandsSeparatorTo=".";
			formato.decimalSeparatorFrom=",";
			formato.decimalSeparatorTo=",";
		}
		 
		public static function next(itemIndex:int):int
		{
			if(itemIndex==VENTASZONAS) return VENTASPANADERIA;
			if(itemIndex==VENTASPANADERIA) return DEVOLUCIONESDESCUENTOSBONIFICACIONES;
			if(itemIndex==DEVOLUCIONESDESCUENTOSBONIFICACIONES) return RAPELCLIENTE;
			if(itemIndex==RAPELCLIENTE) return COSTOSINSUMOSZONAS;
			if(itemIndex==COSTOSINSUMOSZONAS) return COSTOSINSUMOSPANADERIA;
			if(itemIndex==COSTOSINSUMOSPANADERIA) return MOOPERATIVA;
			if(itemIndex==MOOPERATIVA) return MERMASYAJUSTEDEINVENTARIO;
			if(itemIndex==MERMASYAJUSTEDEINVENTARIO) return GASTOSENERGIA;
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
			if(item!=IMPUESTOALARENTA)
			{
				datos[item].MES = 0;
				datos[item].PPTO = 0;
			}
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
				if(item==MOOPERATIVA)return MERMASYAJUSTEDEINVENTARIO;
				if(item==MERMASYAJUSTEDEINVENTARIO)return GASTOSENERGIA;
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
		private function removeFormatting(e:String):String
		{
			var array:Array;
			array = e.split(".");
			return array.join("");
		}
		public function CALCULAR(item:int):void
		{
			var i:int;var j:int;
			SET(item);
			var ene:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	ene += Number(removeFormatting(datos[i].ENE)) as int;
			datos[item].ENE = formato.format(ene);
			
			var feb:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	feb += Number(removeFormatting(datos[i].FEB)) as int;
			datos[item].FEB = formato.format(feb);
			
			var mar:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	mar += Number(removeFormatting(datos[i].MAR)) as int;
			datos[item].MAR = formato.format(mar);
			
			var abr:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	abr += Number(removeFormatting(datos[i].ABR)) as int;
			datos[item].ABR = formato.format(abr);
			
			var may:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	may += Number(removeFormatting(datos[i].MAY)) as int;
			datos[item].MAY = formato.format(may);
			
			var jun:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	jun += Number(removeFormatting(datos[i].JUN)) as int;
			datos[item].JUN = formato.format(jun);
			
			var jul:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	jul += Number(removeFormatting(datos[i].JUL)) as int;
			datos[item].JUL = formato.format(jul);
			
			var ago:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	ago += Number(removeFormatting(datos[i].AGO)) as int;
			datos[item].AGO = formato.format(ago);
			
			var sep:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	sep += Number(removeFormatting(datos[i].SEP)) as int;
			datos[item].SEP = formato.format(sep);
			
			var oct:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	oct += Number(removeFormatting(datos[i].OCT)) as int;
			datos[item].OCT = formato.format(oct);
			
			var nov:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	nov += Number(removeFormatting(datos[i].NOV)) as int;
			datos[item].NOV = formato.format(nov);
			
			var dic:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	dic += Number(removeFormatting(datos[i].DIC)) as int;
			datos[item].DIC = formato.format(dic);
			
			var mes:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	mes += Number(removeFormatting(datos[i].MES)) as int;
			datos[item].MES = formato.format(mes);
			
			var ppto:int = 0;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))	ppto += Number(removeFormatting(datos[i].PPTO)) as int;
			datos[item].PPTO = formato.format(ppto);
			
			var pptoEne:int = 0;
			var pptoFeb:int = 0;
			var pptoMar:int = 0;
			var pptoAbr:int = 0;
			var pptoMay:int = 0;
			var pptoJun:int = 0;
			var pptoJul:int = 0;
			var pptoAgo:int = 0;
			var pptoSep:int = 0;
			var pptoOct:int = 0;
			var pptoNov:int = 0;
			var pptoDic:int = 0;
			
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item))
			{
				if(datos[i].PPTOMENSUAL!=null) 
				{
					pptoEne += Number(removeFormatting(datos[i].PPTOMENSUAL[0])) as int;
					pptoFeb += Number(removeFormatting(datos[i].PPTOMENSUAL[1])) as int;
					pptoMar += Number(removeFormatting(datos[i].PPTOMENSUAL[2])) as int;
					pptoAbr += Number(removeFormatting(datos[i].PPTOMENSUAL[3])) as int;
					pptoMay += Number(removeFormatting(datos[i].PPTOMENSUAL[4])) as int;
					pptoJun += Number(removeFormatting(datos[i].PPTOMENSUAL[5])) as int;
					pptoJul += Number(removeFormatting(datos[i].PPTOMENSUAL[6])) as int;
					pptoAgo += Number(removeFormatting(datos[i].PPTOMENSUAL[7])) as int;
					pptoSep += Number(removeFormatting(datos[i].PPTOMENSUAL[8])) as int;
					pptoOct += Number(removeFormatting(datos[i].PPTOMENSUAL[9])) as int;
					pptoNov += Number(removeFormatting(datos[i].PPTOMENSUAL[10])) as int;
					pptoDic += Number(removeFormatting(datos[i].PPTOMENSUAL[11])) as int;
				}
			}
			var pptoMensual:Array = [0,0,0,0,0,0,0,0,0,0,0,0];	
			
			pptoMensual[0] = formato.format(pptoEne);
			pptoMensual[1] = formato.format(pptoFeb);
			pptoMensual[2] = formato.format(pptoMar);
			pptoMensual[3] = formato.format(pptoAbr);
			pptoMensual[4] = formato.format(pptoMay);
			pptoMensual[5] = formato.format(pptoJun);
			pptoMensual[6] = formato.format(pptoJul);
			pptoMensual[7] = formato.format(pptoAgo);
			pptoMensual[8] = formato.format(pptoSep);
			pptoMensual[9] = formato.format(pptoOct);
			pptoMensual[10] = formato.format(pptoNov);
			pptoMensual[11] = formato.format(pptoDic);
			datos[item].PPTOMENSUAL = pptoMensual;
		}
		public function CALCULAR_IMPUESTO():void
		{
			SET(IMPUESTOALARENTA);
						
			var ene:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].ENE)) as Number;
			datos[IMPUESTOALARENTA].ENE = formato.format(Math.round(ene));
			
			var feb:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].FEB)) as Number;
			datos[IMPUESTOALARENTA].FEB = formato.format(Math.round(feb));
			
			var mar:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].MAR)) as Number;
			datos[IMPUESTOALARENTA].MAR = formato.format(Math.round(mar));
			
			var abr:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].ABR)) as Number;
			datos[IMPUESTOALARENTA].ABR = formato.format(Math.round(abr));
			
			var may:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].MAY)) as Number;
			datos[IMPUESTOALARENTA].MAY = formato.format(Math.round(may));
			
			var jun:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].JUN)) as Number;
			datos[IMPUESTOALARENTA].JUN = formato.format(Math.round(jun));
			
			var jul:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].JUL)) as Number;
			datos[IMPUESTOALARENTA].JUL = formato.format(Math.round(jul));
			
			var ago:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].AGO)) as Number;
			datos[IMPUESTOALARENTA].AGO = formato.format(Math.round(ago));
			
			var sep:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].SEP)) as Number;
			datos[IMPUESTOALARENTA].SEP = formato.format(Math.round(sep));
			
			var oct:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].OCT)) as Number;
			datos[IMPUESTOALARENTA].OCT = formato.format(Math.round(oct));
			
			var nov:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].NOV)) as Number;
			datos[IMPUESTOALARENTA].NOV = formato.format(Math.round(nov));
			
			var dic:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].DIC)) as Number;
			datos[IMPUESTOALARENTA].DIC = formato.format(Math.round(dic));
			
			var mes:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].MES)) as Number;
			datos[IMPUESTOALARENTA].MES = formato.format(Math.round(mes));
			
			var ppto:Number = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].PPTO)) as Number;
			datos[IMPUESTOALARENTA].PPTO = formato.format(Math.round(ppto));
		}
		public function CALCULAR_OTROS(numColumns:int):void
		{
			for(var orden:int=VENTASZONAS; orden!=MAXVALUE; orden=next(orden))
			{
				var real:Number = 0;
				real = Number(removeFormatting(datos[orden].ENE)) as Number;
				if(numColumns>=1)real += Number(removeFormatting(datos[orden].FEB)) as Number;
		        if(numColumns>=2)real += Number(removeFormatting(datos[orden].MAR)) as Number;
		        if(numColumns>=3)real += Number(removeFormatting(datos[orden].ABR)) as Number;
		        if(numColumns>=4)real += Number(removeFormatting(datos[orden].MAY)) as Number;
		        if(numColumns>=5)real += Number(removeFormatting(datos[orden].JUN)) as Number;
		        if(numColumns>=6)real += Number(removeFormatting(datos[orden].JUL)) as Number;
		        if(numColumns>=7)real += Number(removeFormatting(datos[orden].AGO)) as Number;
		        if(numColumns>=8)real += Number(removeFormatting(datos[orden].SEP)) as Number;
		        if(numColumns>=9)real += Number(removeFormatting(datos[orden].OCT)) as Number;
		        if(numColumns>=10)real += Number(removeFormatting(datos[orden].NOV)) as Number;
		        if(numColumns>=11)real += Number(removeFormatting(datos[orden].DIC)) as Number;
		        datos[orden].REAL = formato.format(real);
   			}
   			   			
   			calcularREAL(VENTASNETAS);
   			calcularREAL(COSTOSTOTALES);
   			calcularREAL(MARGENCOMERCIAL);
   			calcularREAL(TOTALGASTOSADMINISTRATIVOS);
   			calcularREAL(MARGENOPERACIONAL);
   			calcularREAL(RESULTADOANTESDEIMPUESTO);
   			
   			var realAcum:int = -0.17 * Number(removeFormatting(datos[RESULTADOANTESDEIMPUESTO].REAL)) as Number;
   			datos[IMPUESTOALARENTA].REAL = formato.format(realAcum);
   			
   			calcularREAL(RESULTADO);
   			
   			
   			
   			calcularDESV();
  		}
  		private function calcularREAL(item:int):void
		{
			var i:int = 0;
			var real:Number = 0;
			var mes:Number = 0;
			
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item)) real += Number(removeFormatting(datos[i].REAL)) as Number;
			for(i=sig(item,item); i!=MAXVALUE; i=sig(i,item)) mes += Number(removeFormatting(datos[i].MES)) as Number;
			
			datos[item].REAL = formato.format(real);
			datos[item].MES = formato.format(mes);
		}
		private function calcularDESV():void
		{
			for(var indice:int=1; indice!=MAXVALUE; indice++)
			{
				if(indice!=COSTOS && indice!=VENTAS && indice!=GASTOSADMISTRATIVOS)//si NO es titulo
				{
					var ppto:Number = Number(removeFormatting(datos[indice].PPTO)) as Number;
					var aux:Number;
					if(ppto==0) aux = 0;
					else
					{ 
						if(indice==VENTASNETAS)
							aux = 0;
						aux = Number(removeFormatting(datos[indice].REAL)) as Number;
						aux = aux/ppto;
						aux = aux - 1;
						aux = aux*1000;
					}
					datos[indice].DESV = formato.format(Math.round(aux)/10);
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
			salida.push(datos[MERMASYAJUSTEDEINVENTARIO].itemName);
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
				datos[indice].MES = "";
				
				if(indice==RESULTADO) indice = MAXVALUE-1;
			}
		}
		public function actualizarMes(mes:int):void
		{
			for(var indice:int=VENTASZONAS; indice!=MAXVALUE; indice=next(indice))
			{
				datos[indice].MES = formato.format(datos[indice].PPTOMENSUAL[mes]);
				
				var ppto:int = 0;
	            for(var m:int=0;m<=mes;m++)
	            {
		            ppto += datos[indice].PPTOMENSUAL[m];
		        }
		        
		        datos[indice].PPTO = formato.format(ppto);
			}
		}
	}
}