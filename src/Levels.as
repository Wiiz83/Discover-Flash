﻿package code {
	
	public class Levels {
		private var level:Array = new Array;
		
		
		
		public function Levels() {
		
		level[0] = [0];
		
		/*level[1] = [
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,1,1,1,1,1,1,1,1,1,1,1,1,1,0],
		[0,1,0,1,0,1,0,1,0,1,0,1,0,1,0],
		[0,1,1,1,1,1,1,1,1,1,1,1,1,1,0]
		];*/
		
		level[2] = [[2]];
		
		level[2] = 
		[
		 //sécurisation pour affichage clair du score
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		//end.
		[1,1,1,1,1,1,1,1,1,1,1,1,1,1],
		[0,1,1,1,1,1,1,1,1,1,1,1,1,0],
		[0,0,1,1,1,1,1,1,1,1,1,1,0,0],
		[0,0,0,1,1,1,1,1,1,1,1,0,0,0],
		[0,0,0,0,1,1,1,1,1,1,0,0,0,0],
		[0,0,0,0,0,1,1,1,1,0,0,0,0,0],
		[0,0,0,0,0,0,1,1,0,0,0,0,0,0]
		];
		level[1]  = [[1]];
		
		level[1] = [
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,1,1,1,0,0,0,0,0,0],
		[0,0,0,0,1,1,1,1,1,0,0,0,0,0],
		[0,0,0,1,1,1,1,1,1,1,0,0,0,0],
		[0,0,0,0,1,1,1,1,1,0,0,0,0,0],
		[0,0,0,0,0,1,1,1,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		];
		
		}
		
		public function getLevelMatrix(i):Array {
			return level[i];
		}
		
		public function isNextLevel(i):Boolean {
			if(level[i+1]){
				return true;
			}
			return false;
		}

	}
	
}