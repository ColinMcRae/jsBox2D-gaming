PigData = function() {
	this.hp = 10;
	this.minImpulse = 1.6;
};
PigData.prototype.GetType = function() {
	return PIG;
}

PlankData = function() {
	this.hp = 40;
	this.minImpulse = 2.5;
};
PlankData.prototype.GetType = function() {
	return PLANK;
}

StoneData = function() {
	this.hp = 140;
	this.minImpulse = 12;
}
StoneData.prototype.GetType = function() {
	return 'Stone';
}

CannonBallData = function(){
	this.hp = 2000;
	this.minImpulse = 4;
};
CannonBallData.prototype.GetType = function() {
	return 'Cannonball';
}


function createWall(world, size, coo) {
	fixDef = new b2FixtureDef();

	fixDef.density = 0.4;
	fixDef.friction = 0.5;
	fixDef.restitution = 0.2;  

	bodyDef = new b2BodyDef();            
	bodyDef.type = b2Body.b2_staticBody;

	fixDef.shape = new b2PolygonShape;
	fixDef.shape.SetAsBox(size.width, size.height);
	bodyDef.position.Set(coo.x/30, coo.y/30);
	world.CreateBody(bodyDef).CreateFixture(fixDef);
}

function createGround(world, width, height) {
	createWall(world, {width: width, height: 1}, {x: 0, y:height});
	createWall(world, {width: width, height: 1}, {x: 0, y:0});
	createWall(world, {width: 1, height: height}, {x: 0, y:0});
	createWall(world, {width: 1, height: height}, {x: width, y:0});
}

initDraw = function() {
	debugDraw = new b2DebugDraw();

	debugDraw.SetSprite(document.getElementById('canvas').getContext('2d'));
	debugDraw.SetDrawScale(30.0);
	debugDraw.SetFillAlpha(0.5);
	debugDraw.SetLineThickness(1.0);
	debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);
	world.SetDebugDraw(debugDraw);   
}

createPlank = function(x,y, width, height) {
	bodyDef.type = b2Body.b2_dynamicBody;
	fixDef.shape = new b2PolygonShape;
	fixDef.shape.SetAsBox (width, height);	
	fixDef.density = 0.53;
	fixDef.friction = 0.5;
	fixDef.restitution = 0.2;  
	fixDef.fill = 'red';

	bodyDef.position.x = x;
	bodyDef.position.y = y;
	plank = world.CreateBody(bodyDef);
	plank.SetUserData(new PlankData());
	plank.CreateFixture(fixDef);    
}

createStone = function(x,y, width, height) {
	bodyDef.type = b2Body.b2_dynamicBody;
	fixDef.shape = new b2PolygonShape;
	fixDef.shape.SetAsBox (width, height);	
	fixDef.density = 4;
	fixDef.friction = 0.5;
	fixDef.restitution = 0.2;  
	fixDef.fill = 'red';

	bodyDef.position.x = x;
	bodyDef.position.y = y;
	plank = world.CreateBody(bodyDef);
	plank.SetUserData(new PlankData());
	plank.CreateFixture(fixDef);    
}

createPig = function(x, y, r) {
	bodyDef.type = b2Body.b2_dynamicBody;
	fixDef.shape = new b2CircleShape;
	fixDef.shape.SetRadius(r);
	fixDef.restitution = 0.1

	bodyDef.position.x = x;
	bodyDef.position.y = y;
	pig = world.CreateBody(bodyDef);
	pig.SetUserData(new PigData());
	pig.CreateFixture(fixDef);                    
} 

createCannonBall = function (x, y, r) {
	bodyDef.type = b2Body.b2_dynamicBody;
	fixDef.shape = new b2CircleShape;
	fixDef.shape.SetRadius(r);
	
	fixDef.density = 16.0;
	fixDef.friction = 0.5;
	fixDef.restitution = 1.0; 

	bodyDef.position.x = x;
	bodyDef.position.y = y;
	body = world.CreateBody(bodyDef);
	body.SetUserData(new CannonBallData());
	body.CreateFixture(fixDef);                    
}

buildLevel = function() {
	//buildBoxCascade(world, position, plankSize, boxWidth, height = 5, levels = 2)
	buildBoxCascade(world, 20, 1, 1, 0.9, 4);	
	buildBoxCascade(world, 22, 1, 1, 0.9, 4);
	buildBoxCascade(world, 24, 1, 1, 0.9, 4);
	buildBoxCascade(world, 26, 1, 1, 0.9, 4);
	buildBoxCascade(world, 28, 1, 1, 0.9, 4);
	buildBoxCascade(world, 30, 1, 1, 0.9, 4);

	buildSimplePyramide(world, 34, 1.4, 2, 0.9, 3);
	buildSimplePyramide(world, 38, 1.4, 2, 0.9, 3);
	//buildSimplePyramide(world, 28, 1.4, 2, 11, 3);

	//createPlank(22, 20, 0.25, 2);


    //createPig(20,11,0.5);

  }
