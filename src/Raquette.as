package code {
	
	import flash.display.Sprite;
	
	public class Raquette extends Sprite {
		
		// Constants:
		// Public Properties:
		// Private Properties:
	
		// Initialization:
		public function Raquette() {
			
			}
			public function place(nx:Number, ny:Number):void
		// Positionne la balle à un endroit particulier
		{
			x=nx;
			y=ny;
			
		}
			
		public function deplace (d:Number) {
			
			x = x + d;
			
			if (x<64)
			{
				x = 64;
			}
			if (x>486)
			{
				x = 486
			}
			
		}
		
	}
	
	
}