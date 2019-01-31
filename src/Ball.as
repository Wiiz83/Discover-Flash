package code
{
	/*****************************************
	 * Casse-briques Balle
	 ****************************************/
	 
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Ball extends Sprite
	{
		//*************************
		// Properties:
		public var angle:Number = 0.0;   	// Direction en radians
		public var speed:Number = 13.0;  	// vitesse en pixels
		public var rebondi:Boolean = false;	// vrai si en train de rebondir
		public var potX:Number = 0.0;		// prochaine position (si pas détournée par rebond)
		public var potY:Number = 0.0;		// prochaine position (si pas détournée par rebond)
				
		//*************************
		// Constructor:
		
		public function Ball()
		{
		}
		
		public function nextpos():Point
		// Calcule la future position de la balle en tenant compte de la vitesse si pas de rebond et du point d'impact si rebond
		{
			if (rebondi) {
				return (new Point(potX, potY));
			} else {
				return (new Point(arrondi(x + speed*Math.cos(angle)), arrondi(y - speed*Math.sin(angle))));
			}
		}
		
		public function place(nx:Number, ny:Number, a:Number):void
		// Positionne la balle à un endroit particulier
		{
			x=nx;
			y=ny;
			angle=a;
		}
		
		public function deplace():void
		// Positionne la balle à sa future position nextpos
		{
			var p:Point;
			p=nextpos();
			place(p.x, p.y, angle);
			}
		
		public function findeplace():void
		// Positionne la balle sur sa position finale après rebonds
		{
			if (rebondi) {
				x=potX;
				y=potY;
				rebondi=false;
				}
		}
				
		public function isrebound(C:Point, D:Point, coef:Number=0):Boolean
		// Calcule si la balle rebondi sur le segment CD (si oui la balle est amenée sur le point d'impact)
		// coef est un coefficient de déformation (pour varier le rebond selon la zone d'impact: pas de variation au centre du segment, variation max à l'extrémité)
		{
			var  T:Point = nextpos();
			var  Bx:Number  = T.x;
			var  By:Number  = T.y;
			var  Cx:Number  = C.x;
			var  Cy:Number  = C.y;
			var  Dx:Number  = D.x;
			var  Dy:Number  = D.y;
			var  d:Number=0;
			var  s,c,l:Number;
			
			l=Math.sqrt((Dx-Cx)*(Dx-Cx)+(Dy-Cy)*(Dy-Cy));  // longueur de CD
			if (l==0) return false;
			s=-(Dy-Cy)/l;		// sinus de l'angle de CD
			c=(Dx-Cx)/l;		// cosinus de l'angle de CD
			var p:Point = intersectsegments(new Point (x, y),T,C,D);  // calcule le point d'intersection du mouvement de la balle avec CD
			if (p==null) 
				return false;
			else
			{
				if (p.x==x && p.y==y)   // la balle est déjà sur le segment
					return false; 		// le rebond a déjà été pris en compte
				if (coef>0) {
					var M:Point = new Point ((Cx+Dx)/2, (Cy+Dy)/2); // milieu de CD
					d= 4*((p.x-M.x)*(Dx-M.x)+(p.y-M.y)*(Dy-M.y))/(l*l); // position normée de p par rapport à MD
				}
				T.x = arrondi((c*c-s*s)*(Bx-p.x)+2*s*c*(By-p.y)+p.x);	// Calcul matriciel (il faut faire une symétrie par rapport à X dans le repère de CD)
				T.y = arrondi(2*s*c*(Bx-p.x)+(s*s-c*c)*(By-p.y)+p.y);
				x=p.x;
				y=p.y;
				potX=T.x;
				potY=T.y;
				angle=2*Math.atan2(Dy-Cy, Dx-Cx)-angle-coef*d*Math.abs(d);
				rebondi=true;
			}
			return true;		
			
		}
		
		public static function arrondi(n:Number):Number {
		// arrondi un nombre à 0.05 près (coordonnées d'un objet sur la scène)
			return Math.round(20*n)/20;
		}
		
		public static function intersectsegments(A:Point, B:Point, C:Point, D:Point):Point
		// renvoie les coordonnées de l'intersection des segments AB et CD ou null si pas d'intersection
		{
			var  Ax:Number  = A.x;
			var  Ay:Number  = A.y;
			var  Bx:Number  = B.x;
			var  By:Number  = B.y;
			var  Cx:Number  = C.x;
			var  Cy:Number  = C.y;
			var  Dx:Number  = D.x;
			var  Dy:Number  = D.y;
			
			var Sx, Sy, pCD, pAB, oCD, oAB :Number ;
			 
			if(Ax==Bx)
			{
				if(Cx==Dx) return null;
				else
				{
					pCD = (Cy-Dy)/(Cx-Dx);
					Sx = Ax;
					Sy = arrondi(pCD*(Ax-Cx)+Cy);
				}
			}
			else
			{
				if(Cx==Dx)
				{
					pAB = (Ay-By)/(Ax-Bx);
					Sx = Cx;
					Sy = arrondi(pAB*(Cx-Ax)+Ay);
				}
				else
				{
					pCD = (Cy-Dy)/(Cx-Dx);
					pAB = (Ay-By)/(Ax-Bx);
					oCD = Cy-pCD*Cx;
					oAB = Ay-pAB*Ax;
					Sx = arrondi((oAB-oCD)/(pCD-pAB));
					Sy = arrondi(pCD*Sx+oCD);
				}
			}
			if ( ((Sx<Ax) && (Sx<Bx)) || ((Sx>Ax) && (Sx>Bx))  || ((Sx<Cx) && (Sx<Dx)) || ((Sx>Cx) && (Sx>Dx)) || ((Sy<Ay) && (Sy<By)) || ((Sy>Ay) && (Sy>By)) || ((Sy<Cy) && (Sy<Dy)) || ((Sy>Cy) && (Sy>Dy))) return null;
			
			return new Point(Sx,Sy)
		}
			
	}
}