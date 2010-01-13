package
{
	import flash.events.Event;
	public class ComplexEvent extends Event
	{
		public static const COMPLEX_CLICK:String="complexClick";
		private var _goStateDestination:String="";
		private var _goStateOrigin:String="";
		private var _objeto:Object=null;
		
		public function ComplexEvent(type:String,_goStateDestination:String,_goStateOrigin:String,_objeto:Object)
		{
			super(type);
			this._goStateDestination=_goStateDestination;
			this._goStateOrigin = _goStateOrigin;
			this._objeto = _objeto;
		}
		
		/**
		 * Retorna el estado al cual queremos ir, el estado de destino
		 */
		public function get goStateDestination():String
		{
			return _goStateDestination;
		}
		
		/**
		 * Retorna el estado al cual pertenecemos, el estado de origen
		 */
		public function get goStateOrigin():String
		{
			return _goStateOrigin;
		}
		
		/**
		 * Retorna el objeto que contiene toda la informacion que queremos enviar
		 */
		public function get objeto():Object
		{
			return _objeto;
		}
	}
}