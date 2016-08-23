//= require lib/Box2D

const PIG = 'pig';
const BIRD = 'bird';
const PLANK = 'plank';
var startTimer;

isMouseDown = false;

mouseJoint = false;

body = false;
mousePosition = {x:0,y:0};

b2AABB  = Box2D.Collision.b2AABB;
b2World = Box2D.Dynamics.b2World;
b2Vec2 = Box2D.Common.Math.b2Vec2;
b2DebugDraw = Box2D.Dynamics.b2DebugDraw;
b2Body = Box2D.Dynamics.b2Body;
b2BodyDef = Box2D.Dynamics.b2BodyDef;
b2FixtureDef = Box2D.Dynamics.b2FixtureDef;
b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape;
b2CircleShape = Box2D.Collision.Shapes.b2CircleShape;
b2MouseJointDef = Box2D.Dynamics.Joints.b2MouseJointDef;
b2ContactListener = Box2D.Dynamics.b2ContactListener;

world =  new b2World(
new b2Vec2(0, 10)
,true
);

// TODO Make hit points

GameContactListener = function() {};
GameContactListener.prototype = b2ContactListener.prototype;

GameContactListener.prototype.PostSolve = function(contact, impulse) {
    if(contact.GetFixtureB().GetBody().GetUserData()) {
        var BangedBody = contact.GetFixtureB().GetBody();        
        var imp = 0;
        for(a in impulse.normalImpulses) {
            imp = imp + impulse.normalImpulses[a];
        }

        if(imp > BangedBody.GetUserData().minImpulse && startTimer <= 0) {

            BangedBody.GetUserData().hp -= imp;
            console.log(BangedBody.GetUserData().GetType() + ' got ' + imp + ' hp left ' + BangedBody.GetUserData().hp);
            if (BangedBody.GetUserData().hp < 0) {
                destroyedBodies.push(BangedBody);
                BangedBody.visible = false;
                BangedBody = null;    
            }                
        }       
    }

    var contactListener = new GameContactListener();
    world.SetContactListener(contactListener); 
};

update = function() {
    if (startTimer > 0) { startTimer -=1; }    
    destroyedBodies = Array(); 
    if(isMouseDown) {
        if(!(body)) {
            mousePosition = {x:mouseX, y:mouseY};
            createCannonBall(mouseX, mouseY, 0.40);
            body = getBodyAtMouse();

            md = new b2MouseJointDef();
            md.bodyA = world.GetGroundBody();
            md.bodyB = body;
            md.target.Set(mousePosition.x, mousePosition.y);
            md.collideConnected = true;
            md.maxForce = 600.0 * body.GetMass();
            mouseJoint = world.CreateJoint(md);
            body.SetAwake(true);                     
        }

        body.SetPosition(new b2Vec2(mouseX, mouseY));
    }

    if(mouseJoint && !isMouseDown) {
        mouseX = mousePosition.x;
        mouseY = mousePosition.y;
        if(getBodyAtMouse()) {
          world.DestroyJoint(mouseJoint);
          mouseJoint = null;
          body = false;
      }
  }    

    world.Step(1/60, 10, 10);
    world.DrawDebugData();
    world.ClearForces();            
    while(destroyedBodies.length > 0) {
        world.DestroyBody(destroyedBodies.shift());
    }
}


init = function() {
   initDraw();
   var canvas = $('canvas');   
   createGround(world, canvas.width(), canvas.height());
   startTimer = 120;
   debugger
   buildLevel();
   bindMouse();

   window.setInterval(update, 1000 / 60);
}  

/*
************* MOUSE
*/


bindMouse = function() {
    $(document).mousedown(function(e){        
        isMouseDown = true;
        handleMouse(e);
        $(document).bind('mousemove', {}, handleMouse);
    });

    $(document).mouseup(function(e){
        isMouseDown = false;
        $(document).unbind('mousemove');
    });                               
}

handleMouse = function(e) {
    var rect = canvas.getBoundingClientRect();
    mouseX = (e.clientX - rect.left) / 30;
    mouseY = (e.clientY - rect.top) / 30;
};

function getBodyAtMouse() {
    mousePVec = new b2Vec2(mouseX, mouseY);

    var aabb = new b2AABB();
    aabb.lowerBound.Set(mouseX - 0.001, mouseY - 0.001);
    aabb.upperBound.Set(mouseX + 0.001, mouseY + 0.001);

    selectedBody = null;
    world.QueryAABB(getBodyCallback, aabb);
    return selectedBody;
}            

getBodyCallback = function(fixture) {
    if(fixture.GetBody().GetType() != b2Body.b2_staticBody) {
     if(fixture.GetShape().TestPoint(fixture.GetBody().GetTransform(), mousePVec)) {
      selectedBody = fixture.GetBody();
      return false;
      }
    }
    return true;
};

/************** GAME**********/
console.log('game loaded');
init();
console.log('game inited');

