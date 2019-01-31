package code {
   
        import flash.display.MovieClip;
        import flash.geom.Point;
       

    public class Brick extends MovieClip
    {
        public var cote:Array=new Array;
   
    public function Brick()
    {
    }
   
    public function place(nx:Number,ny:Number):void
        {
            x=nx;
            y=ny;
            cote[0]=[new Point(x-5,y-5), new Point(x+width+5, y-5)]; //haut
            cote[1]=[new Point(x-5,y+height+5), new Point(x+width+5, y+height+5)]; // bas
            cote[2]=[new Point(x+width+5,y-5), new Point(x+width+5,y+height+5)]; //droite
            cote[3]=[new Point(x-5,y-5), new Point(x-5, y+height+5)]; // gauche
        }
       
    public function murProche(ball:Ball):int
        {
            var mur:int = 4;
            var distanceMin:int = 1000;
            var P:Point;
            var distance:int;
           
            for (var i=0; i<4; i++) {               
                P = Ball.intersectsegments(new Point(ball.x,ball.y),ball.nextpos(),cote[i][0],cote[i][1]);
                if (P!=null){
                    distance = (P.x-ball.x)*(P.x-ball.x)+(P.y-ball.y)*(P.y-ball.y);
                    if(distance<distanceMin){
                        distanceMin = distance;
                        mur=i;
                    }
                }
           
            }
            return mur;
        }
    }
}