package code {
    /*****************************************
* Casse-briques Application principale
****************************************/
import flash.display.MovieClip; // Car notre classe Cassebriques hérite de MovieClip
import flash.events.Event; // Pour gérer les événements ENTER_FRAME
import flash.events.MouseEvent; // Pour gérer les événements CLICK, MOUSE_MOVE
import flash.events.KeyboardEvent; // Pour gérer les événements KEY_DOWN, KEY_UP
import flash.ui.Keyboard; // Contient les codes des touches du clavier
import flash.geom.*; // Définit la classe Point
flash.display.SimpleButton;





public class CasseBriques extends MovieClip {


var ball : Ball;
var started : Boolean = false; 
public var mur : Array = new Array();
public var briques : Array = new Array();
var raquette : Raquette;
var left : Boolean;
var right: Boolean;
public var isGameStarted = false;
public var vies:int = 3;
public var score:int = 0;
public var niveau : Array = new Array();
var level : int = 0;
var restart:Restart = new Restart();


public function CasseBriques() {
    stop();
    mon_Bouton.addEventListener(MouseEvent.CLICK, startGame);
}

public function playagain() {
    stop();
	//Restart.addEventListener(MouseEvent.CLICK, startGame);
}

public function startGame (e:MouseEvent):void 
    
    {
		
        gotoAndStop(2); 
		addEventListener(Event.ENTER_FRAME,enterFrameHandler);
		started = true;
		 
		// creaion de la balle
		ball = new Ball();
		addChild(ball);
        ball.place(270,340,1);

		//creation de la raquette
		raquette = new Raquette ();	
		addChild(raquette);			
		raquette.place(270,370);
		
		//creation des murs (tableau)
		mur [0] =[new Point(520,11.75), new Point(520,406)]; //droit
		mur [1] =[new Point(31,11.75), new Point(31,406)]; //gauche
		mur [2] =[new Point(18.40,25), new Point(530.4,25)]; //haut
		//mur [3] =[new Point(11.75,406), new Point(530.4,406)]; //bas
		
		   //création d'un tableau de briques
            var i: int;
        var j: int;
        var h: int;
        
        niveau [0]= 
                [
                 [1,1,1,1,1,1,1,1,1,1,1],
                 [1,1,1,1,1,1,1,1,1,1,1],
                 [1,1,1,1,1,1,1,1,1,1,1],
                 [1,1,1,1,1,1,1,1,1,1,1]];
                
        niveau [1]= 
                [[0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                 [0,0,0,0,0,0,0,0,0,0,0,0,0,0],
                 [1,1,1,1,1,1,1,1,1,1,1,1,1,0],
                 [1,1,1,1,1,1,1,1,1,1,1,1,1,0],
                 [1,1,1,1,1,1,1,1,1,1,1,1,1,0],
                 [1,1,1,1,1,1,1,1,1,1,1,1,1,0],
                 [1,1,1,1,1,1,1,1,1,1,1,1,1,0]];
                
        
        h=0;
        
        for(i=0; i<niveau[level].length; i++){
            for(j=0; j<niveau[level].length; j++){
                if (niveau[level][i][j]>0){
                    briques[h] = new Brick();
                    briques[h].place(90+briques[h].width*j, 90+briques[h].height*i);
                    addChild(briques[h]);
                    h++;
                }
                
                
            }
        }
		
		//deplacement de la raquette
		stage.focus=this;
            stage.addEventListener(KeyboardEvent.KEY_DOWN,KeyPressHandler);
            stage.addEventListener(KeyboardEvent.KEY_UP,KeyReleaseHandler);
            
		
        }
		


protected function enterFrameHandler(event:Event):void
            {
            // Si la partie a commencé, faire déplacer la raquette
            if (started)
				{
					nombrevie.text = String(vies);
            		moveBall(ball);
            if(left)
					{
                raquette.deplace(-10);
            		}
            if(right) 
					{
                raquette.deplace(+10);
           			}
            	}
			
			//removeChild(restart);
			if (briques.length <1)//s'il n'y a plus de brique
				{ 
					started = false;
					
					removeChild(ball);//enleve la balle
					removeChild(raquette);//enleve la raquette
					gotoAndStop(4);//va a la frame 4
				}
				
			
		}
//deplacer la balle
public function moveBall (b:Ball): void
{
   
    var arebondi : Boolean = false;
    var obstacle : Boolean = false;
    var i : int;
	var A,B,C,D,P:Point;
    var distanceMin,d,murProche:int;
   
    do{
        obstacle = false;
        for (i=0; i< mur.length;i++)
        {
       
        if(b.isrebound (mur[i][0], mur[i][1]))
       		{
            	obstacle = true;
            	arebondi=true;
        	}
		}
		if(ball.y > 380)
			{
				vies = vies - 1;
				nombrevie.text = String(vies);
				init();
			}
		if (b.isrebound(new Point (raquette.x-65, 359), new Point (raquette.x+65,359),1))
			{
				obstacle=true,
				arebondi=true;
			}
			
			        for(var j:int=0; j<briques.length; j++)
		{
            distanceMin = 50000;
            murProche = 5;
           
        for (var k=0;k<4;k++) // pour casser les briques
        {
             A = new Point(ball.x, ball.y);
             B = ball.nextpos();
             C = briques[j].cote[k][0];
             D = briques[j].cote[k][1];
             P = Ball.intersectsegments(A,B,C,D);
         if(P!=null)
             {
                d = (P.x - B.x)*(P.x - B.x)+(P.y - B.y)*(P.y - B.y);
        	 if (d < distanceMin)
		   	    {
            	    distanceMin = d;
                	murProche = k;
             	}
             }
        }
         if(murProche < 4)
             {
        	 if (ball.isrebound(briques[j].cote[murProche][0],briques[j].cote[murProche][1]))
            	{
              	    obstacle = true;
                 	arebondi = true;
                 	removeChild(briques[j]);
					briques.splice(j,1); // suppression du tableau
             		score = score + 100;
					monscore.text = String(score);
				}
				
         	 }
			 //VIE = 0 = Restart, implémentation du bouton.
			 if(vies == 0)
				 	{
				removeChild(raquette);
				removeChild(ball);
				
				/*for(var k:int=0; k<briques.length; k++)
						{
								removeChild(briques[k]);
						}*/
						isGameStarted = false;
						started = false;
						gotoAndStop(3);
						addChild(restart);
						restart.x = 430;
						restart.y = 280;
						score = 0;
						removeChild(monscore);
						vies = 3;
						restart.addEventListener(MouseEvent.CLICK, startGame);
						
					}
			
        }
      } 
	while (obstacle);
		
   		if (arebondi)
    		{
        		b.findeplace ();
        	}
		else
   			{   
        		b.deplace();
        	}
			

			
}
function init () {
	removeChild(ball);
	addChild(ball);
	ball.x = raquette.x;
	ball.y = raquette.y - 20;
}

function KeyPressHandler(event:KeyboardEvent):void {
                switch(event.keyCode){
                    case Keyboard.LEFT:
                    left=true;
                    break;
                    
                    case Keyboard.RIGHT:
                    right=true;
                    break;
                }
            }
            
function KeyReleaseHandler (event:KeyboardEvent):void {
                switch(event.keyCode){
                    case Keyboard.LEFT:
                    left=false;
                    break;
                    
                    case Keyboard.RIGHT:
                    right=false;
                    break;
				}
			}
		}
}
	