package estadoResultado
{
	public class HTTPUtil
	{
	import flash.external.ExternalInterface; 
    import mx.core.Application; 
    import mx.collections.ArrayCollection; 
    import mx.controls.Alert; 
    /** 
     *  
     * Clase que maneja el window del browser de la aplicacion 
     *  
    */ 
		public function HTTPUtil()
		{
		}
	 /** 
       *  
       * Me devuelve la url de la página 
       *  
       */ 
      public function getUrl():String //Debemo usar esta
      { 
         return ExternalInterface.call( "window.location.href.toString" ); 
      } 
      /** 
       *  
       * Me devuelve el host de la pag 
       *  
       * @example: http://www.flexpasta.com/?x=1&y=2 => me devuelve => www.flexpasta.com 
       *  
       */  
      public function getHostName():String 
      { 
         return ExternalInterface.call( "window.location.hostname.toString" ); 
      } 
      /** 
       *  
       * Me devuelve el protocolo (http:, https:, etc) 
       *  
       */ 
      public function getProtocol():String 
      { 
         return ExternalInterface.call( "window.location.protocol.toString" ); 
      }  
      /** 
       *  
       * Me devuelve el puerto de la aplicaicon 
       *  
       */  
      public function getPort():String 
      { 
         return ExternalInterface.call( "window.location.port.toString" ); 
      } 
      /** 
       *  
       * Me devuelve el path relativo a la aplicacion 
       *  
       * @example http://www.ejemplo.com/test?x=1&y=2 => devuelve => /test 
       */
      public function getContext():String 
      { 
         return ExternalInterface.call( "window.location.pathname.toString" ); 
      } 
      /** 
       *  
       * Me devuelve el valor de un parámetro del QueryString 
       *  
       */  
      public function getParameterValue(key:String):String 
      {  
         var value:String; 
         var uparam:String = ExternalInterface.call( "window.location.search.toString" ); 
           
         if(uparam == null) 
         { 
            return null; 
         } 
         var paramArray:ArrayCollection = new ArrayCollection( uparam.split( '&' ) ); 
         for(var x:int = 0; x < paramArray.length ; x++) 
         { 
            var p:String = paramArray.getItemAt( x ) as String; 
            if(p.indexOf( key + '=' ) > -1) 
            { 
               value = (p.replace( (key + '=') , '' )).replace( '?' , '' ); 
               x = paramArray.length; 
            } 
         } 
           
         return value; 
      } 
	}
}